import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/application_information_page_widget.dart';
import 'package:flutter_projects/favorites_page_widget.dart';
import 'package:flutter_projects/hidden_buildings_page_widget.dart';
import 'package:flutter_projects/settings_page_widget.dart';
import 'package:flutter_projects/sport_buildings_page_widget.dart';
import 'package:flutter_projects/study_buildings_page_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_projects/services/db.dart';
import 'connection_between_widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DB.init();

  runApp(ChangeNotifierProvider(
    create: (context) => AppData(),
    child: const SFUOnMap(),
  ));
}

class SFUOnMap extends StatelessWidget {
  const SFUOnMap({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = const Color.fromARGB(255, 229, 62, 17);
    return MaterialApp(
      title: 'CФУ на карте',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: primaryColor,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      locale: const Locale('ru', 'RU'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  PageController pageController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    Provider.of<AppData>(context, listen: false).refreshStudyBuildingsData();
    Provider.of<AppData>(context, listen: false).refreshSportBuildingsData();
    Provider.of<AppData>(context, listen: false).refreshUserInfo();
    return Consumer<AppData>(builder: (context, appData, child) {
      return Scaffold(
        body: [
          FavoritesPage(appData: appData),
          StudyBuildings(appData: appData, title: widget.title),
          SportBuildingsPage(appData: appData, title: widget.title),
          const SettingsPage(),
          HiddenBuildingsPage(appData: appData,),
          const AppInformationPage()
        ][appData.currentPage],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            appData.changeNavigationBarCurrentPage(newPageIndex: index);
            appData.changeCurrentPage(newPageIndex: index);
          },
          indicatorColor: Colors.white,
          selectedIndex: appData.navigationBarCurrentPage,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.favorite),
              label: 'Избранное',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book),
              label: 'Корпуса',
            ),
            NavigationDestination(
              icon: Icon(Icons.sports_soccer),
              label: 'Спорт',
              //selectedIcon: ,
            ),
          ],
        ),
      );
    });
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (_) => const MainPage(title: 'CФУ на карте')
          )
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 255, 200, 200), Color.fromARGB(255, 229, 62, 17)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: SvgPicture.asset('images/splash_screen/splash_screen.svg'),
      ),
    );
  }
}
