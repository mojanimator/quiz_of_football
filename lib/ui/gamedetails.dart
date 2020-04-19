import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:quiz_of_football/customs/dimens.dart';
import 'package:quiz_of_football/customs/theme.dart';
import 'package:quiz_of_football/games/logo.dart';
import 'package:quiz_of_football/model/user.dart';
import 'package:quiz_of_football/model/vsgame.dart';
import 'package:quiz_of_football/ui/gamestatus.dart';

class GameDetails extends StatefulWidget {
  final VSGame vsGame;
  final int me_id;

  GameDetails(this.vsGame, this.me_id);

  @override
  _GameDetailsState createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {
  User player1, player2;
  List<dynamic> p1Status, p2Status;
  int p1Score = 0;
  int p2Score = 0;

  String gameState;

//  Future<VSGame> vsGame;

  _startGame(VSGame vsGame) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Logo(vsGame, player1, p1Status, p2Status))).then((value) {
      setState(() {
        p1Status = value[0];
        p2Status = value[1];
        for (int s in p1Status) {
          if (s != null) p1Score += s;
        }
        for (int s in p2Status) {
          if (s != null) p2Score += s;
        }
        gameState = getGameState(p1Status);
      });
    });
  }

  _gameStatus() {
    Navigator.pop(
        context, MaterialPageRoute(builder: (context) => GameStatus()));
  }

  @override
  void initState() {
    print("init gamedetails");
    if (widget.vsGame.p1_id == widget.me_id) {
      player1 = widget.vsGame.player1;
      player2 = widget.vsGame.player2;
      p1Status = widget.vsGame.p1_status;
      p2Status = widget.vsGame.p2_status;
    } else {
      player2 = widget.vsGame.player1;
      player1 = widget.vsGame.player2;
      p2Status = widget.vsGame.p1_status;
      p1Status = widget.vsGame.p2_status;
    }
    for (int s in p1Status) {
      if (s != null) p1Score += s;
    }
    for (int s in p2Status) {
      if (s != null) p2Score += s;
    }

    gameState = getGameState(p1Status);
    SchedulerBinding.instance.addPostFrameCallback((_) {
//      widget.vsGame = Functions.findGamer(context, {'game_id': '1'});
//      _startGame(widget.vsGame);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(color: MyColors.TopClipper),
            clipper: TopClipper(),
          ),
          ClipPath(
            child: Container(color: MyColors.TopClipperTwo),
            clipper: TopClipperTwo(),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50.0, bottom: 15.0),
                child: Center(
                  child: Text(
                    widget.vsGame.limit_time.toString() + " min",
                    style: MyStyles.timeTextStyle,
                  ),
                ),
              ),
              Container(
//                padding: EdgeInsets.only(top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          player1.username,
                          style: MyStyles.profileTextStyle,
                        ),
                      ),
                      player1.img == null
                          ? CircleAvatar(
                              child: Image.asset("images/avatars/boy-2.png"),
                              backgroundColor: MyColors.avatarBackground,
                              radius: Dimens.avatarRadius / 2,
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  AdvancedNetworkImage(player1.img),
                              radius: Dimens.avatarRadius / 2,
                            ),
                    ]),
                    VerticalDivider(
                      width: 10.0,
                      color: Colors.white,
                    ),
                    Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          player2.username,
                          style: MyStyles.profileTextStyle,
                        ),
                      ),
                      player2.img == null
                          ? CircleAvatar(
                              child: Image.asset("images/avatars/boy-2.png"),
                              backgroundColor: MyColors.avatarBackground,
                              radius: Dimens.avatarRadius / 2,
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  AdvancedNetworkImage(player2.img),
                              radius: Dimens.avatarRadius / 2,
                            ),
                    ]),
                  ],
                ),
              ),
              Divider(
                thickness: 5.0,
                color: Colors.white,
              ),
              //status options

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 30.0,
                      bottom: MediaQuery.of(context).size.height * 1 / 4),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //questions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                                children: p1Status
                                    .map(
                                      (e) => Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: getColor(e),
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        margin: EdgeInsets.only(
                                          left: 10.0,
                                          bottom: 15.0,
                                        ),
                                      ),
                                    )
                                    .toList()),
//                          VerticalDivider(
//                            width: 5.0,
//                            color: Colors.white,
//                          ),
                            Column(
                                children: p2Status
                                    .map(
                                      (e) => Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: getColor(e),
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        margin: EdgeInsets.only(
                                          left: 10.0,
                                          bottom: 15.0,
                                        ),
                                      ),
                                    )
                                    .toList()),
                          ],
                        ),
                        //below widgets
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
//              color: Colors.black,
              color: MyColors.darkContainer,
              child: Column(
                children: [
                  //scores text
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Center(
                        child: Text(
                      "Scores",
                      style: MyStyles.profileTextStyle,
                    )),
                  ),
//                  scores row
                  Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(p1Score.toString(),
                            style: MyStyles.profileTextStyle),
                        VerticalDivider(
                          width: 5.0,
                          color: Colors.white,
                        ),
                        Text(
                          p2Score.toString(),
                          style: MyStyles.profileTextStyle,
                        ),
                      ],
                    ),
                  ),
                  //button
                  Container(
                    width: MediaQuery.of(context).size.width * 4 / 5,
                    height: MediaQuery.of(context).size.height * 1 / 8,
                    padding: const EdgeInsets.all(15),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: gameState == "s"
                          ? MyColors.answerCorrect
                          : gameState == "r"
                              ? MyColors.primaryButton
                              : MyColors.floatButton,
                      child: InkWell(
                        child: Text(
                          gameState == "s"
                              ? "Start"
                              : gameState == "r" ? "Resume" : "Back To Games",
                          style: MyStyles.profileTextStyle,
                        ),
                      ),
                      onPressed: () {
                        gameState == "s"
                            ? _startGame(widget.vsGame)
                            : gameState == "r"
                                ? _startGame(widget.vsGame)
                                : Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Center(
                        child: Text(
                      "Time",
                      style: MyStyles.profileTextStyle,
                    )),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("48", style: MyStyles.profileTextStyle),
                        VerticalDivider(
                          width: 5.0,
                          color: Colors.white,
                        ),
                        Text(
                          "36",
                          style: MyStyles.profileTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
//
//
//
//
        ],
      ),
    );
  }

  Color getColor(int e) {
    switch (e) {
      case 2:
        return MyColors.answerCorrect;
        break;
      case -1:
        return MyColors.answerWrong;
        break;
      case 0:
        return MyColors.answerWhitOut;
        break;

      default:
        return MyColors.answerBox;
        break;
    }
  }

  String getGameState(List<dynamic> p1_status) {
    int i = 0;
    for (int s in p1_status) {
      if (s == null) {
        if (i == 0)
          return "s";
        else
          return "r";
      } else
        i++;
    }
    if (i == p1_status.length - 1)
      return "e";
    else
      return "n";
  }
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height / 3);
    path.lineTo(size.width, size.height / 5);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class TopClipperTwo extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(size.width / 2, 0.0);
    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
