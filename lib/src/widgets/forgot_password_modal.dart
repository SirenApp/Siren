import 'package:flutter/material.dart';
import 'package:siren/src/widgets/theme_filled_button.dart';

class ForgotPasswordModal {
  const ForgotPasswordModal(this.context, {this.controller});

  final BuildContext context;
  final TextEditingController? controller;

  void show() {
    final colorScheme = Theme.of(context).colorScheme;

    const modalShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )
    );

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: colorScheme.background,
      isScrollControlled: true,
      shape: modalShape,
      builder: (context) => _Modal(emailController: controller),
    );
  }
}

class _Modal extends StatelessWidget {
  const _Modal({this.emailController});

  final TextEditingController? emailController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    textFieldDecoration(final String label) => InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 20),
      contentPadding: const EdgeInsets.only(bottom: 5),
    );

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Text('Forgot your password?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('Enter your email address and we will send you a link to reset your password.', textAlign: TextAlign.center),
              const SizedBox(height: 20),
              TextField(
                decoration: textFieldDecoration('Email'),
                style: const TextStyle(decorationThickness: 0),
                controller: emailController,
              ),
              const SizedBox(height: 20),
              ThemeFilledButton(() => {}, 'Send'),
            ],
          ),
        ),
      ),
    );
  }
}
