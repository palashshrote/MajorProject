import 'package:flutter/material.dart';
import 'auth.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accident Detection'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Accident Detection App\n\nFinal year project by:\nDhawal Madankar\nNikita Sarade\nPalash Shrote',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.cyan,
              ),
            ),
          ),
          // _signOutButton(),
        ],
      ),
    );
  }
}
