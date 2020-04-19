import 'package:flutter/material.dart';

class User {
  final int id;
  final String username;

  final String inline_role;
  final bool verified;
  final String email;
  final String telegram_id;
  final String img;
  final int score;

  final String created_at;
  final int allowed_games_limit;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        verified = json['verified'] as bool,
        username = json['username'],
        inline_role = json['inline_role'],
        img = json['img'],
        email = json['email'],
        telegram_id = json['telegram_id'],
        score = json['score'] as int,
        created_at = json['created_at'],
        allowed_games_limit = json['allowed_games_limit'] as int;
}
