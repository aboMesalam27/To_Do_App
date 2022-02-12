import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/theme.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'ui/pages/home_page.dart';

void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  NotifyHelper().initializeNotification();
  await DBHelper.initDb();
  GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: ThemeServices().theme,
        title: 'To Do',
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          animationDuration: const Duration(milliseconds: 1500),
          backgroundColor: Get.isDarkMode?colorBlack:colorWhite,
          splashTransition: SplashTransition.slideTransition,
         // pageTransitionType: PageTransitionType.scale,
          splashIconSize: 300,
          splash:Stack(
            alignment: Alignment.bottomRight,
            children:[
              SvgPicture.network(
                'http://cdn.onlinewebfonts.com/svg/img_546505.svg',
              color: Get.isDarkMode?primaryClr.withOpacity(0.7):primaryClr.withOpacity(0.7),
            ),]
          ),
          duration: 1700,
          nextScreen: HomePage(),
        ));
  }
}
