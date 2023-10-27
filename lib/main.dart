import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siren/src/screens/home.dart';
import 'package:siren/src/screens/login.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  late Widget home;

  @override
  void initState() {
    home = const Login();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        home = user == null ? const Login() : const Home();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
        title: 'Siren',
        theme: ThemeData(
          fontFamily: 'Nunito',
          colorScheme: const ColorScheme.light(
            primary: Colors.white,
            background: Color.fromRGBO(221, 54, 140, 1),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          ),
          useMaterial3: true,
        ),
        home: home,
    );
  }
}
