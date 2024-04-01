import 'package:flutter/material.dart';

import 'connection_between_widgets.dart';

class HiddenBuildingsPage extends StatefulWidget {
  const HiddenBuildingsPage({super.key, required this.appData});

  final AppData appData;

  @override
  State<StatefulWidget> createState() => HiddenBuildingsPageState();

}

class HiddenBuildingsPageState extends State<HiddenBuildingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Скрытые здания'),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 1),
            child: Divider(
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
          child: CustomScrollView(
            slivers: [
              SliverList.builder(
                itemBuilder: (BuildContext context, int index) {
                  bool blackListStudyBuildingsIsNotEmpty =
                      widget.appData.blackListStudyBuildings.isNotEmpty;
                  bool blackListSportBuildingsIsNotEmpty =
                      widget.appData.blackListSportBuildings.isNotEmpty;
                  int blackListStudyBuildingsLength =
                      widget.appData.blackListStudyBuildings.length;
                  int blackListSportBuildingsLength =
                      widget.appData.blackListSportBuildings.length;
                  if (blackListStudyBuildingsIsNotEmpty ||
                      blackListSportBuildingsIsNotEmpty) {
                    if (blackListStudyBuildingsIsNotEmpty &&
                        index < blackListStudyBuildingsLength) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.appData.blackListStudyBuildings[index].name),
                              TextButton(
                                  onPressed: () {
                                    widget.appData.updateStudyBuildingsData(
                                        widget.appData.blackListStudyBuildings[index],
                                        0,
                                        0
                                    );
                                  },
                                  child: const Text('Вернуть')
                              )
                            ],
                          ),
                          () {
                          if (index + 1 == blackListStudyBuildingsLength) {
                            if (blackListSportBuildingsLength != 0) {
                              return Divider(
                                height: 1,
                                color: Theme.of(context).primaryColor.withOpacity(0.2),
                              );
                            } else {
                              return const SizedBox(height: 0,);
                            }
                          } else {
                            return Divider(
                              height: 1,
                              color: Theme.of(context).primaryColor.withOpacity(0.2),
                            );
                          }
                        }.call()
                        ],
                      );
                    }
                    if (blackListSportBuildingsIsNotEmpty &&
                        index >= blackListStudyBuildingsLength) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.appData.blackListSportBuildings[
                              index - blackListStudyBuildingsLength
                              ].name),
                              TextButton(
                                  onPressed: () {
                                    widget.appData.updateSportBuildingsData(
                                        widget.appData.blackListSportBuildings[
                                        index - blackListStudyBuildingsLength],
                                        0,
                                        0
                                    );
                                  },
                                  child: const Text('Вернуть'))
                            ],
                          ),
                          index - blackListStudyBuildingsLength + 1 != blackListSportBuildingsLength ?
                          Divider(
                            height: 1,
                            color: Theme.of(context).primaryColor.withOpacity(0.2),
                          ) : const SizedBox(height: 0,)
                        ],
                      );
                    }
                  } else {
                    return const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Список скрытых зданий пуст.')
                    );
                  }
                },
                itemCount: () {
                  int size = widget.appData.blackListStudyBuildings.length +
                      widget.appData.blackListSportBuildings.length;
                  return size == 0 ? 1 : size;
                }.call(),
              )
            ],
          ),
        )
    );
  }

}