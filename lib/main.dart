import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage1.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> stateControl() async{

    var sp = await SharedPreferences.getInstance();

    String spUserName = sp.getString("username") ?? "no userName";
    String spPassword = sp.getString("password") ?? "no password";

    if (spUserName == "admin" && spPassword == "123"){
      return true;
    }else{
      return false;
    }
  }

    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  FutureBuilder<bool>(
        future : stateControl(),
        builder: (context,snapshot){
        if(snapshot.hasData){
        bool passPermit = snapshot.hasData;
        return passPermit ? HomePage1() : LoginScreen();
        }else{
          return Container();
          }
         },
        ),
      );
  }
}

class LoginScreen extends StatefulWidget {


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var tfUserName = TextEditingController();
  var tfPassword = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> accessControl() async{

    var un = tfUserName.text;
    var p = tfPassword.text;
    if(un == "admin" && p == "123"){
      var sp = await SharedPreferences.getInstance();
      sp.setString("username",un);
      sp.setString("password",p);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage1()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login is incorret")));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller:  tfUserName,
                decoration: InputDecoration(
                  hintText: "User Name",
                ),

              ),
              TextField(
                obscureText: true,
                controller:  tfPassword,
                decoration: InputDecoration(
                  hintText: "Password",
                ),

              ),
             ElevatedButton(
               child: Text("Sign in"),
               onPressed: (){
                accessControl();
               },
             )

            ],
          ),
        ),
      ),
           );
  }
}
