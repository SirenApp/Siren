import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 45, fontWeight: FontWeight.w600);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            const Text('Home', style: titleStyle),
            TextButton(onPressed: logout, child: const Text("Logout"))
          ],
        ),
      ),
    );
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
