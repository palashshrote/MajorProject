import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:accident_detection/accident.dart';
// import 'AccidentButtonPageState.dart';
import 'accident.dart';

class SettingsPage extends StatefulWidget {
  // const SettingsPage({super.key});
  SettingsPage({Key? key, required this.init_time, required this.updated_time})
      : super(key: key);
  String init_time;
  Function updated_time;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int pre_time = 0;
  void initState() {
    pre_time = int.parse(this.widget.init_time);
    super.initState();
  }

  void inc10() {
    pre_time += 10;
  }

  void dec10() {
    pre_time -= 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accident Detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pre_time.toString(),
              style: TextStyle(fontSize: 50.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // print(myDuration.inSeconds);
                    // print(myDuration.inSeconds.runtimeType);

                    setState(() {
                      inc10();
                    });
                  },
                  child: Text('+10'),
                ),
                SizedBox(
                  width: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      dec10();
                    });
                  },
                  child: Text('-10'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                this.widget.updated_time(pre_time.toString());
                print(pre_time.toString());
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
