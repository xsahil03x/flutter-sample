import 'package:com_cingulo_sample/common/bloc.dart';
import 'package:com_cingulo_sample/models/accounts/sign_up_model.dart';
import 'package:rxdart/rxdart.dart';

class SignUpFormBloc extends ABloc<SignUpFormBlocState> {
  SignUpFormBloc() : super(states$$: PublishSubject<SignUpFormBlocState>());

  void signUp(SignUpModel model) {
    catchError(() async {
      await di.accountsRepository.signUp(model);
      states$$?.add(SignUpFormBlocSuccess());
      // AppAnalytics.instance.doSomething();
    });
  }
}

abstract class SignUpFormBlocState extends ABlocState {}

class SignUpFormBlocSuccess extends SignUpFormBlocState {}
