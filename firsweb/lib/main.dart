import 'package:firebase_core/firebase_core.dart';
import 'package:firsweb/controllers/menu_controller.dart';
import 'package:firsweb/controllers/navigation_controller.dart';
import 'package:firsweb/pages/authentication/authentication.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB5I8DxaQ4sAzo8cvcMvfpsAgjgSLEh9Hc",
            appId: "1:974010781505:web:1d9dee4c49db4a84bf5bc0",
            messagingSenderId: "974010781505",
            projectId: "imamu-digital-bank"));
  }
  runApp(MyApp());
  Get.put(MyMenuController());
  Get.put(NavigationController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "IDB",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.black,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primaryColor: Colors.blue,
      ),
      home: AuthenticationPage(),
    );
  }
}
