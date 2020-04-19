import 'dart:async';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:quiz_of_football/model/vsgame.dart';
import 'package:rxdart/rxdart.dart';

class VSGameBloc implements BlocBase {
  //sink = input   stream=output
  final _vsGameStreamController = BehaviorSubject<List<VSGame>>();

//  final _wallpaperStreamController = StreamController<List<Wallpaper>>();

  // final StreamController<List<Wallpaper>> _wallpaperStreamController =
  //     StreamController<List<Wallpaper>>();

  Sink<List<VSGame>> get sink => _vsGameStreamController.sink;

  Stream<List<VSGame>> get stream => _vsGameStreamController.stream;

//  final schoolsSubject = BehaviorSubject<List<Wallpaper>>();

  VSGameBloc() {
    print("listen");

//    _wallpaperStreamController.close();
//    _wallpaperStreamController.stream.listen(null);
  }

  void onData(String event) {}

  @override
  void dispose() {
    _vsGameStreamController.close();
    print("closed");
  }

  void _handleCommand(String event) {
//    sink.add("2");
  }
}

Type _typeOf<T>() => T;

abstract class BlocBase {
  void dispose();
}

// 1
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  // 2
  static T of<T extends BlocBase>(BuildContext context) {
    final type = _providerType<BlocProvider<T>>();
    final BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  // 3
  static Type _providerType<T>() => T;

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  // 4
  @override
  Widget build(BuildContext context) => widget.child;

  // 5
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

//class BlocProvider<T extends BlocBase> extends StatefulWidget {
//  BlocProvider({
//    Key key,
//    @required this.child,
//    @required this.bloc,
//  }) : super(key: key);
//
//  final Widget child;
//  final T bloc;
//
//  @override
//  _BlocProviderState<T> createState() => _BlocProviderState<T>();
//
//  static T of<T extends BlocBase>(BuildContext context) {
//    final type = _typeOf<_BlocProviderInherited<T>>();
//    _BlocProviderInherited<T> provider =
//        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
//    return provider?.bloc;
//  }
//}
//
//class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
//  @override
//  void dispose() {
//    widget.bloc?.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new _BlocProviderInherited<T>(
//      bloc: widget.bloc,
//      child: widget.child,
//    );
//  }
//}
//
//class _BlocProviderInherited<T> extends InheritedWidget {
//  _BlocProviderInherited({
//    Key key,
//    @required Widget child,
//    @required this.bloc,
//  }) : super(key: key, child: child);
//
//  final T bloc;
//
//  @override
//  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
//}
