//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quiz_of_football/customs/data.dart';
import 'package:quiz_of_football/customs/dimens.dart';
import 'package:quiz_of_football/games/logo.dart';
import 'package:quiz_of_football/ui/gamedetails.dart';
import 'package:quiz_of_football/ui/gamestatus.dart';
import 'package:quiz_of_football/ui/profile.dart';

import 'dart:math';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.3;

class _MyAppState extends State<MyApp> {
  var currentPage = images.length - 1.0;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GameStatus()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Dimens.size = MediaQuery.of(context).size;
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 100),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.indigo[300],
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.white,
                          child: Image.asset("images/avatars/boy-1.png",
                              alignment: Alignment.centerLeft),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Fazel babaei rudsari",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  inherit: false),
                            ),
                            Text(
                              "Iran",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  inherit: false),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "lvl",
                              style: TextStyle(
                                inherit: false,
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Text("23",
                                  style: TextStyle(
                                      inherit: false,
                                      fontSize: 20.0,
                                      color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                }),
            Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: Text("Games",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    letterSpacing: 5.0,
                  )),
            ),
            GestureDetector(
              child: Stack(
                children: <Widget>[
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                      child: PageView.builder(
                    itemCount: images.length,
                    controller: controller,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Container();
                    },
                  ))
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GameStatus()));
              },
            )
          ],
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                        blurRadius: 30.0),
                  ],
                ),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.asset(
                          images[i],
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            title[i],
                            style:
                                TextStyle(fontSize: 40.0, letterSpacing: 2.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(children: cardList);
      }),
    );
  }
}
