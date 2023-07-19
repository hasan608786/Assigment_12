import 'dart:async';

import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String hoursString = "00", minuteString = "00", secondString = "00";

  int hours = 0, minutes = 0, seconds = 0;
  bool isTimerRunning = false;
  late Timer _timer;

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _startSecond();
    });
  }

  void pauseTimer() {
    _timer.cancel();
    setState(() {
      isTimerRunning = false;
    });
  }

  void _startSecond() {
    setState(() {
      if (seconds < 59) {
        seconds++;
        secondString = seconds.toString();
        if (secondString.length == 1) {
          secondString = "0" + secondString;
        }
      } else {
        _startMinute();
      }
    });
  }

  void _startMinute() {
    setState(() {
      if (minutes < 59) {
        seconds = 0;
        secondString = "00";
        minutes++;
        minuteString = minutes.toString();
        if (minuteString.length == 1) {
          minuteString = "0" + minuteString;
        }
      } else {
        _starHour();
      }
    });
  }

  void _starHour() {
    setState(() {
      seconds = 0;
      minutes = 0;
      secondString = "00";
      minuteString = "00";
      hours++;
      hoursString = hours.toString();
      if (hoursString.length == 1) {
        hoursString = "0" + hoursString;
      }
    });
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      secondString = "00";
      minuteString = "00";
      hoursString = "00";
    });
  }

  bool click = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (click == false) ? Colors.black : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          RawMaterialButton(
            textStyle: TextStyle(
                color: (click == false) ? Colors.white : Colors.black),
            onPressed: () {},
            child: Text(
              '$hoursString:$minuteString:$secondString',
              style: const TextStyle(fontSize: 90),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                RawMaterialButton(
                  onPressed: () {
                    resetTimer();
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: const Center(
                        child: Text(
                      'Reset',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
                const Spacer(),
                RawMaterialButton(
                  onPressed: () {
                    if (isTimerRunning) {
                      pauseTimer();
                    } else {
                      startTimer();
                    }
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 3, 244, 224),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                        child: Text(
                      isTimerRunning ? "Pause" : "Play",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          RawMaterialButton(
            textStyle: TextStyle(
                color: (click == false) ? Colors.white : Colors.black),
            onPressed: () {
              setState(() {
                click = !click;
              });
            },
            child: Text((click == true) ? 'Dark Mode' : 'Light Mode'),
          )
        ],
      ),
    );
  }
}
