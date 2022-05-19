import'package:myprogram4/login/SplashScreen.dart';
import'package:firebase_core/firebase_core.dart';
import'package:flutter/material.dart';
import'firebase_options.dart';

Future<void>main() async {
  WidgetsFlutterBinding.ensureInitialized();
  awaitFirebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(constMyApp());
}
classMyAppextendsStatelessWidget {
constMyApp({Key? key}) : super(key: key);
@override
Widgetbuild(BuildContextcontext) {
  returnMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: constSplashScreen(),
  );
}
}
