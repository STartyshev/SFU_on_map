import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'connection_between_widgets.dart';

class AppInformationPage extends StatelessWidget {
  const AppInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('О приложении'),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 1),
            child: Divider(
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 350,
                width: 350,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 26, 225, 0),
                    Color.fromARGB(255, 229, 60, 18)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: SizedBox(
                  height: 275,
                  width: 275,
                  child: SvgPicture.asset('images/splash_screen/splash_screen.svg'),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Text('Версия: 1.0\n'),
              RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Контактная информация: ',
                          style: TextStyle(color: Colors.black)
                      ),
                      TextSpan(
                          text: 'Тартышев Семён',
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                launchUrl(Uri.parse('https://vk.com/s.tartyshev'))
                      )
                    ]
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: RichText(
                    text: TextSpan(
                        text: 'Условия использования сервиса Яндекс.Карты',
                        style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              launchUrl(Uri.parse('https://yandex.ru/legal/maps_termsofuse'))
                    )
                ),
              )
            ],
          ),
        ),
    );
  }
}
