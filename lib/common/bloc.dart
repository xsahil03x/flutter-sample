import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'dependency_injection.dart';
import 'disposable.dart';

abstract class ABloc<T extends ABlocState> with ADisposeMixin, ADependencyInjectionMixin {
  @protected
  @visibleForTesting
  Subject<T> states$$;
  Stream<T> get states$ => states$$.stream;

  ABloc({@required Subject<T> states$$}) {
    this.states$$ = states$$;
    disposableFunctions.addAll([states$$.close, () => this.states$$ = null]);
    init();
  }

  @protected
  @mustCallSuper
  void init() {
    inject();
  }

  @protected
  @override
  @mustCallSuper
  void diReady() {
    catchError(() async => postInit());
  }

  @protected
  void postInit() {}

  @protected
  void catchError(Future<void> Function() run) async {
    try {
      await run();
    } catch (error, stackTrace) {
      states$$?.addError(error, stackTrace);
    }
  }
}

abstract class ABlocState {}
