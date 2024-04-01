import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/building_information_widget.dart';
import 'package:flutter_projects/data.dart';
import 'package:flutter_projects/map_screen.dart';
import 'package:flutter_projects/models/todo_item.dart';
import 'package:flutter_projects/notes_window_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'building_data_class.dart';
import 'connection_between_widgets.dart';

class BuildingPage extends StatefulWidget {
  const BuildingPage({super.key, required this.building});

  final BuildingItem building;

  @override
  State<StatefulWidget> createState() => BuildingPageState();
}

class BuildingPageState extends State<BuildingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, appData, child) {
      Provider.of<AppData>(context, listen: false).refreshUserInfo();
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.building.name),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 1),
            child: Divider(
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        body: ListView(
          children: [
            ClipRRect(child: Image.asset(widget.building.image),),
            Divider(
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                const SizedBox(width: 16,),
                SizedBox(
                  width: 350,
                  child: Text(
                    widget.building.fullName,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            const Divider(
              height: 1,
            ),
            const SizedBox(height: 16,),
            BuildingInformation(building: widget.building),
            Divider(
              height: 1,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: Provider.of<AppData>(context, listen: false)
                    .userInfo.showNodeList ?
                [
                  GestureDetector(
                      child: SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () { Provider.of<AppData>(context, listen: false).changeShowNodeList(); },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.25)
                              ),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero
                                  )
                              )
                          ),
                          child: Provider.of<AppData>(context, listen: false)
                              .userInfo.showNodeList ?
                          IconButton(
                              onPressed: () {Provider.of<AppData>(context, listen: false).changeShowNodeList();},
                              icon: const Icon(Icons.arrow_drop_up_outlined)
                          ): IconButton(
                              onPressed: () {Provider.of<AppData>(context, listen: false).changeShowNodeList();},
                              icon: const Icon(Icons.arrow_drop_down_outlined)),
                        ),
                      ),
                  ),
                 NotesWindow(building: widget.building),
                ] : [
                  GestureDetector(
                      child: SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () { Provider.of<AppData>(context, listen: false).changeShowNodeList(); },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero
                                  )
                              )
                          ),
                          child: Provider.of<AppData>(context, listen: false)
                              .userInfo.showNodeList ?
                          IconButton(
                              onPressed: () {Provider.of<AppData>(context, listen: false).changeShowNodeList();},
                              icon: const Icon(Icons.arrow_drop_up_outlined)
                          ): IconButton(
                              onPressed: () {Provider.of<AppData>(context, listen: false).changeShowNodeList();},
                              icon: const Icon(Icons.arrow_drop_down_outlined)),
                        ),
                      ),
                      onTap: () {
                        Provider.of<AppData>(context, listen: false).changeShowNodeList();
                      }
                  )
                ]
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Местоположение на карте:'),
            ),
            MapScreen(building: widget.building,),
          ],
        ),
      );
    },);
  }
}
