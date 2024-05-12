import 'package:flutter/material.dart';
import 'package:star_wars_app/core/widgets/debounce.dart';

class InfiniteList extends StatefulWidget {
  final int itemCount;
  final VoidCallback onFetchData;
  final bool isLoading;
  final bool hasError;
  final bool hasReachedMax;
  final Widget Function(BuildContext context) loadingBuilder;
  final Widget Function(BuildContext context) errorBuilder;
  final Widget Function(BuildContext context) emptyBuilder;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const InfiniteList({
    super.key,
    required this.itemCount,
    required this.onFetchData,
    this.isLoading = false,
    this.hasError = false,
    this.hasReachedMax = false,
    required this.loadingBuilder,
    required this.errorBuilder,
    required this.emptyBuilder,
    required this.itemBuilder,
  });

  @override
  State<InfiniteList> createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
  late final CallbackDebouncer debounce;

  int? _lastFetchedIndex;

  @override
  void initState() {
    super.initState();
    debounce = CallbackDebouncer(const Duration(milliseconds: 100));
    attemptFetch();
  }

  @override
  void didUpdateWidget(InfiniteList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.hasReachedMax && oldWidget.hasReachedMax) {
      attemptFetch();
    }
  }

  @override
  void dispose() {
    super.dispose();
    debounce.dispose();
  }

  void attemptFetch() {
    if (!widget.hasReachedMax && !widget.isLoading && !widget.hasError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        debounce(widget.onFetchData);
      });
    }
  }

  void onBuiltLast(int lastItemIndex) {
    if (_lastFetchedIndex != lastItemIndex) {
      _lastFetchedIndex = lastItemIndex;
      attemptFetch();
    }
  }

  Widget sliverFillRemaining(Widget child) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasItems = widget.itemCount != 0;
    bool showEmpty = !widget.isLoading && widget.itemCount == 0;
    bool showBottomWidget = showEmpty || widget.isLoading || widget.hasError;
    int effectiveItemCount =
        (!hasItems ? 0 : widget.itemCount) + (showBottomWidget ? 1 : 0);
    int lastItemIndex = effectiveItemCount - 1;

    if (widget.isLoading && effectiveItemCount == 1) {
      return sliverFillRemaining(widget.loadingBuilder(context));
    } else if (widget.hasError) {
      return sliverFillRemaining(widget.errorBuilder(context));
    } else if (showEmpty) {
      return sliverFillRemaining(widget.emptyBuilder(context));
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: effectiveItemCount,
        (context, index) {
          if (index == lastItemIndex) {
            onBuiltLast(lastItemIndex);
          }
          if (index == lastItemIndex && showBottomWidget) {
            if (widget.hasError) {
              return widget.errorBuilder(context);
            } else if (widget.isLoading) {
              return widget.loadingBuilder(context);
            } else {
              return widget.emptyBuilder(context);
            }
          } else {
            return widget.itemBuilder(context, index);
          }
        },
      ),
    );
  }
}
