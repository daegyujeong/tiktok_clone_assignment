import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _isPrivateProfile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy'),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: const FaIcon(FontAwesomeIcons.lock),
            title: const Text('Private profile'),
            value: _isPrivateProfile,
            onChanged: (bool value) {
              setState(() {
                _isPrivateProfile = value;
              });
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.at),
            title: const Text('Mentions'),
            trailing: const Text('Everyone'),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.volumeMute),
            title: const Text('Muted'),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.eyeSlash),
            title: const Text('Hidden Words'),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.userFriends),
            title: const Text('Profiles you follow'),
            onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Other privacy settings',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                FaIcon(FontAwesomeIcons.upRightFromSquare, color: Colors.grey),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.ban),
            title: const Text('Blocked profiles'),
            trailing: const FaIcon(FontAwesomeIcons.upRightFromSquare),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.eyeSlash),
            title: const Text('Hide likes'),
            trailing: const FaIcon(FontAwesomeIcons.upRightFromSquare),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
