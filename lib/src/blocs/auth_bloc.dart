import 'dart:async';

import 'package:flutter_app_grab/src/firebase/firebase_auth.dart';

class AuthBloc {
  var _fireAuth = FireBAuth();
  StreamController _nameController = new StreamController();
  StreamController _emailController= new StreamController();
  StreamController _passController=new StreamController();
  StreamController _phoneController=new StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;
  Stream get phoneStream => _phoneController.stream;

  bool isValid(String name,String email, String pass , String phone){
    if(name ==null || name.toString().trim().length ==0 )
    {
      _nameController.sink.addError("Please enter your name!");
      return false;
    }
    _nameController.sink.add("");

    if(phone ==null || phone.toString().trim().length == 0 )
    {
      _phoneController.sink.addError("Please enter your phone!");
      return false;
    }
    _phoneController.sink.add("");

    if(email ==null || email.toString().trim().length <6 || !email.contains("@"))
    {
    _emailController.sink.addError("Your email is not valid");
    return false;
    }
    _emailController.sink.add("");

    if(pass ==null || pass.toString().trim().length < 6 )
    {
      _passController.sink.addError("Password must be over 6 characters!");
    return false;
    }
    _passController.sink.add("");

    return true;
    }

    void signUp(String email, String pass, String phone,String name,Function onSuccess,Function(String) onRegisterError){

    _fireAuth.signUp(email.trim(), pass, name, phone, onSuccess,onRegisterError);

    }
    void signIn(String email, String pass){

    }


    void dispose(){
      _nameController.close();
      _emailController.close();
      _passController.close();
      _phoneController.close();
    }
}