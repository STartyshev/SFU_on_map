import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'connection_between_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => SettingsPageState();

}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Настройки'),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 1),
            child: Divider(
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Доступ к местоположению'),
                  TextButton(
                      onPressed: () {
                        Geolocator.openAppSettings();
                      },
                      child: const Text('Изменить'))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Показывать уведомления'),
                  Switch(
                    value: Provider.of<AppData>(context, listen: false)
                        .userInfo.showNotifications,
                    onChanged: (bool newValue) =>
                        setState(() {
                          Provider.of<AppData>(context, listen: false)
                              .changeShowNotifications();
                        }),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }

}