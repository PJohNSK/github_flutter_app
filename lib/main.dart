import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github/services/appconfig_service.dart';
import 'package:github/services/multi_lingual_service.dart';
import 'package:github/helper/locator.dart';
import 'package:github/helper/router.dart';
import 'package:github/res/images.dart';
import 'package:github/services/preference_service.dart';
import 'package:github/res/styles.dart';
import 'package:github/utils/utils.dart';
import 'package:github/core/widgets/splash_screen.dart';
import 'package:provider/provider.dart';
import 'helper/navigation_helper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runZoned<Future<void>>(() async {
    runApp(MyApp());
  },
      onError:(Object obj, StackTrace stack) {

      });
}

class MyApp extends StatelessWidget {


  MyApp();

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        Provider<AppConfig>(create: (context) => locator<AppConfigService>().config),
        ChangeNotifierProvider<MultiLingualData>(create: (context) => locator<MultiLingualService>().data),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Git Hub',
        theme: AppStyle.clientTheme,
        navigatorKey: locator<NavigationHelper>().navigatorKey,
        home: MyHomePage(),
        onGenerateRoute: (settings) => Router.generateRoute(settings),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isLogin = false;
  PreferenceService pref;

  @override
  void initState() {
    getVerification();
    super.initState();
  }

  getVerification() async {
    pref = await PreferenceService.init();
    setState(() {
      isLogin = pref.isLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(seconds: 2,
      image: new Image.asset(Images.app_logo, semanticLabel: "Git Hub", repeat: ImageRepeat.noRepeat,),
      backgroundColor: Theme.of(context).primaryColor,
      photoSize: 100.0,
      navigateAfterSeconds: isLogin ? Routes.dashboard : Routes.login,
      title: Text(""),
    );
  }
}
