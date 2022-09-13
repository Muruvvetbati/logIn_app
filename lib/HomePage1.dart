import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  String? spUserName;
  String? spPassword;


  Future<void> readLoginInfo() async{

    var sp = await SharedPreferences.getInstance();
    setState(() {
      spUserName = sp.getString("username") ?? "no userName";
      spPassword = sp.getString("password") ?? "no password";

    });

  }


  Future<void> logOut() async{

    var sp = await SharedPreferences.getInstance();
    sp.remove("username");
    sp.remove("password");

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
  }

  @override
  void initState() {
    super.initState();
    readLoginInfo();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("HomePage"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed:(){
              logOut();

            },
          ),
        ],
      ),
      body: Padding(

        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("User Name : $spUserName",style: TextStyle(color: Colors.purpleAccent,fontSize: 30),),
              Text("User Password :$spPassword",style: TextStyle(color: Colors.blue,fontSize: 30),),

            ],
          ),
        ),
      ),
    );
  }
}
