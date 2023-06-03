import 'package:firebase_auth/firebase_auth.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/resources/AppStrings.dart';

class AuthUser{
  static final AuthUser _authSingleton = AuthUser._internal();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  factory AuthUser() {
    return _authSingleton;
  }

  AuthUser._internal();

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  Future<String> login(AppUser user) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: user.email!, password: user.password!);
      return "";
    }on FirebaseAuthException catch (e){
      if(e.code == "invalid-email"){
        return AppStrings.loginErrorInvalidEmail;
      }else if(e.code == "user-not-found"){
        return AppStrings.loginErrorUserNotFound;
      }else if(e.code == 'network-request-failed'){
        return AppStrings.loginErrorNetworkRequestFailed;
      }else if(e.code == "wrong-password"){
        return AppStrings.loginErrorWrongPassword;
      }else if(e.code == 'too-many-requests'){
        return AppStrings.loginErrorTooManyRequests;
      }else{
        return "${AppStrings.loginError}: ${e.code}";
      }
    }
  }

  Future<String> registerUser(AppUser user) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: user.email!, password: user.password!);
      return "";
    }on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return AppStrings.registerErrorWeakPassword;
      } else if (e.code == 'email-already-in-use') {
        return AppStrings.registerErrorEmailAlreadyUse;
      } else if (e.code == 'invalid-email') {
        return AppStrings.emailError;
      }else if(e.code == 'network-request-failed') {
        return AppStrings.errorNetworkRequestFailed;
      }else {
        return "${AppStrings.registerUserError} ${e.code}";
      }
    }
  }

  Future<String> signOut() async {
    try{
      await _firebaseAuth.signOut();
      return "";
    }catch(e){
      return "${AppStrings.logoutUserError} : $e";
    }
  }

  Future<AppUser?> get userLogged async {
    try{
      User? currentUser =  _firebaseAuth.currentUser;
      if(currentUser!= null){
        return AppUser(id: currentUser.uid ,email: currentUser.email);
      }
    }catch(e){
      print("get UserLogged: $e");
    }
    return null;

  }
}