import 'package:flutter/material.dart';
import 'package:siren/src/classes/user.dart';
import 'package:siren/src/widgets/top_bar.dart';

import '../widgets/theme_filled_button.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile(this.user, {super.key});

  final SirenUser user;

  @override
  State<CreateProfile> createState() => _CreateProfile();
}

class _CreateProfile extends State<CreateProfile> {
  late TextEditingController nameController;
  late TextEditingController bioController;

  @override
  void initState() {
    nameController = TextEditingController();
    bioController = TextEditingController();

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
          children: [
            const TopBar("Profile", backButton: true),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  TextField(
                    decoration: textFieldDecoration('Name'),
                    style: const TextStyle(decorationThickness: 0),
                    controller: nameController,
                  ),
                  const SizedBox(height: 35),
                  TextField(
                    decoration: textFieldDecoration('Bio'),
                    style: const TextStyle(decorationThickness: 0),
                    controller: bioController,
                  ),
                  const SizedBox(height: 25),
                  const Text('By creating an account, you agree to our Terms of Service and Privacy Policy', style: secondaryTextStyle, textAlign: TextAlign.center,),
                  const SizedBox(height: 25),
                  ThemeFilledButton(register, 'Create Account'),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  register() {
    widget.user.profile = SirenProfile();
  }
}
