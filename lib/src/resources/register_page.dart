import 'package:flutter/material.dart';
import 'package:flutter_app_grab/src/blocs/auth_bloc.dart';
import 'package:flutter_app_grab/src/resources/dialog/msg_dialog.dart';
import 'package:flutter_app_grab/src/resources/home_page.dart';

import 'dialog/loading_dialog.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc authBloc = new AuthBloc();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff3277D8)),
        elevation: 0,//bỏ shawdown
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Image.asset('ic_car_red.png'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,40,0,6),
                child: Text("Welcome new user!",style: TextStyle(
                  fontSize: 22,color: Color(0xff333333),
                ),),
              ),
              Text("Signup with iCar in simple steps",style: TextStyle(
                fontSize: 16,color: Color(0xff606470),
              ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,120,0,20),
                child: StreamBuilder(
                  stream: authBloc.nameStream,
                  builder: (context,snapshot) =>TextField(
                    controller: _nameController,
                    style: TextStyle(fontSize: 18,color: Colors.black),
                    decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error :null,
                        labelText: "Name",
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset("ic_user.png"),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffCED0D2),width: 1
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(6))
                        )
                    ),
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,20),
                child: StreamBuilder(
                  stream: authBloc.phoneStream,
                  builder: (context,snapshot) =>TextField(
                    keyboardType:TextInputType.phone,
                    controller: _phoneController,
                    style: TextStyle(fontSize: 18,color: Colors.black),
                    decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error : null,
                        labelText: "Phone number",
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset("ic_phone.png"),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffCED0D2),width: 1
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(6))
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,20),
                child: StreamBuilder(
                  stream: authBloc.emailStream,
                  builder: (context,snapshot)=>TextField(
                    controller: _emailController,
                    style: TextStyle(fontSize: 18,color: Colors.black),
                    decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error : null,
                        labelText: "Email",
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset("ic_mail.png"),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffCED0D2),width: 1
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(6))
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,20),
                child: StreamBuilder(
                  stream: authBloc.passStream,
                  builder: (context,snapshot)=>TextField(
                    obscureText:true,
                    controller: _passController,
                    style: TextStyle(fontSize: 18,color: Colors.black),
                    decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error :null,
                        labelText: "Password",
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset("ic_lock.png"),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffCED0D2),width: 1
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(6))
                        )
                    ),
                  ),
                ),
              ),
              Padding (
                padding: const EdgeInsets.fromLTRB(0,30,0,40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: _onSignupClicked,
                    child: Text("Log In",
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,40),
                child: RichText(
                  text: TextSpan(
                      text: "Already a User? ",
                      style: TextStyle(color: Color(0xff606470),fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Login now",
                            style: TextStyle(
                                color: Color(0xff3277D8),fontSize: 16
                            )
                        )
                      ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSignupClicked(){
    var isValid = authBloc.isValid(_nameController.text, _emailController.text, _passController.text, _phoneController.text);
    if(isValid){
      LoadingDialog.showLoadingDialog(context, "Loading ........");
      authBloc.signUp(_emailController.text, _passController.text, _phoneController.text, _nameController.text, (){
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      },(msg){
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign_IN", msg);
      });
    }
  }
  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

}
