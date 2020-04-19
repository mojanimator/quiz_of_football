import 'package:flutter/services.dart';

class Variable {
//  static String DOMAIN = "http://10.0.3.2:8000";

  static String DOMAIN = "https://qr-image-creator.com/card-game";

  static String APIDOMAIN = "${DOMAIN}/api";

  static String LINK_FIND_GAMER = "${DOMAIN}/game/findGamer";
  static String LINK_GET_USER = "${DOMAIN}/game/getUser";
  static String LINK_MY_GAMES = "${DOMAIN}/game/myGames";
  static String LINK_GAME_UPDATE = "${DOMAIN}/game/update";

  static String LINK_GROUPS = "${APIDOMAIN}/doc/groups";

  static String STORAGE = "${DOMAIN}/storage";

  static String LOGIN = "${APIDOMAIN}/login";
  static String LOGOUT = "${APIDOMAIN}/logout";

  //compare images len in database and app storage
  static String CHECK_UPDATE = "${APIDOMAIN}/checkUpdate";

  static String COMMAND_REFRESH_SCHOOLS = "REFRESH_SCHOOLS";
  static String DISCONNECTED = "Please Check Internet Connection!";

  static Map<String, dynamic> params = {'page': '1', 'group_id': '1'};
  static Map<String, dynamic> params2 = {'page': '1', 'group_id': '2'};
  static Map<String, dynamic> params3 = {'page': '1', 'group_id': '3'};
  static Map<String, dynamic> params4 = {'page': '1', 'group_id': '4'};
  static Map<String, dynamic> params5 = {'page': '1'};

  static Map<String, int> TOTAL_WALLPAPERS = {
    '1': 0,
    '2': 0,
    '3': 0,
    '4': 0,
    '5': 0,
  };
  static const platform = const MethodChannel('change_wallpaper');

  static Map<String, String> ERROR = {
    "DISCONNECTED": "اتصال برقرار نیست",
  };

  static String PHONE = "989398793845";
}

enum Commands { RefreshWallpapers }
