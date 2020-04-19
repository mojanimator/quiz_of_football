import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:quiz_of_football/customs/VSGameBloc.dart';
import 'package:quiz_of_football/customs/dimens.dart';
import 'package:quiz_of_football/customs/loaders.dart';
import 'package:quiz_of_football/customs/theme.dart';
import 'package:quiz_of_football/helper/functions.dart';
import 'package:quiz_of_football/model/user.dart';
import 'package:quiz_of_football/model/vsgame.dart';
import 'package:quiz_of_football/ui/gamedetails.dart';

class GameStatus extends StatefulWidget {
  @override
  _GameStatusState createState() => _GameStatusState();
}

class _GameStatusState extends State<GameStatus> {
  User me;

  VSGameBloc _bloc;

  List<VSGame> vsGames = List<VSGame>();
  Future<User> user;

  @override
  void initState() {
    _bloc ??= VSGameBloc();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshData();
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
          RefreshIndicator(
            onRefresh: () => _refreshData(),
            child: Stack(
              children: <Widget>[
                // user profile widget
                SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      //find active vs games
                      Container(
                        width: double.infinity,
                        child: StreamBuilder(
                          stream: _bloc.stream,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Text(
                                  "Disconnected",
                                  style: TextStyle(color: Colors.white),
                                );
                              case ConnectionState.waiting:
                                return Center(
                                    widthFactor:
                                        MediaQuery.of(context).size.width / 2,
                                    heightFactor:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Loader());
                              case ConnectionState.done:
                                return Text(
                                  'Done',
                                  style: TextStyle(color: Colors.white),
                                );
                              case ConnectionState.active:
//            print(snapshot.data);
                                if (snapshot.hasError || !snapshot.hasData) {
                                  return Container(
                                      child: Center(
                                          child: IconButton(
                                    padding: EdgeInsets.all(10.0),
                                    iconSize:
                                        MediaQuery.of(context).size.width / 10,
                                    icon: Icon(
                                      Icons.refresh,
                                      color: Colors.white70,
                                    ),
                                    onPressed: () {
                                      _refreshData();
                                    },
                                  )));
                                } else {
                                  // streamController.sink.add(snapshot.data.length);
                                  // if(snapshot.data.length==0) return;R
                                  //  print(snapshot.data[0].id);
                                  vsGames.addAll(snapshot.data);

                                  //delete this after test
//                                  _openVSGame(vsGames[0]);
                                  snapshot.data.clear();
//                                  print(vsGames.length);
                                  return Column(
                                    children: <Widget>[
                                      Container(
                                        child: Text("MY GAMES"),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: MyColors.backgroundColor,
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                2 /
                                                5,
                                            right: 10.0,
                                            left: 10.0),
                                        child: Column(
                                          children: gameRows(vsGames),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                break;
                              default:
                                return Text('');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(
                            top: 50.0, left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                            color: MyColors.primaryButton,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10.0)),
                        width: double.infinity,
                        height: Dimens.avatarRadius * 2.5,
                        child: Stack(
                          children: <Widget>[
                            ClipPath(
                              child: Container(color: MyColors.TopClipperThree),
                              clipper: TopClipperThree(),
                            ),
                            ClipPath(
                              child: Container(color: MyColors.TopClipperFour),
                              clipper: TopClipperFour(),
                            ),
                            FutureBuilder<User>(
                              future: Functions.getUser(context, {"id": "-1"}),
                              builder: (BuildContext context,
                                  AsyncSnapshot<User> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Text(
                                      "connection none",
                                      style: TextStyle(color: Colors.white),
                                    );
                                  case ConnectionState.waiting:
                                    return Center(
                                        child: CircularProgressIndicator());
                                  case ConnectionState.active:
                                    return Center(child: Text("active"));
                                    break;
                                  case ConnectionState.done:
                                    // TODO: Handle this case.
                                    break;
                                }
                                if (snapshot.hasError) {
                                  print(snapshot.error);
                                  return Center(
                                    child: Text("Somethings goes wrong!"),
                                  );
                                } else if (snapshot.hasData) {
                                  me = snapshot.data;

                                  return Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(me.username,
                                                    style: MyStyles
                                                        .profileTextStyle),
                                                me.img == null
                                                    ? CircleAvatar(
                                                        child: Image.asset(
                                                            "images/avatars/boy.png"),
                                                        backgroundColor: MyColors
                                                            .avatarBackground,
                                                        radius: Dimens
                                                                .avatarRadius /
                                                            2,
                                                      )
                                                    : CircleAvatar(
                                                        backgroundImage:
                                                            AdvancedNetworkImage(
                                                                me.img),
                                                        radius: 20.0,
                                                      ),
//                                    : AdvancedNetworkImage(me.img),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: MyColors.level),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Text(
                                                      Functions.getLevel(
                                                          me.score),
                                                      style: MyStyles
                                                          .profileTextStyle,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(2.0),
                                                      child: FlatButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                        color: MyColors
                                                            .floatButton,
                                                        child: InkWell(
                                                          child: Text(
                                                            "Find Player",
                                                            style: MyStyles
                                                                .profileTextStyle,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          _findPlayer();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: FlatButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                        color: MyColors
                                                            .floatButton,
                                                        child: InkWell(
                                                          child: Text(
                                                            "league",
                                                            style: MyStyles
                                                                .profileTextStyle,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                        onPressed: _findLeague,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _refreshData() async {
    print("refreshdata");
    vsGames.clear();
    user = Functions.getUser(context, {"id": "-1"});

    _bloc.sink.add(await Functions.myGames(context, {"game_id": "1"}));
  }

  _findPlayer() async {
    VSGame _vsGame = await Functions.findGamer(context, {"game_id": "1"});

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GameDetails(_vsGame, me.id))).then((val) {
      setState(() {
        print("refresh");
        _refreshData();
      });
    });
  }

  _findLeague() {}

  _openVSGame(VSGame vsGame) {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => GameDetails(vsGame, me.id)))
        .then((val) {
      setState(() {
        print("refresh");
        _refreshData();
      });
    });
  }

  List<Widget> gameRows(List<VSGame> vsGames) {
    return vsGames
        .map((e) => GestureDetector(
            child: Container(
              margin: EdgeInsets.only(bottom: 10.0, right: 20.0, left: 20.0),
              decoration: BoxDecoration(
                  color: MyColors.myGameContainer,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  me.img == null
                      ? CircleAvatar(
                          child: Image.asset("images/avatars/boy-2.png"),
                          backgroundColor: MyColors.avatarBackground,
                          radius: Dimens.avatarRadius / 2,
                        )
                      : CircleAvatar(
                          backgroundImage: AdvancedNetworkImage(
                            e.p1_id == me.id ? e.player2.img : e.player1.img,
                          ),
                          radius: 20.0,
                        ),
                  Text(
                    e.p1_id == me.id ? e.player2.username : e.player1.username,
                    style: MyStyles.profileTextStyle,
                  ),
                  Text(
                    e.limit_time.toString() + " " + "min",
                    style: MyStyles.profileTextStyle,
                  ),
                ],
              ),
            ),
            onTap: () {
              return _openVSGame(e);
            }))
        .toList();
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

class TopClipperThree extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height * 19 / 20);
    path.lineTo(size.width, size.height / 5);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);

//    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class TopClipperFour extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(size.width / 2, 0.0);
    path.lineTo(size.width, size.height * 3 / 4);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
