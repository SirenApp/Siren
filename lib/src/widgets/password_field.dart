import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.decoration = const InputDecoration(),
    this.style = const TextStyle(),
    this.controller,
    this.eyeColor,
  });

  final InputDecoration decoration;
  final TextStyle style;
  final TextEditingController? controller;
  final Color? eyeColor;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField>{
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: TextField(
            obscureText: _obscureText,
            decoration: widget.decoration,
            style: widget.style,
            controller: widget.controller,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: colorScheme.primary,
                width: 1,
              ),
            ),
          ),
          child: IconButton(
            icon: Icon(_obscureText ? Icons.abc : Icons.password, color: widget.eyeColor ?? colorScheme.primary),
            onPressed: () => setState(() {
              _obscureText = !_obscureText;
            }),
          ),
        ),
      ],
    );
  }
}
