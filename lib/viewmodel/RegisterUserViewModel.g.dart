// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterUserViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterUserViewModel on _RegisterUserViewModel, Store {
  late final _$errorMessageAtom =
      Atom(name: '_RegisterUserViewModel.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$isRegisteringUserAtom =
      Atom(name: '_RegisterUserViewModel.isRegisteringUser', context: context);

  @override
  bool get isRegisteringUser {
    _$isRegisteringUserAtom.reportRead();
    return super.isRegisteringUser;
  }

  @override
  set isRegisteringUser(bool value) {
    _$isRegisteringUserAtom.reportWrite(value, super.isRegisteringUser, () {
      super.isRegisteringUser = value;
    });
  }

  late final _$registerUserAsyncAction =
      AsyncAction('_RegisterUserViewModel.registerUser', context: context);

  @override
  Future<dynamic> registerUser(AppUser user, File? image) {
    return _$registerUserAsyncAction.run(() => super.registerUser(user, image));
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
isRegisteringUser: ${isRegisteringUser}
    ''';
  }
}
