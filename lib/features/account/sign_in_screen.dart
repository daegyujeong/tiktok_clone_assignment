import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/main_navigation/main_navigation.dart';
import 'create_account_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gaps.v60,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'English (US)',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Gaps.v80,
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/logo.png', // Replace with your logo asset path
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gaps.v40,
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Mobile number or email',
                border: OutlineInputBorder(),
              ),
            ),
            Gaps.v20,
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            Gaps.v20,
            ElevatedButton(
              onPressed: _signIn,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Log in'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
              child: const Text('Forgot password?'),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const CreateAccountScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Create new account'),
            ),
            Gaps.v20,
            const Center(
              child: Text(
                'Meta',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Gaps.v20,
          ],
        ),
      ),
    );
  }
}
