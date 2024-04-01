import 'package:flutter/material.dart';
import 'package:flutter_projects/services/db.dart';
import 'package:flutter_projects/models/todo_item.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'models/user_info.dart';

class AppData extends ChangeNotifier {
  int currentPage = 1;
  int navigationBarCurrentPage = 1;
  late UserInfo userInfo;
  List<BuildingItem> studyBuildings = [];
  List<BuildingItem> sportBuildings = [];
  List<BuildingItem> favStudyBuildings = [];
  List<BuildingItem> favSportBuildings = [];
  List<BuildingItem> blackListStudyBuildings = [];
  List<BuildingItem> blackListSportBuildings = [];
  List<String?> searchAndErrorText = ['', null];

  void refreshStudyBuildingsData() async {
    List<Map<String, dynamic>> buf = await DB.query(BuildingItem.studyBuildingsTable);
    studyBuildings = [for (var building in buf) BuildingItem.fromMap(building)];
    favStudyBuildings = [];
    blackListStudyBuildings = [];
    for (var building in studyBuildings) {
      if (building.favorite == 1) {
        favStudyBuildings.add(building);
      }
      if (building.blackList == 1) {
        blackListStudyBuildings.add(building);
      }
    }
    notifyListeners();
  }

  void refreshSportBuildingsData() async {
    List<Map<String, dynamic>> buf = await DB.query(BuildingItem.sportBuildingsTable);
    sportBuildings = [for (var building in buf) BuildingItem.fromMap(building)];
    favSportBuildings = [];
    blackListSportBuildings = [];
    for (var building in sportBuildings) {
      if (building.favorite == 1) {
        favSportBuildings.add(building);
      }
      if (building.blackList == 1) {
        blackListSportBuildings.add(building);
      }
    }
    notifyListeners();
  }

  void updateStudyBuildingsData(BuildingItem building, [int? newFavoriteValue,
    int? newBlackListValue, List<Point>? newPointsList]) {
    DB.update(BuildingItem.studyBuildingsTable, building, newFavoriteValue,
        newBlackListValue, null, null, newPointsList);
    refreshStudyBuildingsData();
  }

  void updateSportBuildingsData(BuildingItem building, [int? newFavoriteValue,
    int? newBlackListValue, List<Point>? newPointsList]) {
    DB.update(BuildingItem.sportBuildingsTable, building, newFavoriteValue,
        newBlackListValue, null, null, newPointsList);
    refreshSportBuildingsData();
  }

  void updateNotes(BuildingItem building, String date, String newNote) {
    if (building.type == 'study') {
      DB.update(BuildingItem.studyBuildingsTable, building, null, null, date, newNote);
      refreshStudyBuildingsData();
    } else {
      DB.update(BuildingItem.sportBuildingsTable, building, null, null, date, newNote);
      refreshSportBuildingsData();
    }
  }

  void changeCurrentPage({required int newPageIndex}) {
    currentPage = newPageIndex;
    notifyListeners();
  }

  void changeNavigationBarCurrentPage({required int newPageIndex}) {
    navigationBarCurrentPage = newPageIndex;
    notifyListeners();
  }

  void refreshUserInfo() async {
    List<Map<String, dynamic>> buf = await DB.getUserInfo(UserInfo.tableName);
    userInfo = UserInfo.fromMap(buf[0]);
  }

  void updateUserInfo() {
    DB.changeUserInfo(UserInfo.tableName, userInfo);
    notifyListeners();
  }

  void changeShowNotifications() {
    userInfo = UserInfo(
        showNotifications: !userInfo.showNotifications,
        showNodeList: userInfo.showNodeList
    );
    updateUserInfo();
  }

  void changeShowNodeList() {
    userInfo = UserInfo(
        showNotifications: userInfo.showNotifications,
        showNodeList: !userInfo.showNodeList
    );
    updateUserInfo();
  }

  void changeSearchText({required String newSearchText}) {
    searchAndErrorText[0] = newSearchText;
  }

  void changeErrorText({required String? newErrorText}) {
    searchAndErrorText[1] = newErrorText;
  }
}