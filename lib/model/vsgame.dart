import 'dart:convert' as converter;

import 'package:quiz_of_football/model/user.dart';

class VSGame {
  final int id;
  final int game_id;
  final int p1_id;
  final int p2_id;
  final bool p1_done;
  final bool p2_done;

//  final String p1_username;
//  final String p2_username;
  final List<dynamic> p1_status;
  final List<dynamic> p2_status;
  final Map<String, dynamic> p1_help;
  final Map<String, dynamic> p2_help;
  final int rounds;
  final List<dynamic> questions;
  final String start_time;
  final int limit_time;
  final String created_at;
  final User player1;
  final User player2;

  VSGame(
    this.id,
    this.game_id,
    this.p1_id,
    this.p2_id,
    this.questions,
    this.p1_done,
    this.p2_done,
    this.p1_status,
    this.p2_status,
    this.rounds,
    this.start_time,
    this.limit_time,
    this.created_at,
    this.player1,
    this.player2,
    this.p1_help,
    this.p2_help,
  );

  VSGame.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        game_id = json['game_id'] as int,
        rounds = json['rounds'] as int,
        limit_time = json['limit_time'] as int,
        p1_id = json['p1_id'] as int,
        p2_id = json['p2_id'] as int,
        p1_done = json['p1_done'] as bool,
        p2_done = json['p2_done'] as bool,
        questions = converter.json.decode(json['questions']),
        p1_help = converter.json.decode(json['p1_help']),
        p2_help = converter.json.decode(json['p2_help']),
//        questions = json['questions'],
//        p1_username = json['p1_username'],
//        p2_username = json['p2_username'],
        p1_status = json['p1_status'],
        p2_status = json['p2_status'],
        start_time = json['start_time'],
        player1 = User.fromJson(json['player1']),
        player2 = User.fromJson(json['player2']),
        created_at = json['created_at'];

//  Map<String, dynamic> toJson() => {
//        'id': id,
//        'game_id': game_id,
//        'rounds': rounds,
//        'size': size,
//        'created_at': created_at,
//
//      };

// int get id => _id;

// set id(int value) {
//   _id = value;
// }

// int get group_id => _group_id;

// set group_id(int value) {
//   _group_id = value;
// }

// String get path => _path;

// set path(String value) {
//   _path = value;
// }

// int get size => _size;

// set size(int value) {
//   _size = value;
// }

// DateTime get created_at => _created_at;

// set created_at(DateTime value) {
//   _created_at = value;
// }
}
