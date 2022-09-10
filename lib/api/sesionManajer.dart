// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? idMember;

  Future<void> saveSessions(int? myId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', myId ?? 0);
  }

  Future getSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idMember = prefs.getInt('id');
    return idMember;
  }

  Future clearSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

final session = SessionManager();
