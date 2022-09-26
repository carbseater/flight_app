import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed in as ',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8,),
            Text(
              user.email!,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),

            ),
            SizedBox(height: 8,),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50)
              ),
              icon: Icon(Icons.arrow_back,size: 32,),
              label: Text(
                'Sign out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),
            )

          ],
        ),
      ),
    );
  }

}
