// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessageViewModel on _MessageViewModel, Store {
  late final _$loadindAllMessagesAtom =
      Atom(name: '_MessageViewModel.loadindAllMessages', context: context);

  @override
  bool get loadindAllMessages {
    _$loadindAllMessagesAtom.reportRead();
    return super.loadindAllMessages;
  }

  @override
  set loadindAllMessages(bool value) {
    _$loadindAllMessagesAtom.reportWrite(value, super.loadindAllMessages, () {
      super.loadindAllMessages = value;
    });
  }

  late final _$sendingImageAtom =
      Atom(name: '_MessageViewModel.sendingImage', context: context);

  @override
  bool get sendingImage {
    _$sendingImageAtom.reportRead();
    return super.sendingImage;
  }

  @override
  set sendingImage(bool value) {
    _$sendingImageAtom.reportWrite(value, super.sendingImage, () {
      super.sendingImage = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_MessageViewModel.errorMessage', context: context);

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

  late final _$_messageStreamAtom =
      Atom(name: '_MessageViewModel._messageStream', context: context);

  @override
  StreamSubscription<QuerySnapshot<Object?>>? get _messageStream {
    _$_messageStreamAtom.reportRead();
    return super._messageStream;
  }

  @override
  set _messageStream(StreamSubscription<QuerySnapshot<Object?>>? value) {
    _$_messageStreamAtom.reportWrite(value, super._messageStream, () {
      super._messageStream = value;
    });
  }

  @override
  String toString() {
    return '''
loadindAllMessages: ${loadindAllMessages},
sendingImage: ${sendingImage},
errorMessage: ${errorMessage}
    ''';
  }
}
