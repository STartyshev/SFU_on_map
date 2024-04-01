import 'package:flutter/material.dart';
import 'package:flutter_projects/connection_between_widgets.dart';

import 'building_card_widget.dart';
import 'building_page_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key, required this.appData});

  final AppData appData;

  @override
  State<StatefulWidget> createState() => FavoritesPageState();

}

class FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Избранное'),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 1),
            child: Divider(
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
          child: CustomScrollView(
            slivers: [
              SliverList.builder(
                itemBuilder: (BuildContext context, int index) {
                  bool favStudyBuildingsIsEmpty =
                      widget.appData.favStudyBuildings.isEmpty;
                  bool favSportBuildingsIsEmpty =
                      widget.appData.favSportBuildings.isEmpty;
                  int favStudyBuildingsLength =
                      widget.appData.favStudyBuildings.length;
                  if (favStudyBuildingsIsEmpty && favSportBuildingsIsEmpty) {
                    return const Text('В избранном пока ничего нет.');
                  } else {
                    if (!favStudyBuildingsIsEmpty && index < favStudyBuildingsLength) {
                      return GestureDetector(
                        child: BuildingCard(
                            buildingData: widget.appData.favStudyBuildings[index]
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder:
                                  (BuildContext context) => BuildingPage(
                                  building: widget.appData.favStudyBuildings[index]
                                  )
                              )
                          );
                        },
                      );//BuildingCard(buildingData: widget.appData.favStudyBuildings[index]);
                    }
                    if (!favSportBuildingsIsEmpty && index >= favStudyBuildingsLength) {
                      return GestureDetector(
                        child: BuildingCard(
                            buildingData: widget.appData.favSportBuildings[index - favStudyBuildingsLength]
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder:
                                  (BuildContext context) => BuildingPage(
                                  building: widget.appData.favSportBuildings[index - favStudyBuildingsLength]
                              )
                              )
                          );
                        },
                      );//BuildingCard(buildingData: widget.appData.favSportBuildings[index - favStudyBuildingsLength]);
                    }
                  }
                },
                itemCount: () {
                  int size = widget.appData.favStudyBuildings.length + widget.appData.favSportBuildings.length;
                  return size == 0 ? 1 : size;
                }.call(),
              )
            ],
          )
        )
    );
  }

}