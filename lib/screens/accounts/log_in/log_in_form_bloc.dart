import 'package:com_cingulo_sample/common/bloc.dart';
import 'package:com_cingulo_sample/models/accounts/log_in_model.dart';
import 'package:rxdart/rxdart.dart';

class LogInFormBloc extends ABloc<LogInFormBlocState> {
  LogInFormBloc() : super(states$$: PublishSubject<LogInFormBlocState>());

  void logIn(LogInModel model) {
    catchError(() async {
      await di.accountsRepository.logIn(model);
      states$$?.add(LogInFormBlocSuccess());
      // AppAnalytics.instance.doSomething();
    });
  }
}

abstract class LogInFormBlocState extends ABlocState {}

class LogInFormBlocSuccess extends LogInFormBlocState {}
