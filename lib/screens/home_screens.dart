import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const initSeconds = 10;

  int totalSeconds = initSeconds;
  late Timer timer;
  bool isRunning = false;
  int totalPomodors = 0;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodors = totalPomodors + 1;
        totalSeconds = initSeconds;
        isRunning = false;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
        isRunning = true;
      });
    }
  }

  void handlerStart() {
    timer = Timer.periodic(Duration(seconds: 1), onTick);
  }

  void handleStop() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String formatSeconds(int seconds) {
    return Duration(seconds: seconds).toString().split('.')[0].substring(2, 7);

    //return '$seconds';
  }

  @override
  void dispose() {
    timer?.cancel(); // 타이머가 있으면 취소
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 115, 168, 1),
        //appBar: AppBar(title: ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
                flex: 2,
                child: Center(
                  //  alignment: Alignment.bottomCenter,
                  child: Text(
                    formatSeconds(totalSeconds),
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 92,
                        fontWeight: FontWeight.w700),
                  ),
                )),
            Flexible(
              flex: 2,
              child: Center(
                // alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: isRunning
                      ? const Icon(
                          Icons.pause_circle_outline,
                          size: 90,
                          color: Colors.white70,
                        )
                      : const Icon(
                          Icons.play_circle_outline,
                          size: 90,
                          color: Colors.white70,
                        ),
                  onPressed: isRunning ? handleStop : handlerStart,
                ),
              ),
            ),
            Flexible(
                flex: 1,

                // child: Container(
                //   decoration: BoxDecoration(color: Colors.black87),
                //   child: Column(children: [Text('Pomodoros'), Text('0')]),
                // ),

                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(50)),
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Pomodoros',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      Text(
                        '$totalPomodors',
                        style: const TextStyle(
                            fontSize: 70, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}
