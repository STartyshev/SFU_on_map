import 'package:flutter_projects/coordinates_class.dart';
import 'package:flutter_projects/models/todo_item.dart';

import 'models/user_info.dart';

UserInfo userInfo = const UserInfo(
    showNotifications: true,
    showNodeList: true
);

List<BuildingItem> studyData = [
  BuildingItem(
      id: 0,
      name: 'Корпус №12 (Б) - ИИФиРЭ',
      fullName: 'Институт инженерной физики и радиоэлектроники',
      address: 'ул. Академика Киренского, 28',
      link: 'https://efir.sfu-kras.ru/',
      moreInformation:
      'Учебно-организационный отдел:\n'
      'Место нахождения: ул. Академика Киренского, 28, ауд. Б-227\n'
      'График работы: понедельник – пятница с 8:30 до 17:00',
      phoneNumberText: 'Рабочий телефон: ',
      phoneNumber: '249 77 18',
      similarWords: ['корпус №12', 'корпус 12', '12 корпус', '12', 'корпус б',
        'б корпус', 'б', 'иифирэ', 'институт инженерной физики и радиоэлектроники'],
      notes: {},
      favorite: 0,
      blackList: 0,
      type: 'study',
      image: 'images/study/12.jpg',
      buildingCoordinates: const Coordinates(lat: 55.996686, long: 92.795402),
      routePoints: []
  ),
  BuildingItem(
      id: 1,
      name: 'Корпус №13 (В) - ПИ',
      fullName: 'Политехнический институт',
      address: 'ул. Борисова, 20',
      link: 'http://polytech.sfu-kras.ru/',
      moreInformation:
      'Учебно-организационный отдел:\n'
      'Место нахождения: ул. Академика Киренского, 26, ауд. Г33-12/1 (в новом корпусе)\n'
      'График работы: понедельник – пятница с 8:30 до 17:00',
      phoneNumberText: 'Рабочий телефон: ',
      phoneNumber: '291 20 75',
      similarWords: ['корпус №13', 'корпус 13', '13 корпус', '13', 'корпус в',
        'в корпус', 'в', 'пи', 'политехнический институт', 'старый пи', 'пи старый'],
      notes: {},
      favorite: 0,
      blackList: 0,
      type: 'study',
      image: 'images/study/13.png',
      buildingCoordinates: const Coordinates(lat: 55.994274, long: 92.793558),
      routePoints: []
  ),
  BuildingItem(
      id: 2,
      name: 'Корпус №14 (Г) - ПИ(новый)',
      fullName: 'Политехнический институт',
      address: 'ул. Академика Киренского, 26',
      link: 'http://polytech.sfu-kras.ru/',
      moreInformation:
      'Учебно-организационный отдел:\n'
      'Место нахождения: ул. Академика Киренского, 26, ауд. Г33-12/1\n'
      'График работы: понедельник – пятница с 8:30 до 17:00',
      phoneNumberText: 'Рабочий телефон: ',
      phoneNumber: '291 20 75',
      similarWords: ['корпус №14', 'корпус 14', '14 корпус', '14', 'корпус г',
        'г корпус', 'г', 'пи', 'политехнический институт', 'новый пи', 'пи новый'],
      notes: {},
      favorite: 0,
      blackList: 0,
      type: 'study',
      image: 'images/study/14.png',
      buildingCoordinates: const Coordinates(lat: 55.995807, long: 92.797456),
      routePoints: []
  ),
  BuildingItem(
      id: 3,
      name: 'Корпус №15 (Д) - ИУБП',
      fullName: 'Институт управления бизнес-процессами и экономики',
      address: 'ул. Академика Киренского, 26А',
      link: 'https://iubp.sfu-kras.ru/',
      moreInformation:
      'Учебно-организационный отдел:\n'
      'Место нахождения: ул. Академика Киренского, 26А, ауд. 4-34\n'
      'График работы: понедельник – пятница с 8:30 до 17:00',
      phoneNumberText: 'Рабочий телефон: ',
      phoneNumber: '291 27 80',
      similarWords: ['корпус №15', 'корпус 15', '15 корпус', '15', 'корпус д',
        'д корпус', 'д', 'иубп', 'институт управления бизнес-процессами и экономики'],
      notes: {},
      favorite: 0,
      blackList: 0,
      type: 'study',
      image: 'images/study/15.png',
      buildingCoordinates: const Coordinates(lat: 55.996894, long: 92.796554),
      routePoints: []
  ),
  BuildingItem(
      id: 4,
      name: 'Корпус №17 (Ж) - ИКИТ',
      fullName: 'Институт космических и информационных технологий',
      address: 'ул. Академика Киренского, 26к1',
      link: 'https://ikit.sfu-kras.ru/',
      moreInformation:
      'Учебно-организационный отдел:\n'
      'Место нахождения: ул. Академика Киренского, 26к1, ауд. УЛК 2-07\n'
      'График работы: понедельник – пятница с 8:30 до 17:00 (среда - неприемный день)',
      phoneNumberText: 'Рабочий телефон: ',
      phoneNumber: '291 22 37',
      similarWords: ['корпус №17', 'корпус 17', '17 корпус', '17', 'корпус ж',
        'ж корпус', 'ж', 'икит', 'институт космических и информационных технологий'],
      notes: {},
      favorite: 0,
      blackList: 0,
      type: 'study',
      image: 'images/study/17.png',
      buildingCoordinates: const Coordinates(lat: 55.994401, long: 92.796920),
      routePoints: []
  ),
  BuildingItem(
      id: 5,
      name: 'Корпус №80 - ИСиА, ФМШ, ИНО',
      fullName: 'ИСиА, ФМШ, ИНО',
      address: 'ФМШ: ул. Борисова, 5',
      link: 'https://fms.sfu-kras.ru/',
      moreInformation: '',
      phoneNumberText: 'Приемная: ',
      phoneNumber: '206 21 87',
      similarWords: ['корпус №80', 'корпус 80', '80 корпус', '80', 'исиа',
        'институт севера и арктики', 'фмш', 'физико-математическая школа',
        'физико-математическая школа-интернат', 'ино', 'институт непрерывного образования'],
      notes: {},
      favorite: 0,
      blackList: 0,
      type: 'study',
      image: 'images/study/80.png',
      buildingCoordinates: const Coordinates(lat: 55.995482, long: 92.796386),
      routePoints: []
  ),
];

