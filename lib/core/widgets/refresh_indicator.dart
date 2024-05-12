import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget refreshIndicator(
    BuildContext context,
    RefreshIndicatorMode refreshState,
    double pulledExtent,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent) {
  return Center(
      child: RefreshProgressIndicator(
    strokeWidth: 2.0,
    value: refreshState == RefreshIndicatorMode.drag
        ? pulledExtent / refreshTriggerPullDistance > 0.5
            ? pulledExtent / refreshTriggerPullDistance
            : null
        : null,
    color: Theme.of(context).primaryColor.withOpacity(
          (pulledExtent / refreshTriggerPullDistance)
              .clamp(0.0, 1.0)
              .toDouble(),
        ),
  ));
}
