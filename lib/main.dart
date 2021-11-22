import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int score = 0;
  int tap = 0;
  int heart = 5;
  int time = 10;
  Timer? _timer;
  bool tapped = false;

  @override
  void initState() {
    time = 10;
    tap = 0;
    score = 0;
    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) {
          time--;
        } else {
          if (tap < 10) {
            if (heart == 0) {
              heart = 5;
              time = 10;
              tap = 0;
              score = 0;
            } else {
              heart--;
            }
          } else {
            score++;
          }
          time = 10;
          tap = 0;
        }
      });
    });
  }

  void _tap() {
    if (!tapped) {
      heart = 5;
      startTimer();
      tapped = !tapped;
    }
    if (tap < 9) {
      tap++;
    } else {
      tap = 0;
      time = 10;
      score++;
    }
  }

  IconData setHeart(int order) {
    if (order <= heart) {
      return Icons.favorite;
    } else {
      return Icons.favorite_border_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TenTap',
        home: Scaffold(
            appBar: AppBar(
                title: Center(child: Text('Tentap')),
                backgroundColor: Colors.teal[500]),
            backgroundColor: Colors.teal[50],
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('Score: ' + score.toString(),
                        style: TextStyle(
                            color: Colors.teal[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(setHeart(1), size: 20, color: Colors.red),
                        Icon(setHeart(2), size: 20, color: Colors.red),
                        Icon(setHeart(3), size: 20, color: Colors.red),
                        Icon(setHeart(4), size: 20, color: Colors.red),
                        Icon(setHeart(5), size: 20, color: Colors.red),
                      ],
                    ),
                    Text('Time: ' + time.toString() + "s",
                        style: TextStyle(
                            color: Colors.red[400],
                            fontStyle: FontStyle.italic,
                            fontSize: 15)),
                    Text('Tap: ' + tap.toString() + "",
                        style:
                            TextStyle(color: Colors.teal[400], fontSize: 15)),
                    ElevatedButton(
                        onPressed: _tap,
                        child: const Text('Tap me',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.teal),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                        )),
                  ]),
            )));
  }
}
