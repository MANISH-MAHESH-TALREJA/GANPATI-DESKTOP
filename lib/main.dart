import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ganpati_desktop/Constants.dart';
import 'SplashScreen.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: Constants.AppName,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepOrange, fontFamily: Constants.AppFont, appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark
    )),
    home: SplashScreen(),
  ));
  doWhenWindowReady(() {
    final win = appWindow;
    final initialSize = Size(885, 500);
    final secondSize = Size(885, 500);
    win.maxSize = secondSize;
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "GANPATI BAPPA";
    win.show();
  });

}

