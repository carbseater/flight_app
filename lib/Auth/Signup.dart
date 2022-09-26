
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40,),
        TextField(
          controller: emailController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: 'Email'),

        ),
        SizedBox(height: 4,),
        TextField(
          controller: passwordController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        SizedBox(height: 20,),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50)
          ),
          icon: Icon(Icons.lock_open,size: 32,),
          label: Text(
            "Sign Up",
            style: TextStyle(fontSize: 24),
          ),
          onPressed: signUp,
        )
      ],
    ),
  );
  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    );
  }
}
