import 'package:mobx/mobx.dart';
import 'package:msg_basic/firebase/AuthUser.dart';
import 'package:msg_basic/model/AppUser.dart';

part 'AuthUserViewModel.g.dart';
class AuthUserViewModel = _AuthUserViewModel with _$AuthUserViewModel;
abstract class _AuthUserViewModel with Store{
  final AuthUser _auth = AuthUser();

  @observable
  bool isUserLogging = true;
  @observable
  bool loginLoading = false;
  @observable
  bool signingUp = false;
  @observable
  AppUser? currentUser;
  @observable
  String messageError = "";

  @action
  Future<void> login(AppUser user) async{
    loginLoading = true;
    try{
      messageError = "";
      String result = await _auth.login(user);
      if (result.isNotEmpty) {
        messageError = result;
      }else{
        await checkLoggedUser();
      }
    }catch(error){
      messageError = error.toString();
    }
    loginLoading = false;
  }

  @action
  Future<void> checkLoggedUser() async {
    try{
      currentUser = await _auth.userLogged;
      if(currentUser != null){
        isUserLogging = true;
      }else{
        isUserLogging = false;
      }
    }catch(error){
      messageError = error.toString();
    }
  }

  @action
  Future<void> logout() async {
    try{
      String result = await _auth.signOut();
      if(result.isEmpty){
        await checkLoggedUser();
      }else{
        messageError = result;
      }
    }catch(error){
      messageError = error.toString();
    }
  }

  @action
  Future<void> registerUser(AppUser user) async {
    messageError = "";
    signingUp = true;
    String result = await _auth.registerUser(user);
    if(result.isEmpty){
      await checkLoggedUser();
      user.id = currentUser!.id;
    }else{
      messageError = result;
    }
    signingUp = false;
  }
}