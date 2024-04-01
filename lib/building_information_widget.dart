import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/models/todo_item.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildingInformation extends StatelessWidget {
  const BuildingInformation({super.key, required this.building});

  final BuildingItem building;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Контактная информация',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text('Адрес: ${building.address}'),
            RichText(
                text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Сайт: ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                          text: building.link,
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline)
                          ,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                launchUrl(Uri.parse(building.link))
                      )
                    ]
                )
            ),
            building.moreInformation.isNotEmpty ?
            Text(building.moreInformation) :
            const SizedBox(height: 0,),
            RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${building.phoneNumberText} ',
                        style: const TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                          text: building.phoneNumber,
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline)
                          ,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                launchUrl(Uri.parse('tel://${building.phoneNumber}'))
                      )
                    ]
                )
            ),
            const SizedBox(height: 16,)
          ],
        ),
    );
  }

}