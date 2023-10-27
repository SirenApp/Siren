import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  const TopBar(this.title, {super.key, this.backButton = false, this.onBackPressed});

  final String? title;
  final bool backButton;
  final VoidCallback? onBackPressed;

  @override
  State<TopBar> createState() => _TopBar();
}

class _TopBar extends State<TopBar>{
  @override
  Widget build(BuildContext build) {
    final colorScheme = Theme.of(context).colorScheme;

    const titleStyle = TextStyle(fontSize: 45, fontWeight: FontWeight.w600);

    return Column(
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (widget.backButton)
              Positioned(
                  child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: widget.onBackPressed ?? () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_rounded, color: colorScheme.primary, size: 30,)
                  )
              ),
            Center(child: Text(widget.title ?? "", style: titleStyle)),
          ],
        ),
        const SizedBox(height: 35),
      ],
    );
  }
}
