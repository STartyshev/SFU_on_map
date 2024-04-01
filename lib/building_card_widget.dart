import 'package:flutter/material.dart';
import 'package:flutter_projects/building_data_class.dart';
import 'package:flutter_projects/connection_between_widgets.dart';
import 'package:flutter_projects/data.dart';
import 'package:flutter_projects/delete_building_alert_dialog_widget.dart';
import 'package:flutter_projects/main.dart';
import 'package:flutter_projects/notes_window_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_projects/models/todo_item.dart';

class BuildingCard extends StatefulWidget {
  const BuildingCard({super.key, required this.buildingData});

  final BuildingItem buildingData;

  @override
  State<StatefulWidget> createState() => BuildingCardState();
}

class BuildingCardState extends State<BuildingCard> {
  bool showNotesWindow = false;
  @override
  Widget build(BuildContext context) {
    int currentPage = Provider.of<AppData>(context, listen: false).currentPage;
    bool favoritesIconPressed = widget.buildingData.favorite == 1 ? true : false;
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                child:  Image.asset(widget.buildingData.image),
              ),
              const SizedBox(height: 16,),
              Text(
                  widget.buildingData.name,
                  style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8,),
              const Divider(),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (widget.buildingData.type == 'study') {
                          Provider.of<AppData>(context, listen: false)
                              .updateStudyBuildingsData(widget.buildingData, (widget.buildingData.favorite - 1).abs());
                        } else {
                          Provider.of<AppData>(context, listen: false)
                              .updateSportBuildingsData(widget.buildingData, (widget.buildingData.favorite - 1).abs());
                        }
                      },
                      icon: favoritesIconPressed
                          ? const Icon(Icons.favorite_outlined)
                          : const Icon(Icons.favorite_outline),
                      color: favoritesIconPressed ? Colors.red : null,
                    ),
                    const VerticalDivider(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showNotesWindow = !showNotesWindow;
                        });
                      },
                      icon: const Icon(Icons.comment_outlined),
                    ),
                    const VerticalDivider(),
                    IconButton(
                      onPressed: () {
                        if (Provider.of<AppData>(context, listen: false)
                            .userInfo.showNotifications) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  DeleteBuildingAlertDialog(
                                      buildingData: widget.buildingData));
                        } else {
                          if (widget.buildingData.type == 'study') {
                            Provider.of<AppData>(context, listen: false)
                                .updateStudyBuildingsData(widget.buildingData, 0, 1);
                          } else {
                            Provider.of<AppData>(context, listen: false)
                                .updateSportBuildingsData(widget.buildingData, 0, 1);
                          }
                        }
                      },
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
          //),
        ),
      showNotesWindow ?
      Card(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: NotesWindow(building: widget.buildingData),
      ) :
      const SizedBox(height: 0,)
      ],
    );
  }
}
