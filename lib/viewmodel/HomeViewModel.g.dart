// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModel, Store {
  late final _$userDataAtom =
      Atom(name: '_HomeViewModel.userData', context: context);

  @override
  AppUser? get userData {
    _$userDataAtom.reportRead();
    return super.userData;
  }

  @override
  set userData(AppUser? value) {
    _$userDataAtom.reportWrite(value, super.userData, () {
      super.userData = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_HomeViewModel.errorMessage', context: context);

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

  late final _$loadingContactsAtom =
      Atom(name: '_HomeViewModel.loadingContacts', context: context);

  @override
  bool get loadingContacts {
    _$loadingContactsAtom.reportRead();
    return super.loadingContacts;
  }

  @override
  set loadingContacts(bool value) {
    _$loadingContactsAtom.reportWrite(value, super.loadingContacts, () {
      super.loadingContacts = value;
    });
  }

  late final _$loadingConversationAtom =
      Atom(name: '_HomeViewModel.loadingConversation', context: context);

  @override
  bool get loadingConversation {
    _$loadingConversationAtom.reportRead();
    return super.loadingConversation;
  }

  @override
  set loadingConversation(bool value) {
    _$loadingConversationAtom.reportWrite(value, super.loadingConversation, () {
      super.loadingConversation = value;
    });
  }

  late final _$getAllContactsAsyncAction =
      AsyncAction('_HomeViewModel.getAllContacts', context: context);

  @override
  Future<void> getAllContacts() {
    return _$getAllContactsAsyncAction.run(() => super.getAllContacts());
  }

  @override
  String toString() {
    return '''
userData: ${userData},
errorMessage: ${errorMessage},
loadingContacts: ${loadingContacts},
loadingConversation: ${loadingConversation}
    ''';
  }
}
