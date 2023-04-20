import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'accident.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  Future<void> signOut() async {
    await Auth().signOut();
  }

  final User? user = Auth().currentUser;
  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign out'),
    );
  }

  List<double>? _accelerometerValues;
  final player = AudioPlayer();
  void playSound() {
    player.play(AssetSource('not1sec.wav'));
  }

  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accident Detection'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Welcome to Accident Detection App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text('Accelerometer: $accelerometer'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Signed in by- '),
                    _userUid(),
                  ],
                ),
                _signOutButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  double x_val = 0.0;
  @override
  void initState() {
    super.initState();

    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
            x_val = event.x;
            if (x_val >= 10.0) {
              print(x_val);
              playSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) {
                      return const AccidentButtonPage();
                    },
                    allowSnapshotting: true),
              );
            }
          });
        },
      ),
    );
  }
}
