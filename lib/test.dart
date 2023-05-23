import 'package:flutter/material.dart';
import 'game_button.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<GameButton> buttonsList;
  var player1;
  var player2;
  var activeplayer;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    player1 = [];
    player2 = [];
    activeplayer = 1;
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
      if (activeplayer == 1) {
        gb.text = "X";
        gb.bg = Colors.red;
        activeplayer = 2;
        player1.add(gb.id);
      }
      else{
        gb.text = "O";
        gb.bg = Colors.green;
        activeplayer =1;
        player2.add(gb.id);

      }
      gb.enabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: GridView.builder(
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
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
            onPressed:
            buttonsList[i].enabled ? () => playGame(buttonsList[i]) : null,
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(8),onSurface: buttonsList[i].bg, primary: buttonsList[i].bg),
          ),
        ),
      ),
    );
  }
}
