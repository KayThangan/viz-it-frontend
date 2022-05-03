import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

int count = 0;

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T state, Widget? child) builder;
  final T state;
  final Widget? child;
  final Function(T?)? onStateReady;
  final Function(T?)? onDispose;

  BaseWidget({
    Key? key,
    required this.builder,
    required this.state,
    this.child,
    this.onStateReady,
    this.onDispose,
  }) : super(key: key);

  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  T? state;

  int? index;

  @override
  void initState() {
    state = widget.state;

    count += 1;
    index = count;

    if (widget.onStateReady != null) {
      //WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onStateReady!(state);
      //});
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!(state);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: widget.builder,
      child: widget.child,
    );
  }
}
