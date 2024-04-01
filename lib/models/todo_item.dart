import 'package:flutter_projects/models/model.dart';
import 'package:flutter_projects/coordinates_class.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class BuildingItem implements Model {
  BuildingItem(
      {required this.id,
      required this.name,
      required this.fullName,
        required this.address,
        required this.link,
        required this.moreInformation,
        required this.phoneNumberText,
        required this.phoneNumber,
      required this.similarWords,
      required this.notes,
      required this.favorite,
      required this.blackList,
      required this.type,
      required this.image,
      required this.buildingCoordinates,
      required this.routePoints});

  static String studyBuildingsTable = 'study_buildings';
  static String sportBuildingsTable = 'sport_buildings';
  static String favoriteBlackListCount = 'study_and_sport_favorite_and_black_list_count';

  final int id;
  final String name;
  final String fullName;
  final String address;
  final String link;
  final String moreInformation;
  final String phoneNumberText;
  final String phoneNumber;
  final List<String> similarWords;
  final Map<String, String> notes;
  final int favorite;
  final int blackList;
  final String type;
  final String image;
  final Coordinates buildingCoordinates;
  final List<Point> routePoints;

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'fullName': fullName,
      'address': address,
      'link': link,
      'moreInformation': moreInformation,
      'phoneNumberText': phoneNumberText,
      'phoneNumber': phoneNumber,
      'similarWords': similarWords.isNotEmpty ? similarWords.join('|') : '',
      'notes': notes.isNotEmpty
          ? [for (var date in notes.keys) '$date * ${notes[date]}'].join('|')
          : '',
      'favorite': favorite,
      'blackList': blackList,
      'type': type,
      'image': image,
      'lat': buildingCoordinates.lat,
      'long': buildingCoordinates.long,
      'routePoints': routePoints.isNotEmpty ? [
        for (Point point in routePoints)
          '${point.latitude}*${point.longitude}'
      ].join('|') : ''
    };
    return map;
  }

  static BuildingItem fromMap(Map<String, dynamic> map) {
    return BuildingItem(
        id: map['id'],
        name: map['name'],
        fullName: map['fullName'],
        address: map['address'],
        link: map['link'],
        moreInformation: map['moreInformation'],
        phoneNumberText: map['phoneNumberText'],
        phoneNumber: map['phoneNumber'],
        similarWords: map['similarWords'].toString().split('|'),
        notes: () {
          List<String> pairsDateMessage = map['notes'].toString().split('|');
          Map<String, String> resultMap = {};
          for (var element in pairsDateMessage) {
            List<String> buf = element.split('*');
            if (buf.length > 1) {
              resultMap[buf[0].trim()] = buf[1].trim();
            }
          }
          return resultMap;
        }.call(),
      favorite: map['favorite'],
      blackList: map['blackList'],
      type: map['type'],
      image: map['image'],
      buildingCoordinates: Coordinates(lat: map['lat'], long: map['long']),
      routePoints: () {
          if (map['routePoints'].toString().isNotEmpty) {
            List<String> buf = map['routePoints'].toString().split('|');
            List<Point> points = [];
            for (String point in buf) {
              List<String> latLongList = point.split('*');
              points.add(
                  Point(
                      latitude: double.parse(latLongList[0]),
                      longitude: double.parse(latLongList[1])
                  )
              );
            }
            return points;
          } else {
            return <Point>[];
          }
        }.call()
    );
  }
}
