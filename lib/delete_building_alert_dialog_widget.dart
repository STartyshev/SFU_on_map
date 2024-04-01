import 'package:flutter/material.dart';
import 'package:flutter_projects/building_data_class.dart';
import 'package:provider/provider.dart';
import 'package:flutter_projects/models/todo_item.dart';

import 'connection_between_widgets.dart';

class DeleteBuildingAlertDialog extends StatefulWidget {
  const DeleteBuildingAlertDialog({super.key, required this.buildingData});
  final BuildingItem buildingData;

  @override
  State<StatefulWidget> createState() => DeleteBuildingAlertDialogState();

}

class DeleteBuildingAlertDialogState extends State<DeleteBuildingAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить корпус из списка'),
      content:
      const Text('Вы действительно хотите удалить этот '
          'корпус из общего списка? Вернуть корпус'
          ' обратно в общий список можно в разделе: '
          'Дополнительно -> Скрытые.'),
      actions: [
        Column(
          children: [
            Row(children: [
              Checkbox(value: !Provider.of<AppData>(context, listen: false)
                    .userInfo.showNotifications,
                onChanged: (bool? change) => setState(() {
                  Provider.of<AppData>(context, listen: false)
                      .changeShowNotifications();
                }),
              ),
              GestureDetector(
                onTap: () {setState(() {
                  Provider.of<AppData>(context, listen: false)
                      .changeShowNotifications();
                });},
                child: const Text('Больше не спрашивать'),)
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              TextButton(
                  onPressed: () {
                    if (widget.buildingData.type == 'study') {
                      Provider.of<AppData>(context, listen: false)
                          .updateStudyBuildingsData(widget.buildingData, 0, 1);
                    } else {
                      Provider.of<AppData>(context, listen: false)
                          .updateSportBuildingsData(widget.buildingData, 0, 1);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Удалить')),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена')),
            ],)
          ],
        ),
      ],
    );
  }

}