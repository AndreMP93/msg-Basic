// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserProfileViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserProfileViewModel on _UserProfileViewModel, Store {
  late final _$uploadingImageAtom =
      Atom(name: '_UserProfileViewModel.uploadingImage', context: context);

  @override
  bool get uploadingImage {
    _$uploadingImageAtom.reportRead();
    return super.uploadingImage;
  }

  @override
  set uploadingImage(bool value) {
    _$uploadingImageAtom.reportWrite(value, super.uploadingImage, () {
      super.uploadingImage = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_UserProfileViewModel.errorMessage', context: context);

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

  late final _$userDataAtom =
      Atom(name: '_UserProfileViewModel.userData', context: context);

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

  late final _$getUserAsyncAction =
      AsyncAction('_UserProfileViewModel.getUser', context: context);

  @override
  Future<dynamic> getUser(AppUser user) {
    return _$getUserAsyncAction.run(() => super.getUser(user));
  }

  @override
  String toString() {
    return '''
uploadingImage: ${uploadingImage},
errorMessage: ${errorMessage},
userData: ${userData}
    ''';
  }
}
