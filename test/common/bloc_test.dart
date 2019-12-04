import 'package:com_cingulo_sample/common/bloc.dart';
import 'package:com_cingulo_sample/common/dependency_injection.dart';
import 'package:com_cingulo_sample/common/disposable.dart';
import 'package:com_cingulo_sample/errors/model_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/subjects.dart';

class _ABlocState extends ABlocState {}

class _ABloc extends ABloc<_ABlocState> {
  final bool postInitThrowException;

  bool didCallInit = false;
  bool didCallInject = false;
  bool didCallDiReady = false;
  bool didCallPostInit = false;
  bool didCallPostInitWithCatchError = false;

  _ABloc({this.postInitThrowException = false}) : super(states$$: BehaviorSubject<_ABlocState>());

  @override
  void init() {
    didCallInit = true;
    super.init();
  }

  @override
  Future<void> inject() async {
    didCallInject = true;
    await super.inject();
  }

  @override
  void diReady() {
    didCallDiReady = true;
    super.diReady();
  }

  @override
  void postInit() {
    didCallPostInit = true;
    if (postInitThrowException) {
      throw ModelError('');
    }
  }

  void catchErrorIsCatchingErrors() {
    catchError(() {
      throw ModelError('');
    });
  }
}

void main() {
  group('Bloc', () {
    test('extends Bloc<BlocState>', () {
      final bloc = _ABloc();
      expect(bloc, isA<ABloc<ABlocState>>());
    });

    test('with DisposeMixin', () {
      final bloc = _ABloc();
      expect(bloc, isA<ADisposeMixin>());
    });

    test('with DependencyInjectionMixin', () {
      final bloc = _ABloc();
      expect(bloc, isA<ADependencyInjectionMixin>());
    });

    test('statesDD is a Subject<T>', () {
      final bloc = _ABloc();
      expect(bloc.states$, isA<Subject<_ABlocState>>());
    });

    test('statesD is a Stream<T>', () {
      final bloc = _ABloc();
      expect(bloc.states$, isA<Stream<_ABlocState>>());
    });

    test('did dispose statesDD', () {
      final bloc = _ABloc();
      final states$$ = bloc.states$$; // ignore: close_sinks
      expect(states$$.isClosed, false);
      expect(bloc.states$$, isNot(null));
      bloc.dispose();
      expect(states$$.isClosed, true);
      expect(bloc.states$$, null);
    });

    test('did call init()', () {
      final bloc = _ABloc();
      expect(bloc.didCallInit, true);
    });

    test('init() did call inject()', () {
      final bloc = _ABloc();
      expect(bloc.didCallInject, true);
    });

    test('inject() did call diReady()', () async {
      final bloc = _ABloc();
      await Future.delayed(Duration(milliseconds: 100));
      expect(bloc.didCallDiReady, true);
    });

    test('diReady() did call postInit()', () async {
      final bloc = _ABloc();
      await Future.delayed(Duration(milliseconds: 100));
      expect(bloc.didCallPostInit, true);
    });

    test('diReady() did call postInit() with catchError()', () async {
      Object error;
      final bloc = _ABloc(postInitThrowException: true);
      bloc.states$.listen((_) {}, onError: (e) => error = e);
      await Future.delayed(Duration(milliseconds: 100));
      expect(error, isA<ModelError>());
    });

    test('catchError() is catching errors', () async {
      Object error;
      final bloc = _ABloc();
      bloc.states$.listen((_) {}, onError: (e) => error = e);
      await Future.delayed(Duration(milliseconds: 100));
      expect(error, null);
      bloc.catchErrorIsCatchingErrors();
      await Future.delayed(Duration(milliseconds: 100));
      expect(error, isA<ModelError>());
    });
  });
}
