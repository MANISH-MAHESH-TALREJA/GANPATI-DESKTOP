import 'dart:async';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktoasts/desktoasts.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'main_pages/home_pages/horizontal_main_page.dart';

class SplashScreen extends StatefulWidget
{
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin
{
  var _visible = true;
  AnimationController? animationController;
  Animation<double>? animation;
  startTime() async
  {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage()
  {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HorizontalMainPage()));
  }

  @override
  void initState()
  {
    super.initState();
    ToastService service = new ToastService(
      appName: 'GANPATI BAPPA',
      companyName: 'MANISH ENTERPRISES',
      productName: 'MESSAGES',
    );
    Toast toast = new Toast(
        type: ToastType.imageAndText02,
        title: 'GANPATI BAPPA MORYA',
        subtitle: 'PRESS CTRL + H FOR SHORTCUTS MENU',
    );

    service.show(toast);
    animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();

    setState(()
    {
      _visible = !_visible;
    });
    startTime();

  }

  @override
  Widget build(BuildContext context)
  {
    return WindowBorder(
      color: Constants.BlueColor,
      width: 2,
      child: Scaffold(
        backgroundColor: Constants.OrangeColor,
        body: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>
            [
              new Image.asset(
                'assets/images/image.gif',
                width: animation!.value * 250,
                height: animation!.value * 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
