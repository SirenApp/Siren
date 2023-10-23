import 'package:flutter/material.dart';
import 'package:siren/src/screens/home.dart';
import 'package:siren/src/widgets/theme_filled_button.dart';
import '../widgets/password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register>{
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;

  late bool loading;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();

    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    const titleStyle = TextStyle(fontSize: 45, fontWeight: FontWeight.w600);

    const secondaryTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );

    InputDecoration textFieldDecoration(final String label) => InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 20),
      contentPadding: const EdgeInsets.only(bottom: 5),
    );

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 80, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: const FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text('Create an account', style: titleStyle)
                ),
              ),
            ),
            const SizedBox(height: 35),
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
            const SizedBox(height: 35),
            PasswordField(
              decoration: textFieldDecoration('Repeat Password'),
              style: const TextStyle(decorationThickness: 0),
              controller: repeatPasswordController,
            ),
            const SizedBox(height: 25),
            const Text('By creating an account, you agree to our Terms of Service and Privacy Policy', style: secondaryTextStyle, textAlign: TextAlign.center,),
            const SizedBox(height: 25),
            ThemeFilledButton(register, 'Sign up'),
            const SizedBox(height: 45),
            const Text("Already have an account?", style: secondaryTextStyle),
            ThemeFilledButton(moveToLogin, 'Sign in'),
          ],
        )
      ),
    );
  }

  void moveToLogin() => Navigator.pop(context);

  void register() async {
    setState(() => loading = true);

    final email = emailController.text;
    final password = passwordController.text;
    final repeatPassword = repeatPasswordController.text;

    if (password != repeatPassword) {
      //TODO: Show error message
    }

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user == null) throw Exception('Error!');
    } catch (e) {
      //TODO: Show error message
    } finally {
      setState(() => loading = false);
    }
  }
}
