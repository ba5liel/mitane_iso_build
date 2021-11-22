// @dart=2.9
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_otp/flutter_otp.dart';

import 'package:mitane_frontend/application/auth/events/auth_events.dart';
import 'package:mitane_frontend/application/auth/states/auth_state.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/domain/auth/validation/invalid_validation.dart';
import 'package:mitane_frontend/infrastructure/auth/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  //final FlutterOtp otp;
  AuthBloc(
    this.authRepository,
    /* this.otp */
  ) : super(InitState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield LoggingIn();

      User user = await authRepository.signIn(event.login);
      currentUser = user;
      yield LoginSuccess(user: user);
    } else if (event is NextButtonPressed) {
      final phone = event.phone;
      if (phone.length == 9) {
        print(phone);
        try {
          /*  otp.sendOtp(phone, null, 1000, 9000, dialCode); */
          yield OTPMessageSend();
        } catch (e) {
          RegisterError("insert correct phone number");
        }
      }
    } else if (event is VerificationButtonPressed) {
      /* final verification = event.verificationCode;
      /* final verified = otp.resultChecker(int.parse(verification)); */
      if (verified)
        yield VerificationSuccessful();
      else
        yield RegisterError("Wrong verification code"); */
    } else if (event is RegisterEvent) {
      yield Registering();

      print('registering');
      bool res = await authRepository.signUp(event.register);
      if (res) {
        print("created successfuly");
        yield RegisterSuccess();
      }
    }
  }
}
