import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/core/navigator/navigator_route.dart';
import 'package:star_wars_app/core/widgets/infinite_list.dart';
import 'package:star_wars_app/core/widgets/refresh_indicator.dart';
import 'package:star_wars_app/features/characters/data/model/sw_gender_model.dart';
import 'package:star_wars_app/features/characters/domain/entities/sw_character.dart';
import 'package:star_wars_app/features/characters/presentation/bloc/sw_list/sw_list_bloc.dart';
import 'package:star_wars_app/features/characters/presentation/bloc/sw_list/sw_list_state.dart';
import 'package:star_wars_app/features/characters/presentation/widgets/sw_filter.dart';
import 'package:star_wars_app/features/characters/sw_route.dart';
import 'package:star_wars_app/features/characters/sw_router.dart';
import 'package:star_wars_app/features/characters/sw_utils.dart';

class SWMainPage extends StatefulWidget {
  const SWMainPage({super.key});

  @override
  State<SWMainPage> createState() => _SWMainPageState();
}

class _SWMainPageState extends State<SWMainPage> {
  final scrollController = ScrollController();
  Gender? filter;

  List<Character> filterByGender(List<Character> values) {
    if (filter == null) {
      return values;
    }
    return values.where((element) => element.gender == filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SWListBloc<Character>>().state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Star Wars Characters'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SWFilter(
            onFilterChanged: (filter) {
              setState(() {
                this.filter = filter;
              });
            },
          ),
          Expanded(
              child: CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              filter != null
                  ? const SliverToBoxAdapter()
                  : CupertinoSliverRefreshControl(
                      refreshIndicatorExtent: 16,
                      builder: refreshIndicator,
                      onRefresh: () async {
                        SWUtils.instance.character.update(context, null);
                      }),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 8,
                ),
              ),
              filter == null ? _infinityList(state) : _filterList(state),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 96,
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _filterList(SWListState<Character> state) {
    List<Character> values = filterByGender(state.values);
    return SliverList.builder(
      itemCount: values.length,
      itemBuilder: (context, index) {
        final item = values[index];
        return _itemBuilder(context, item);
      },
    );
  }

  Widget _infinityList(SWListState<Character> state) {
    return InfiniteList(
      itemCount: state.values.length,
      onFetchData: () => SWUtils.instance.character.fetch(context, null),
      isLoading: state.status.isLoading,
      hasError: state.message.isNotEmpty,
      hasReachedMax: state.hasReachedMax,
      loadingBuilder: (context) => _loadingBuilder(context),
      errorBuilder: (context) => _errorBuilder(context),
      emptyBuilder: (context) => _emptyBuilder(context),
      itemBuilder: (context, index) {
        final item = state.values[index];
        return _itemBuilder(context, item);
      },
    );
  }

  Widget _errorBuilder(BuildContext context) {
    return const Center(
      child: Text(
        'Error',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _loadingBuilder(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _emptyBuilder(BuildContext context) {
    return const Center(
      child: Text('No data found'),
    );
  }

  Widget _itemBuilder(BuildContext context, Character item) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
        padding: const EdgeInsets.all(8),
        child: Center(
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(-15 / 360),
            child: Text(item.name.substring(0, 2),
                style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      title: Text(item.name),
      subtitle: Text(
        item.gender.toName,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      onTap: () {
        NavigatorRouter.pushNamed(
          SubRouteSwType.details,
          router: swRoute,
          arguments: item,
        );
      },
    );
  }
}
