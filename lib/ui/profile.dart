import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    "images/avatars/boy-3.png",
                  ),
                  radius: MediaQuery.of(context).size.width / 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0)),
                  width: MediaQuery.of(context).size.width * 9 / 10,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.pink[200],
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "level",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                  Text(
                                    "23",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.pink[200],
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Score",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                  Text(
                                    "1600/2300",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.pink[200],
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "win",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                  Text(
                                    "12",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.pink[200],
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Country",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                  Text(
                                    "Iran",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
//          )
        ],
      ),
    );
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
