import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siren/src/widgets/error_dialog.dart';
import 'package:siren/src/screens/register.dart';
import 'package:siren/src/widgets/forgot_password_modal.dart';
import 'package:siren/src/widgets/password_field.dart';
import 'package:siren/src/widgets/theme_filled_button.dart';
import 'package:siren/src/widgets/top_bar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late bool loading;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();

    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final containerDecoration = BoxDecoration(color: colorScheme.background);

    InputDecoration textFieldDecoration(final String label) => InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 20),
      contentPadding: const EdgeInsets.only(bottom: 5),
    );

    final ButtonStyle forgotPasswordStyle = ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      minimumSize: MaterialStateProperty.all(Size.zero),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
    );

    const secondaryTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 80, left: 15, right: 15),
        child: Container(
          decoration: containerDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar("Log in"),
              TextField(
                decoration: textFieldDecoration('Email'),
                style: const TextStyle(decorationThickness: 0),
                controller: emailController,
              ),
              const SizedBox(height: 35),
              PasswordField(
                decoration: textFieldDecoration('Password'),
                style: const TextStyle(decorationThickness: 0),
                controller: passwordController,
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(bottom: 20),
                child: TextButton(
                  style: forgotPasswordStyle,
                  onPressed: () => ForgotPasswordModal(context, controller: emailController).show(),
                  child: const Text('Forgot your password?',
                    style: secondaryTextStyle)),
              ),
              ThemeFilledButton(login, 'Sign in', loading: loading),
              const SizedBox(height: 45),
              const Text("Don't have an account?", style: secondaryTextStyle),
              ThemeFilledButton(moveToRegister, 'Sign up'),
            ],
          )
        ),
      )
    );
  }

  void moveToRegister() => Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Register(emailController: emailController, passwordController: passwordController),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
            child: child,
          )
      )
  );

  void login() async {
    setState(() => loading = true);
    final email = emailController.text;
    final password = passwordController.text;

    // if (email.isEmpty || password.isEmpty) {
    //   showErrorDialog(
    //     context,
    //     title: "Error",
    //     description: "Email or password can't be empty!",
    //     buttons: ["OK"],
    //     dismissible: true,
    //     actions: (button, dismiss) {
    //       dismiss();
    //     }
    //   );
    // }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      showErrorDialog(context, title: "Error", description: e.code);
    } finally {
      setState(() => loading = false);
    }
  }
}
