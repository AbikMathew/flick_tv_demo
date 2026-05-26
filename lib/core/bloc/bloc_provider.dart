import 'package:flutter/widgets.dart';
import 'cubit.dart';

class BlocProvider<T extends Cubit<dynamic>> extends StatefulWidget {
  const BlocProvider({
    super.key,
    required this.create,
    required this.child,
  });

  final T Function(BuildContext context) create;
  final Widget child;

  static T of<T extends Cubit<dynamic>>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<_InheritedBlocProvider<T>>();
    if (provider == null) {
      throw FlutterError(
        'BlocProvider.of() called with a context that does not contain a BlocProvider of type $T.',
      );
    }
    return provider.cubit;
  }

  @override
  State<BlocProvider<T>> createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T extends Cubit<dynamic>> extends State<BlocProvider<T>> {
  late final T _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = widget.create(context);
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedBlocProvider<T>(
      cubit: _cubit,
      child: widget.child,
    );
  }
}

class _InheritedBlocProvider<T extends Cubit<dynamic>> extends InheritedWidget {
  const _InheritedBlocProvider({
    required this.cubit,
    required super.child,
  });

  final T cubit;

  @override
  bool updateShouldNotify(_InheritedBlocProvider<T> oldWidget) {
    return cubit != oldWidget.cubit;
  }
}

class BlocBuilder<C extends Cubit<S>, S> extends StatelessWidget {
  const BlocBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, S state) builder;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<C>(context);
    return StreamBuilder<S>(
      stream: cubit.stream,
      initialData: cubit.state,
      builder: (context, snapshot) {
        return builder(context, snapshot.data as S);
      },
    );
  }
}
