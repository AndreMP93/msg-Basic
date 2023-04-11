import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:msg_basic/firebase/CloudDataBase.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/model/Conversation.dart';
part 'HomeViewModel.g.dart';

class HomeViewModel = _HomeViewModel with _$HomeViewModel;

abstract class _HomeViewModel with Store{
  final CloudDataBase _db = CloudDataBase();
  ObservableList<AppUser> listContacts = ObservableList();
  ObservableList<Conversation> listConversation = ObservableList();
  @observable
  AppUser? userData;
  @observable
  String errorMessage = "";
  @observable
  bool loadingContacts = true;
  @observable
  bool loadingConversation = true;
  StreamSubscription<QuerySnapshot>? _conversationsStream;

  @action
  Future<void> getAllContacts() async {
    loadingContacts = true;
    listContacts.clear();
    final result = await _db.getAllUsers();
    listContacts.addAll(result);
    loadingContacts = false;
  }

  Future getAllConversation(AppUser currentUser) async {
    if(_conversationsStream!=null){
      _conversationsStream!.cancel();
    }
    Stream<QuerySnapshot>? snapshot = await _db.getAllUserConversations(currentUser);
    if(snapshot!= null){
    _conversationsStream = snapshot.listen((event) async {
      loadingConversation = true;
      List<Conversation> conversations = await Future.wait(event.docs.map((document) async {
        Conversation conversation = Conversation.map(document.data() as Map<String, dynamic>);
        return conversation;
      }).toList());
      listConversation.clear();
      listConversation.addAll(conversations);
      loadingConversation = false;
    });
    }
  }

  Future<void> getUserData(String uId) async {
    userData = await _db.getUserData(uId);
  }

  Future<void> deleteConversation(AppUser sender, AppUser recipient) async {
    String result = await _db.deleteConversation(sender, recipient);
    if(result.isEmpty){
      listConversation.removeWhere((element) => element.recipent.id == recipient.id);
    }
  }

}