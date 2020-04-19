import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:quiz_of_football/customs/theme.dart';
import 'package:quiz_of_football/helper/functions.dart';
import 'package:quiz_of_football/model/user.dart';
import 'package:quiz_of_football/model/vsgame.dart';

// ignore: must_be_immutable
class Logo extends StatefulWidget {
  final VSGame vsGame;
  final User player1;
  List<dynamic> p1Status;
  List<dynamic> p2Status;

  Logo(
    this.vsGame,
    this.player1,
    this.p1Status,
    this.p2Status,
  );

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  bool lastQuestion = false;
  List<int> scores = List<int>();
  List<Color> buttonColors = [
    MyColors.primaryButton,
    MyColors.primaryButton,
    MyColors.primaryButton,
    MyColors.primaryButton,
  ];

  int rounds;

  int currentQuestion;

  bool lockClick = false;

  void initState() {
    print("initLogo");
    rounds = widget.p1Status.length;
    currentQuestion = rounds;
    for (int i = 0; i < rounds; i++) {
      if (widget.p1Status[i] == null) {
        currentQuestion = i;
        break;
      }
    }
    if (currentQuestion + 1 >= rounds) lastQuestion = true;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey[600],
        body: Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                color: Colors.black54,
              ),
              clipper: TopClipper(),
            ),
            ClipPath(
              child: Container(
                color: Colors.black26,
              ),
              clipper: TopClipperTwo(),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${currentQuestion + 1}/$rounds",
                        style: MyStyles.timeTextStyle,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: widget.player1.img != null
                            ? TransitionToImage(
                                image: AdvancedNetworkImage(widget.player1.img,
                                    fallbackAssetImage:
                                        "images/avatars/boy-3.png",
                                    retryLimit: 1,
                                    timeoutDuration: Duration(seconds: 5)),
                              )
                            : Image.asset("images/avatars/boy-3.png"),
                        radius: MediaQuery.of(context).size.width / 8,
                      ),
                      Text(
                        "${currentQuestion + 1}/$rounds",
                        style: MyStyles.timeTextStyle,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0)),
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: currentQuestion < rounds
                                    ? TransitionToImage(
                                        image: AdvancedNetworkImage(
                                            widget.vsGame
                                                    .questions[currentQuestion]
                                                ['path'],
                                            fallbackAssetImage:
                                                "images/logo/11.jpg",
                                            retryLimit: 1,
                                            timeoutDuration:
                                                Duration(seconds: 5)),
                                      )
                                    : null),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 5.0,
                                        childAspectRatio: MediaQuery.of(context)
                                                .size
                                                .width /
                                            (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4)),
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        color: buttonColors[index],
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        onTap: () {
                                          _updateGame(index);
                                        },
                                        child: Center(
                                            child: currentQuestion < rounds
                                                ? Text(
                                                    index <= 2
                                                        ? widget.vsGame
                                                                    .questions[
                                                                currentQuestion]
                                                            ['opts'][index]
                                                        : "Skip",
                                                    style:
                                                        MyStyles.timeTextStyle,
                                                  )
                                                : null),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
//          )
          ],
        ),
      ),
    );
  }

  void _updateGame(int idx) async {
    if (lockClick)
      return;
    else
      lockClick = true;
    var response = await Functions.gameUpdate(context, {
      'vsgame_id': widget.vsGame.id.toString(),
      'player_id': widget.player1.id.toString(),
      'question_number': currentQuestion.toString(),
      'user_response': idx.toString()
    });
    if (response == null) {
      lockClick = false;
      return;
    }
    if (response['status'] == "ok") {
      //correct answer
      if (response['data'] == idx) {
        setState(() {
          buttonColors[0] = MyColors.primaryButton;
          buttonColors[1] = MyColors.primaryButton;
          buttonColors[2] = MyColors.primaryButton;
          buttonColors[idx] = MyColors.answerCorrect;
        });
      } //correct answer
      else {
        setState(() {
          if (idx != 3) buttonColors[idx] = MyColors.answerWrong;
          buttonColors[response['data']] = MyColors.answerCorrect;
        });
      }

      Future.delayed(const Duration(milliseconds: 1000), () {
        while (!lastQuestion && widget.p1Status[currentQuestion] != null) {
          currentQuestion++;
          if (currentQuestion + 1 >= rounds) lastQuestion = true;
          continue;
        }
//        print("$currentQuestion,$lastQuestion,${widget.p1Status}");
        if (lastQuestion && response['result'] != null) {
          setState(() {
            widget.p1Status = response['result']['p1_status'];
            widget.p2Status = response['result']['p2_status'];
          });
          Navigator.pop(context, [widget.p1Status, widget.p2Status]);
        } else {
          setState(() {
            currentQuestion++;
            if (currentQuestion + 1 >= rounds) lastQuestion = true;
            buttonColors[0] = MyColors.primaryButton;
            buttonColors[1] = MyColors.primaryButton;
            buttonColors[2] = MyColors.primaryButton;
          });
        }
        lockClick = false;
      });
    }

//      print(widget.vsGame.questions[0]);
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