List<BuildingItem> sportData = [
  BuildingItem(
      id: 0,
      name: 'Дом физкультуры',
      fullName: 'Дом физкультуры',
      similarWords: ['дом физкультуры', 'дом', 'физкультура'],
      notes: {},
      favorite: 0,
      blackList: 0,
      type: 'sport',
      image: 'images/sport/1.jpg',
      buildingCoordinates: const Coordinates(lat: 55.993625, long: 92.793499),
      routePoints: [],
      address: 'ул. Борисова, 20А',
      link: 'https://sport.sfu-kras.ru/node/823',
      moreInformation: 'График работы: понедельник - пятница с 8:30 до 17:00\nE-mail: sport_1@sfu-kras.ru',
      phoneNumberText: 'Рабочий телефон:',
      phoneNumber: '206 25 61'
  ),
  BuildingItem(
      id: 1,
      name: 'Спортивный комплекс',
      fullName: 'Спортивный комплекс, бассейн',
      similarWords: ['спортивный комплекс, бассейн', 'спортивный комплекс',
        'бассейн', 'комплекс', 'спортивный'],
      notes: {},
      favorite: 0,
      blackList: 0,
      type: 'sport',
      image: 'images/sport/2.PNG',
      buildingCoordinates: const Coordinates(lat: 55.997386, long: 92.791730),
      routePoints: [],
      address: 'ул. Академика Киренского, 15',
      link: 'https://structure.sfu-kras.ru/node/512',
      moreInformation: 'График работы: понедельник - пятница с 6:30 до 22:00\nсуббота, воскресенье - 9:00 до 20:00',
      phoneNumberText: 'Рабочий телефон:',
      phoneNumber: '249 70 31'
  ),
  BuildingItem(
      id: 2,
      name: 'Лыжная база',
      fullName: 'Лыжная база',
      similarWords: ['лыжная база', 'лыжная', 'база', 'лыжи'],
      notes: {},
      favorite: 0,
      blackList: 0,
      type: 'sport',
      image: 'images/sport/3.PNG',
      buildingCoordinates: const Coordinates(lat: 55.996928, long: 92.785802),
      routePoints: [],
      address: 'ул. Академика Киренского, 1А',
      link: 'https://sport.sfu-kras.ru/stadion/ski_base',
      moreInformation: 'Выдача спортивного инвентаря осуществляется с 10:00 до 15:00',
      phoneNumberText: 'Рабочий телефон:',
      phoneNumber: '249 73 62'
  ),
  BuildingItem(
      id: 3,
      name: 'Стадион "Перья-3"',
      fullName: 'Стадион "Перья-3"',
      similarWords: ['стадион "перья-3"', 'стадион перья-3', 'перья-3', 'перья3',
        'перья 3', 'перья', 'стадион перья', 'стадион перья3', 'стадион перья 3',
        'стадион', 'футбол', 'легкая атлетика'],
      notes: {},
      favorite: 0,
      blackList: 0,
      type: 'sport',
      image: 'images/sport/4.PNG',
      buildingCoordinates: const Coordinates(lat: 55.994231, long: 92.787166),
      routePoints: [],
      address: 'ул. Борисова, 6И',
      link: 'https://sport.sfu-kras.ru/stadion/stadium',
      moreInformation: 'График работы: понедельник - воскресенье с 7:00 до 22:00',
      phoneNumberText: 'Рабочий телефон:',
      phoneNumber: '206 22 22'
  ),
  BuildingItem(
      id: 4,
      name: 'Санаторий-профилакторий',
      fullName: 'Санаторий-профилакторий',
      similarWords: ['санаторий-профилакторий', 'санаторий', 'профилакторий',
        'санаторий профилакторий'],
      notes: {},
      favorite: 0,
      blackList: 0,
      type: 'sport',
      image: 'images/sport/5.PNG',
      buildingCoordinates: const Coordinates(lat: 55.997352, long: 92.790550),
      routePoints: [],
      address: 'ул. Академика Киренского, 11Б',
      link: 'https://eco.sfu-kras.ru/node/962',
      moreInformation: 'График работы: понедельник - пятница с 8:00 до 16:30',
      phoneNumberText: 'Рабочий телефон:',
      phoneNumber: '291 25 70'
  ),
];
