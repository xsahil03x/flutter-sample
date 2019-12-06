import 'dart:io';

import 'package:flutter/material.dart';

import '../../../common/widget.dart';
import '../../../models/accounts/sign_up_model.dart';
import '../../../services/router_service.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/fields.dart';
import '../../splash/splash_route.dart';
import 'sign_up_form_bloc.dart';
import 'sign_up_l10n.dart';

class SignUpForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends AStatefulWBL<SignUpForm, SignUpFormBloc, SignUpL10n> {
  @override
  final SignUpFormBloc bloc = SignUpFormBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _fullNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _isProcessing = false;
  SignUpModelError _signUpModelError;

  @override
  void initState() {
    super.initState();
    disposableFunctions.addAll([
      _usernameController.dispose,
      _fullNameController.dispose,
      _emailController.dispose,
      _passwordController.dispose,
      _fullNameFocus.dispose,
      _emailFocus.dispose,
      _passwordFocus.dispose,
    ]);
    bloc.states$.listen(_onData, onError: _onError);
  }

  void _onData(SignUpFormBlocState state) {
    if (state is SignUpFormBlocSuccess) {
      RouterService.instance.navigateTo(SplashRoute.buildPath());
    }
  }

  void _onError(Object error) {
    setState(() {
      _isProcessing = false;
      _signUpModelError = error is SignUpModelError ? error : null;
      _formKey.currentState.validate();
    });
  }

  void _onSubmit() {
    if (!_isProcessing) {
      setState(() {
        _isProcessing = true;
        final model = SignUpModel(
          username: _usernameController.value.text,
          fullName: _fullNameController.value.text,
          email: _emailController.value.text,
          password: _passwordController.value.text,
          language: SignUpModel.languageEnUs, // TODO: remove hardcoded entry
          timeZone: SignUpModel.timeZoneASP, // TODO: remove hardcoded entry
          platform: Platform.isAndroid ? SignUpModel.platformAndroid : SignUpModel.platformIOS,
        );
        bloc.signUp(model);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextInput(
            labelText: l10n.formUsername,
            controller: _usernameController,
            validator: (_) => _signUpModelError?.username,
            enabled: !_isProcessing,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_fullNameFocus),
          ),
          TextInput(
            focusNode: _fullNameFocus,
            labelText: l10n.formFullName,
            controller: _fullNameController,
            validator: (_) => _signUpModelError?.fullName,
            enabled: !_isProcessing,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_emailFocus),
          ),
          TextInput(
            focusNode: _emailFocus,
            labelText: l10n.formEmail,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            validator: (_) => _signUpModelError?.email,
            enabled: !_isProcessing,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocus),
          ),
          PasswordInput(
            focusNode: _passwordFocus,
            labelText: l10n.formPassword,
            controller: _passwordController,
            validator: (_) => _signUpModelError?.password,
            enabled: !_isProcessing,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _onSubmit(),
          ),
          Container(height: 24),
          ButtonPrimary(
            text: l10n.formSubmit,
            onPressed: _onSubmit,
            disabled: _isProcessing,
            themeData: Theme.of(context),
          ),
        ],
      ),
    );
  }
}
