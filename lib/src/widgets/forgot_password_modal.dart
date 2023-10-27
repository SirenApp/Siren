import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siren/src/widgets/theme_filled_button.dart';

class ForgotPasswordModal {
  ForgotPasswordModal(this.context, {controller}) {
    this.controller = controller ?? TextEditingController();
  }

  final BuildContext context;
  late TextEditingController controller;

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
      builder: (context) => _Modal(controller, context),
    );
  }
}

class _Modal extends StatefulWidget {
  const _Modal(this.emailController, this.context);

  final TextEditingController emailController;
  final BuildContext context;

  @override
  State<_Modal> createState() => _ModalState();
}

class _ModalState extends State<_Modal> {
  late bool loading;

  @override
  void initState() {
    loading = false;

    super.initState();
  }

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
                controller: widget.emailController,
              ),
              const SizedBox(height: 20),
              ThemeFilledButton(sendResetLink, 'Send', loading: loading),
            ],
          ),
        ),
      ),
    );
  }

  sendResetLink() async {
    setState(() {
      loading = true;
    });

    await FirebaseAuth.instance.sendPasswordResetEmail(email: widget.emailController.text);

    setState(() {
        loading = false;
    });

    if (!context.mounted) return;
    Navigator.pop(context);
  }
}
