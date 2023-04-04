// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthUserViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthUserViewModel on _AuthUserViewModel, Store {
  late final _$isUserLoggingAtom =
      Atom(name: '_AuthUserViewModel.isUserLogging', context: context);

  @override
  bool get isUserLogging {
    _$isUserLoggingAtom.reportRead();
    return super.isUserLogging;
  }

  @override
  set isUserLogging(bool value) {
    _$isUserLoggingAtom.reportWrite(value, super.isUserLogging, () {
      super.isUserLogging = value;
    });
  }

  late final _$loginLoadingAtom =
      Atom(name: '_AuthUserViewModel.loginLoading', context: context);

  @override
  bool get loginLoading {
    _$loginLoadingAtom.reportRead();
    return super.loginLoading;
  }

  @override
  set loginLoading(bool value) {
    _$loginLoadingAtom.reportWrite(value, super.loginLoading, () {
      super.loginLoading = value;
    });
  }

  late final _$signingUpAtom =
      Atom(name: '_AuthUserViewModel.signingUp', context: context);

  @override
  bool get signingUp {
    _$signingUpAtom.reportRead();
    return super.signingUp;
  }

  @override
  set signingUp(bool value) {
    _$signingUpAtom.reportWrite(value, super.signingUp, () {
      super.signingUp = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_AuthUserViewModel.currentUser', context: context);

  @override
  AppUser? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(AppUser? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$messageErrorAtom =
      Atom(name: '_AuthUserViewModel.messageError', context: context);

  @override
  String get messageError {
    _$messageErrorAtom.reportRead();
    return super.messageError;
  }

  @override
  set messageError(String value) {
    _$messageErrorAtom.reportWrite(value, super.messageError, () {
      super.messageError = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthUserViewModel.login', context: context);

  @override
  Future<void> login(AppUser user) {
    return _$loginAsyncAction.run(() => super.login(user));
  }

  late final _$checkLoggedUserAsyncAction =
      AsyncAction('_AuthUserViewModel.checkLoggedUser', context: context);

  @override
  Future<void> checkLoggedUser() {
    return _$checkLoggedUserAsyncAction.run(() => super.checkLoggedUser());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_AuthUserViewModel.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$registerUserAsyncAction =
      AsyncAction('_AuthUserViewModel.registerUser', context: context);

  @override
  Future<void> registerUser(AppUser user) {
    return _$registerUserAsyncAction.run(() => super.registerUser(user));
  }

  @override
  String toString() {
    return '''
isUserLogging: ${isUserLogging},
loginLoading: ${loginLoading},
signingUp: ${signingUp},
currentUser: ${currentUser},
messageError: ${messageError}
    ''';
  }
}
