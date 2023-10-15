import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

import 'package:http/http.dart';

import 'Dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
                children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icon.svg',
                    height: 90,
                    width: 70,
                  ),
                  Transform.translate(
                      offset: Offset(-25, 20),
                      child: Text(
                        "Dera",
                        style: Theme.of(context).textTheme.headlineLarge,
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Welcome Back",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.red,),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "Enter Email",
                      fillColor:
                          Theme.of(context).secondaryHeaderColor.withAlpha(50),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0,
                              color: Theme.of(context)
                                  .secondaryHeaderColor
                                  .withAlpha(50)),
                          borderRadius: BorderRadius.circular(2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0,
                              color: Theme.of(context)
                                  .secondaryHeaderColor
                                  .withAlpha(50)),
                          borderRadius: BorderRadius.circular(2)))),
              SizedBox(
                height: 30,
              ),
              TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: "Enter Password",
                      fillColor:
                          Theme.of(context).secondaryHeaderColor.withAlpha(50),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0,
                              color: Theme.of(context)
                                  .secondaryHeaderColor
                                  .withAlpha(50)),
                          borderRadius: BorderRadius.circular(2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0,
                              color: Theme.of(context)
                                  .secondaryHeaderColor
                                  .withAlpha(50)),
                          borderRadius: BorderRadius.circular(2)))),
              SizedBox(
                height: 30,
              ),
              Text(
                "Forget Password?",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      RegExp emailExp = RegExp(
                          r'^[_A-Za-z0-9-]+(.[_A-Za-z0-9-]+)@[a-z]+(.[a-z]+)(.[a-z]{2,})$');
                      RegExp passwordExp = RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
                      if (!emailExp.hasMatch(emailController.text) &&
                          !passwordExp.hasMatch(passwordController.text)) {
                        setState(() {
                          errorMessage =
                              "Invalid Email and Password, Password must be 8 digits containing at least one Upper, Lower and Number.";
                        });
                      } else if (!emailExp.hasMatch(emailController.text)) {
                        setState(() {
                          errorMessage = "Invalid Email Format";
                        });
                      } else if (!passwordExp
                          .hasMatch(passwordController.text)) {
                        setState(() {
                          errorMessage =
                              "Password must be 8 digits containing at least one Upper, Lower and Number.";
                        });
                      } else {
                        loginButtonPressed();
                      }
                    },
                    child: Text("Login"),
                  )),
                ],
              )
            ]),
          ),
        ));
  }

  loginButtonPressed() async{
    Uri url=Uri.http("192.168.43.143:80","api/authenticate");
    Response response= await post(url,body:{'email':emailController.text,'password':passwordController.text,'type':'2'});
    Map responseMap=jsonDecode(response.body);
    if(responseMap['status']==200){
      Navigator.of(context).push(createRoute());
    }else{
      setState(() {
        errorMessage=responseMap['error'];
      });
    }
  }
  Route createRoute(){
    return PageRouteBuilder(pageBuilder: (context,animation,secondaryAnimation,)=>Dashboard(),
    transitionsBuilder: (context,animation,secondayAnimation,child){
      Offset begin=Offset(0.0,1.0);
      Offset end=Offset(0.0,0.0);
      Curve curve=Curves.easeIn;
      Tween<Offset> tween=Tween(begin: begin,end: end);
      return SlideTransition(position: animation.drive(tween),child: child,);

    }
    );
    
  }
}
