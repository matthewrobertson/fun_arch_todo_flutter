import 'package:flutter/widgets.dart';
import 'package:fun_arch_todo_flutter/env.dart';
import 'package:fun_arch_todo_flutter/models/app_state.dart';

class ConnectState<T> extends StatelessWidget {
  final T Function(AppState state) map;
  final bool Function(T prev, T next) where;
  final Widget Function(T state) builder;

  ConnectState({
    Key key,
    @required this.map,
    @required this.where,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: Env.store.state$
          .map(map)
          .distinct((T prev, T next) => !where(prev, next)),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }

        return builder(snapshot.data);
      },
    );
  }
}
