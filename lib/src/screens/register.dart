import 'package:flutter/material.dart';
import 'package:siren/src/classes/user.dart';
import 'package:siren/src/screens/create_profile.dart';
import 'package:siren/src/widgets/theme_filled_button.dart';
import 'package:siren/src/widgets/top_bar.dart';
import '../widgets/password_field.dart';

class Register extends StatefulWidget {
  const Register({super.key, this.emailController, this.passwordController});

  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register>{
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;

  @override
  void initState() {
    emailController = widget.emailController ?? TextEditingController();
    passwordController = widget.passwordController ?? TextEditingController();
    repeatPasswordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
            const TopBar("Create an account"),
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
            const SizedBox(height: 45),
            ThemeFilledButton(register, 'Continue'),
            const SizedBox(height: 35),
            const Text("Already have an account?", style: secondaryTextStyle),
            ThemeFilledButton(moveToLogin, 'Sign in'),
          ],
        )
      ),
    );
  }

  void moveToLogin() => Navigator.pop(context);

  void register() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) return;
    if (passwordController.text != repeatPasswordController.text) return;

    SirenUser user = SirenUser(emailController.text, passwordController.text);

    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => CreateProfile(user),
            transitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
              position: Tween(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
              child: child,
            )
        )
    );
  }
}
