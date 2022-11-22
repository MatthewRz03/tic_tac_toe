import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tris',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Tris"),
          ),
          body: const Grid(),
        ));
  }
}

class Grid extends StatefulWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  var boxes = ['', '', '', '', '', '', '', '', ''];
  int turn = 0;

  void press(index) {
    setState(() {
      if (boxes[index] == '') {
        boxes[index] = 'X';
        turn++;
        if (turn < 9) {

          play();

        }
        checkWinner();
      }
    });
  }

  void play() {
    Random random = Random();

    int num = random.nextInt(9);
    while (boxes[num] != '') {
      num = random.nextInt(9);
    }
    setState(() {
      boxes[num] = 'O';
      turn++;
    });
    checkWinner();
  }

  void showWinDialog(message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(message)));
  }

  void clearGrid() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        boxes[i] = '';
      }
      turn = 0;
    });
  }

  void checkWinner() {
    var lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (int i = 0; i < lines.length; i++) {
      var pos = lines[i];
      if (boxes[pos[0]] == boxes[pos[1]] &&
          boxes[pos[1]] == boxes[pos[2]] &&
          boxes[pos[0]] != '') {
        if (boxes[pos[0]] == 'X') {
          showWinDialog("Hai vinto");
        } else {
          showWinDialog("Hai perso");
        }
        clearGrid();
        return;
      }
    }
    if (turn == 9) {
      showWinDialog("Pareggio");
      clearGrid();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return ElevatedButton(
            onPressed: () => press(index),
            child: Center(
                child:
                Text(boxes[index], style: const TextStyle(fontSize: 80))),
            style: ElevatedButton.styleFrom(
                primary: Colors.green[200], onPrimary: Colors.black));
      },
    );
  }
}
