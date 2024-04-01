import 'dart:async';
import 'package:flutter_projects/models/model.dart';
import 'package:flutter_projects/models/user_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_projects/data.dart';
import 'package:flutter_projects/models/todo_item.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

abstract class DB {
  static Database? db;

  static int version = 1;

  static Future<void> init() async {
    if (db != null) return;

    try {
      String path = '${await getDatabasesPath()}main_db.db';
      db = await openDatabase(path, version: version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE study_buildings ('
        'id INTEGER PRIMARY KEY NOT NULL,'
        'name TEXT,'
        'fullName TEXT,'
        'address TEXT,'
        'link TEXT,'
        'moreInformation TEXT,'
        'phoneNumberText TEXT,'
        'phoneNumber TEXT,'
        'similarWords TEXT,'
        'notes TEXT,'
        'favorite INTEGER,'
        'blackList INTEGER,'
        'type TEXT,'
        'image TEXT,'
        'lat REAL,'
        'long REAL,'
        'routePoints TEXT)');
    for (var building in studyData) {
      await db.insert(BuildingItem.studyBuildingsTable, building.toMap());
    }

    await db.execute('CREATE TABLE sport_buildings ('
        'id INTEGER PRIMARY KEY NOT NULL,'
        'name TEXT,'
        'fullName TEXT,'
        'address TEXT,'
        'link TEXT,'
        'moreInformation TEXT,'
        'phoneNumberText TEXT,'
        'phoneNumber TEXT,'
        'similarWords TEXT,'
        'notes TEXT,'
        'favorite INTEGER,'
        'blackList INTEGER,'
        'type TEXT,'
        'image TEXT,'
        'lat REAL,'
        'long REAL,'
        'routePoints TEXT)');
    for (var building in sportData) {
      await db.insert(BuildingItem.sportBuildingsTable, building.toMap());
    }

    await db.execute('CREATE TABLE user_info ('
        'showNotifications INTEGER,'
        'showNodeList INTEGER)');
    await db.insert(UserInfo.tableName, userInfo.toMap());
  }

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      await db!.query(table);

  static Future<int> insert(String table, Model model) async =>
      await db!.insert(table, model.toMap());

  static Future<int> update(
      String table, Model model,
      [int? favorite, int? blackList, String? date, String? newNote,
        List<Point>? newPointsList]) async {
    return await db!.update(
        table,
        BuildingItem(
            id: (model as BuildingItem).id,
            name: model.name,
            fullName: model.fullName,
            address: model.address,
            link: model.link,
            moreInformation: model.moreInformation,
            phoneNumberText: model.phoneNumberText,
            phoneNumber: model.phoneNumber,
            similarWords: model.similarWords,
            notes: date != null && newNote != null ?
                () {
              if (newNote == '') {
                model.notes.remove(date);
              } else if(model.notes.keys.contains(date)){
                model.notes[date] = newNote;
              } else {
                model.notes[date] = newNote;
              }
              return model.notes;
            }.call() : model.notes,
            favorite: favorite ?? model.favorite,
            blackList: blackList ?? model.blackList,
            type: model.type,
            image: model.image,
            buildingCoordinates: model.buildingCoordinates,
            routePoints: newPointsList ?? model.routePoints
        ).toMap(),
        where: 'id = ?',
        whereArgs: [model.id]
    );
  }

  static Future<int> delete(String table, Model model) async =>
      await db!.delete(table, where: 'id = ?', whereArgs: [(model as BuildingItem).id]);

  static Future<List<Map<String, dynamic>>> getUserInfo(String table) async =>
      await db!.query(table);

  static Future<int> changeUserInfo(String table, Model model) async =>
    await db!.update(table, model.toMap());
}
