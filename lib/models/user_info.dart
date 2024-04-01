import 'package:flutter/cupertino.dart';
import 'package:flutter_projects/models/model.dart';

class UserInfo implements Model{
  const UserInfo({
    //required this.geolocationAccess,
    required this.showNotifications,
    required this.showNodeList
    //required this.geolocationPermissionAsked
  });

  //final bool geolocationAccess;
  final bool showNotifications;
  final bool showNodeList;
  //final bool geolocationPermissionAsked;

  static String tableName = 'user_info';

  @override
  Map<String, dynamic> toMap() {
    return {
      //'geolocationAccess': geolocationAccess ? 1 : 0,
      'showNotifications': showNotifications ? 1 : 0,
      'showNodeList': showNodeList ? 1 : 0
      //'geolocationPermissionAsked': geolocationPermissionAsked ? 1 : 0
    };
  }

  static UserInfo fromMap (Map<String, dynamic> map) {
    return UserInfo(
        //geolocationAccess: map['geolocationAccess'] != 0 ? true : false,
        showNotifications: map['showNotifications'] != 0 ? true : false,
        showNodeList: map['showNodeList'] != 0 ? true : false
        //geolocationPermissionAsked: map['geolocationPermissionAsked'] != 0 ? true : false
    );
  }
}