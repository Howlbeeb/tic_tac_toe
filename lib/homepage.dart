import 'package:flutter/material.dart';
import 'package:tic_tac_toe/CustomDialog.dart';
import 'game_button.dart';
import 'dart:math';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<GameButton> buttonsList;
  final player1 = [];
  final player2 = [];
  int activePlayer = 1;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = "X";
        gb.bg = Colors.red;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = "O";
        gb.bg = Colors.green;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      // int? winner = checkWinner();
      // if (winner == -1) {
      //   if (buttonsList.every((p) => p.reset())) {
      //     showDialog(
      //         context: context,
      //         builder: (_) => CustomDialog(
      //             "Game Tied", "press rest to start again", resetGame));
      //   } else {
      //     activePlayer == 2 ? autoPlay() : null;
      //   }
      // }
    });
  }

  void autoPlay() {
    var emptycells = [];
    var list = List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptycells.add(cellID);
      }
    }
    var r = Random();
    var randIndex = r.nextInt(emptycells.length - 1);
    var cellID = emptycells[randIndex];
    int i = buttonsList.indexWhere((p) => p.id == cellID);
    playGame(buttonsList[i]);
  }

  // int? checkWinner() {
  //   var winner = -1;
  //   if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
  //     winner = 2;
  //   }
  //   //row2
  //   if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
  //     winner = 2;
  //   }
  //   //row3
  //   if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
  //     winner = 2;
  //   }
  //   //col1
  //   if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
  //     winner = 2;
  //   }
  //   //col2
  //   if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
  //     winner = 2;
  //   }
  //   //col3
  //   if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
  //     winner = 2;
  //   }
  //   //diagonal1
  //   if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
  //     winner = 2;
  //   }
  //   //diagonal2
  //   if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
  //     winner = 2;
  //   }
  //   if (winner != -1) {
  //     showDialog(
  //         context: context,
  //         builder: (_) => CustomDialog("Player 1 Won",
  //             "press the reset button to start again", resetGame));
  //   } else {
  //     showDialog(
  //         context: context,
  //         builder: (_) => CustomDialog("Player 2 Won",
  //             "press the reset button to start again", resetGame));
  //   }
  // }
  //
  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              itemCount: buttonsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0),
              itemBuilder: (BuildContext context, i) => SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  child: Text(
                    buttonsList[i].text!,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: buttonsList[i].enabled
                      ? () => playGame(buttonsList[i])
                      : null,
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(buttonsList[i].bg)),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: resetGame,
            child: Text(
              "Reset",
              style: TextStyle(fontSize: 16, color: Colors.white38),
            ),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20), primary: Colors.black87),
          )
        ],
      ),
    );
  }
}
