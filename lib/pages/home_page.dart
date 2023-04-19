import 'package:flutter/material.dart';
import 'dart:async';

import 'package:accident_detection/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePagee extends StatefulWidget {
  const HomePagee({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  State<HomePagee> createState() => _HomePageeState();
}

class _HomePageeState extends State<HomePagee> {
  // HomePage({Key? key}) : super(key: key);
  //logic for sound nd sensors
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  // final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  List<double>? _accelerometerValues;
  final player = AudioPlayer();
  void playSound() {
    player.play(AssetSource('not1sec.wav'));
  }

  void stopSound() {
    player.stop();
  }

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Accident detection');
    // return const Text('Firebase Auth');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _userUid(),
              _signOutButton(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Accelerometer: $accelerometer'),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            playSound();
          },
          child: const Text('Play'),
        ),
      ]),
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
            }
          });
        },
      ),
    );
  }
}
