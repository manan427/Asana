import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _pageRebuild = prefs.getString('ff_pageRebuild') ?? _pageRebuild;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  UserRolesStruct _userid =
      UserRolesStruct.fromSerializableMap(jsonDecode('{}'));
  UserRolesStruct get userid => _userid;
  set userid(UserRolesStruct value) {
    _userid = value;
  }

  void updateUseridStruct(Function(UserRolesStruct) updateFn) {
    updateFn(_userid);
  }

  String _comment = '';
  String get comment => _comment;
  set comment(String value) {
    _comment = value;
  }

  String _pageRebuild = '';
  String get pageRebuild => _pageRebuild;
  set pageRebuild(String value) {
    _pageRebuild = value;
    prefs.setString('ff_pageRebuild', value);
  }

  String _customError = '';
  String get customError => _customError;
  set customError(String value) {
    _customError = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
