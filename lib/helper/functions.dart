import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_of_football/helper/variables.dart';
import 'package:quiz_of_football/model/user.dart';
import 'package:quiz_of_football/model/vsgame.dart';

class Functions {
  static var client = http.Client();

  static String getLevel(int score) {
    return score.toString();
  }

  static Future<VSGame> findGamer(context, params) async {
    try {
      Uri uri = Uri.parse(Variable.LINK_FIND_GAMER);
      final newURI = uri.replace(queryParameters: params);
//      print(newURI);
//
// if (accessToken != '')
      return client.get(
        newURI,
        headers: {"Content-Type": "application/json"},
      ).then((http.Response response) async {
        if (response.statusCode != 200) return null;
        var parsedJson = json.decode(response.body);
//        print(parsedJson);
        parsedJson['vsgame']['player1'] = parsedJson['player1'];
        parsedJson['vsgame']['player2'] = parsedJson['player2'];
        return VSGame.fromJson(parsedJson["vsgame"]);
      }, onError: (e) {
//        showMessage(context, "Check Your Internet Connection And Try Again !");
        print(e);
        return null;
      });
    } catch (e) {
      print(e);

//      showMessage(context, "Check Your Internet Connection And Try Again !");
      return null;
    }
  }

  static Future<List<VSGame>> myGames(context, params) async {
    try {
      Uri uri = Uri.parse(Variable.LINK_MY_GAMES);
      final newURI = uri.replace(queryParameters: params);
//      print(newURI);
//
// if (accessToken != '')
      return client.get(
        newURI,
        headers: {"Content-Type": "application/json"},
      ).then((http.Response response) async {
        if (response.statusCode != 200) return null;
        List<VSGame> vsGames = List<VSGame>();
        var parsedJson = json.decode(response.body);
//        print(parsedJson[0]);
        for (final tmp in parsedJson) {
          VSGame vg = VSGame.fromJson(tmp);

          vsGames.add(vg);
        }
//        print("dsddddddddddddddddddddddddddddddddddddddddddd" +
//            vsGames.length.toString());
        return vsGames;
      }, onError: (e) {
//        showMessage(context, "Check Your Internet Connection And Try Again !");
        print(e);
        return null;
      });
    } catch (e) {
      print(e);

//      showMessage(context, "Check Your Internet Connection And Try Again !");
      return null;
    }
  }

  static dynamic gameUpdate(context, params) async {
    try {
      Uri uri = Uri.parse(Variable.LINK_GAME_UPDATE);
      final newURI = uri.replace(queryParameters: params);
//      print(newURI);
//
// if (accessToken != '')
      return client.get(
        newURI,
        headers: {"Content-Type": "application/json"},
      ).then((http.Response response) async {
        if (response.statusCode != 200) return null;

        print(response.body);
        return json.decode(response.body);
      }, onError: (e) {
//        showMessage(context, "Check Your Internet Connection And Try Again !");
        print(e);
        return null;
      });
    } catch (e) {
      print(e);

//      showMessage(context, "Check Your Internet Connection And Try Again !");
      return null;
    }
  }

  static Future<User> getUser(context, params) async {
    try {
      Uri uri = Uri.parse(Variable.LINK_GET_USER);
      final newURI = uri.replace(queryParameters: params);

      return client.get(
        newURI,
        headers: {"Content-Type": "application/json"},
      ).then((http.Response response) async {
        if (response.statusCode != 200) return null;
        var parsedJson = json.decode(response.body);

        return User.fromJson(parsedJson);
//        return parsedJson;
      }, onError: (e) {
//        showMessage(context, "Check Your Internet Connection And Try Again !");
        print(e);
        return e;
      });
    } catch (e) {
      print(e);

//      showMessage(context, "Check Your Internet Connection And Try Again !");
      return e;
    }
  }

  static void showMessage(context, message) {
    if (context == null) return;
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'X',
        textColor: Colors.yellow,
        onPressed: () {
          Scaffold.of(context).hideCurrentSnackBar();
        },
      ),
    );
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
