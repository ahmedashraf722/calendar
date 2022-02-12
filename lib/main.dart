import 'package:calendar/firebase_options.dart';
import 'package:calendar/shared/network/local/cache_helper.dart';
import 'package:calendar/splash_screen/splash_screen.dart';
import 'package:calendar/services/theme_services.dart';
import 'package:calendar/ui/pages/home_page.dart';
import 'package:calendar/ui/pages/login_screen.dart';
import 'package:calendar/ui/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'db/db_helper_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Widget widget;
  var uid = CacheHelper.getData(key: 'uID');
  if (uid != null) {
    widget = const HomePage();
  } else {
    widget = const AppLoginScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uid = CacheHelper.getData(key: 'uID');
    return BlocProvider(
      create: (context) => DBHelperCubit()..createDatabase(),
      child: GetMaterialApp(
        title: 'Calendar',
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: ThemeServices().theme,
        home: uid == null ? const SplashScreen() : startWidget,
      ),
    );
  }
}
