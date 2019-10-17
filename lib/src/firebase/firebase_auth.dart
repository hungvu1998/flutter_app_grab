import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
class FireBAuth {
  FirebaseAuth _firebaseAuth= FirebaseAuth.instance;

  void signUp(String email, String pass ,String name, String phone,Function onSuccess,Function(String)onRegisterError){

    createNewAccountEmail(email, pass).then((user){
      print("v2");
      _createUser(user.uid, name, phone,onSuccess,onRegisterError);
    }).catchError((err){

     _onSignUpErr(err.code, onRegisterError);
    });

  }




  void _createUser(String userID,String name, String phone,Function onSuccess,Function(String)onRegisterError){
    var userValue = {
      "name" :name,
      "phone":phone
    };
    var ref= FirebaseDatabase.instance.reference().child("users");
    ref.child(userID).set(userValue).then((user){
      //succes
      onSuccess();
    }).catchError((err){
      onRegisterError("Signup fail, please try again");
    });
  }

  Future<FirebaseUser> createNewAccountEmail(String mail, String pass) async {
    final FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
    email:mail,
    password:pass,
    ))
    .user;
    return user;
  }

  void signIn(String email, String pass, Function onSuccess,Function(String)onSignInError){
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass).then((user){
      onSuccess();
    }).catchError((err){
      onSignInError("Email or Password is wrong, Try again!!");
    });

  }
  void _onSignUpErr(String code,Function(String)onRegisterError){
    if(code.contains("ERROR_INVALID_EMAIL")|| code.contains("ERROR_INVALID_CREDENTIAL") ){
      onRegisterError("Invalid email");
    }
    else if(code.contains("ERROR_EMAIL_ALREADY_IN_USE")){
      onRegisterError("Email has existed");
    }
    else if(code.contains("ERROR_WEAK_PASSWORD")){
      onRegisterError("The password is not strong enough");
    }
    else{
      onRegisterError("Signup fail, please try again");
    }
  }


}