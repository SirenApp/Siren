import 'package:flutter/material.dart';

class ThemeFilledButton extends StatefulWidget {
  const ThemeFilledButton(this.onPressed, this.title, {super.key, this.loading = false});

  final VoidCallback onPressed;
  final String title;
  final bool loading;

  @override
  State<ThemeFilledButton> createState() => _ThemeFilledButtonState();
}

class _ThemeFilledButtonState extends State<ThemeFilledButton> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final ButtonStyle filledButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minimumSize: const Size(double.infinity, 50),
      fixedSize: const Size(double.infinity, 50),
    );

    final filledButtonTextStyle = TextStyle(
      color: colorScheme.background,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    );

    final Widget buttonChild = (
        !widget.loading
            ? Text(widget.title, style: filledButtonTextStyle)
            : SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorScheme.background),
                  strokeCap: StrokeCap.round,
                  strokeWidth: 4,
                )
              )
    );

    return FilledButton(
      style: filledButtonStyle,
      onPressed: widget.onPressed,
      child: buttonChild,
    );
  }
}
