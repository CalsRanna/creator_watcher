import 'package:creator/creator.dart';
import 'package:flutter/material.dart';

class CreatorWatcher<T> extends StatelessWidget {
  const CreatorWatcher({
    super.key,
    required this.builder,
    required this.creator,
  });

  final Creator<T> creator;
  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    return Watcher((context, ref, _) => builder(context, ref.watch(creator)));
  }
}

class EmitterWatcher<T> extends StatelessWidget {
  const EmitterWatcher({
    super.key,
    required this.emitter,
    this.indicator,
    this.placeholder,
    required this.builder,
    this.errorBuilder,
  });

  final Emitter<T> emitter;
  final Widget? indicator;
  final Widget? placeholder;
  final Widget Function(BuildContext, T) builder;
  final Widget Function(BuildContext, String)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    return Watcher((context, ref, _) {
      const defaultPlaceholder = Center(child: Text('暂无内容'));
      const defaultIndicator = Center(
        child: CircularProgressIndicator.adaptive(),
      );

      try {
        final asyncData = ref.watch(emitter.asyncData);
        if (asyncData.status == AsyncDataStatus.active) {
          final state = asyncData.data;
          if (state != null) {
            if (state is List && state.isEmpty) {
              return placeholder ?? defaultPlaceholder;
            } else {
              return builder(context, state);
            }
          } else {
            return placeholder ?? defaultPlaceholder;
          }
        } else {
          return indicator ?? defaultIndicator;
        }
      } catch (error) {
        var errorWidget = errorBuilder?.call(context, error.toString());
        return errorWidget ?? Text(error.toString());
      }
    });
  }
}
