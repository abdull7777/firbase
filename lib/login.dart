import 'package:flutter/material.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter/services.dart';
import 'package:firebase_app/firebase%20classes/firebsae_phone.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
TextEditingController ph= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('FireBase Phone Authentication'),
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: TextFormField(
                controller: ph,
                keyboardType: TextInputType.phone,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text('Log In'),
              onPressed: () {
                phone.verfiyNumber(ph.toString(), (p0, p1) { }, context);


                },
            ),
          ],
        ),
      ),
    );
  }
}

