import 'package:flutter/material.dart';

typedef ActionsCallback = void Function(String button, VoidCallback dismiss);

Future<T?> showErrorDialog<T>(BuildContext context, {
  String? title,
  String? description,
  List<String>? buttons,
  ActionsCallback? actions,
  bool dismissible = true,
}) async => await showDialog(
  context: context,
  barrierDismissible: dismissible,
  builder: (context) => ErrorDialog(
    context,
    title: title,
    description: description,
    buttons: buttons,
    actions: actions,
  )
);

class ErrorDialog extends StatefulWidget {
  const ErrorDialog(this.context, {super.key, this.title, this.description, this.buttons, this.actions});

  final BuildContext context;
  final String? title;
  final String? description;
  final List<String>? buttons;
  final ActionsCallback? actions;

  @override
  State<ErrorDialog> createState() => _ErrorDialog();
}

class _ErrorDialog extends State<ErrorDialog>{
  late List<Widget> buttons;

  @override
  void initState() {
    buttons = [];

    ButtonStyle buttonStyle = ButtonStyle(
      overlayColor: MaterialStateColor.resolveWith((states) => const Color(0x16000000)),
    );

    TextStyle textButtonStyle = const TextStyle(
      color: Colors.blue,
    );

    for (String button in widget.buttons ?? []) {
      buttons.add(TextButton(
        onPressed: () => widget.actions!(button, () => Navigator.pop(context)),
        style: buttonStyle,
        child: Text(
          button,
          style: textButtonStyle
        ),
      ));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: colorScheme.primary,
      insetPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title ?? "",
                style: TextStyle(
                  color: colorScheme.background,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
              ),
              Text(widget.description ?? "",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 5,
                    children: buttons
                  )
                ]
              )
            ],
          ),
        ),
      )
    );
  }
}
