import 'package:flutter/material.dart';
import 'package:flutter_projects/popup_menu_button_widget.dart';
import 'package:flutter_projects/search_text_field_widget.dart';

import 'building_card_widget.dart';
import 'building_page_widget.dart';
import 'connection_between_widgets.dart';

class StudyBuildings extends StatefulWidget {
  const StudyBuildings({super.key, required this.appData, required this.title});

  final AppData appData;
  final String title;

  @override
  State<StatefulWidget> createState() => StudyBuildingsState();

}

class StudyBuildingsState extends State<StudyBuildings> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Image.asset('images/study/app_bar.jpg'),
                Padding(
                  padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 38,
                            fontWeight: FontWeight.bold),
                      ),
                      const PopupMenuButtonMoreActions(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          toolbarHeight: 146,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(108),
            child: SearchTextField(),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              for (int i = 0; i < widget.appData.studyBuildings.length; i++)
                widget.appData.studyBuildings[i].blackList == 1 ?
                const SizedBox(height: 0,) :
                GestureDetector(
                  child: BuildingCard(
                      buildingData: widget.appData.studyBuildings.firstWhere(
                              (element) => element.id == i)
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder:
                            (BuildContext context) => BuildingPage(
                            building: widget.appData.studyBuildings.firstWhere(
                                    (element) => element.id == i)
                        )
                        )
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

}