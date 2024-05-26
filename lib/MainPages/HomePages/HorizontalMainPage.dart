import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ganpati_desktop/Constants.dart';
import 'package:ganpati_desktop/FirstTabPages/ParentPages/ImageFiles.dart';
import 'package:ganpati_desktop/FirstTabPages/ParentPages/NationalSymbols.dart';
import 'package:ganpati_desktop/MainPages/Other/AppBarDrawer.dart';
import 'package:ganpati_desktop/MainPages/PortraitPages/ThirdPage.dart';
import 'package:ganpati_desktop/SubCategory.dart';

import 'package:shimmer/shimmer.dart';
import '../../GaneshPuja.dart';
import '../../MantraList.dart';
import '../../keyboard_shortcuts.dart';

class HorizontalMainPage extends StatefulWidget
{
  @override
  _HorizontalMainPageState createState() => _HorizontalMainPageState();
}

class _HorizontalMainPageState extends State<HorizontalMainPage>
{
  @override
  Widget build(BuildContext context)
  {
    return WindowBorder(
      color: Constants.BlueColor,
      width: 2,
      child: Scaffold(
        appBar: RepublicDrawer().RepublicAppBar(context, Constants.OutputAppBarTitle),
        drawer: RepublicDrawer(),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavratriPuja(Constants.NationalSymbolsAPI, Constants.AppBarShayari))),
                    child: Container(
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height/2-55,
                        width: MediaQuery.of(context).size.width/2-25,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(colors: [Constants.GreenColor, Constants.GreenColor])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:
                          [
                            Image.asset(
                              'assets/images/ganpati_11.gif',
                              height: MediaQuery.of(context).size.height / 2 - 80,
                              width: MediaQuery.of(context).size.width / 4 - 25,
                              //fit: BoxFit.fill,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height/2-45,
                              width: MediaQuery.of(context).size.width/4-25,
                              alignment: Alignment.center,
                              child: Text(
                                'SHREE GANESH PUJA',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Constants.BlueColor,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                maxLines: 4,
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => NationalSymbols(Constants.UnknownFactsAPI, Constants.AppBarIndia))),
                    child: Container(
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height/2-55,
                        width: MediaQuery.of(context).size.width/2-25,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(colors: [Constants.OrangeColor, Constants.OrangeColor])),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:
                          [
                            Image.asset(
                              'assets/images/ganpati_06.gif',
                              height: MediaQuery.of(context).size.height / 2 - 80,
                              width: MediaQuery.of(context).size.width / 4 - 25,
                              //fit: BoxFit.fill,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height/2-45,
                              width: MediaQuery.of(context).size.width/4-25,
                              alignment: Alignment.center,
                              child: Text(
                                'SHREE GANPATI BAPPA',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                maxLines: 4,
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>
                  [
                    KeyBoardShortcuts(
                      keysToPress: {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyB},
                      onKeysPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MantraList(Constants.ShayariAPI, Constants.AppBar108Names))),
                      helpLabel: "108 NAMES",
                      child: FirstHorizontalCard(context, "assets/images/ganpati_05.gif", "108 NAMES",MantraList(Constants.ShayariAPI, Constants.AppBar108Names),"CTRL + B"),
                    ),
                    KeyBoardShortcuts(
                      keysToPress: {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyE},
                      onKeysPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ImageFiles(Constants.NameLettersAPI, Constants.AppBarNameLetters,"NAME LETTERS")),),
                      helpLabel: "LETTERS",
                      child: FirstHorizontalCard(context, "assets/images/ganpati_03.gif", "LETTERS", ImageFiles(Constants.NameLettersAPI, Constants.AppBarNameLetters,"NAME LETTERS"), "CTRL + E"),
                    ),
                  ]
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                  KeyBoardShortcuts(
                    keysToPress: {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyC},
                    onKeysPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPage())),
                    helpLabel: "GALLERY PAGE",
                    child: FirstHorizontalCard(context, "assets/images/ganpati_09.gif", "GALLERY",ThirdPage(),"CTRL + C"),
                  ),
                  KeyBoardShortcuts(
                    keysToPress: {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyF},
                    onKeysPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategory()),),
                    helpLabel: "SUB CATEGORY PAGE",
                    child: FirstHorizontalCard(context, "assets/images/ganpati_10.gif", "MEDIA", SubCategory(), "CTRL + F"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget FirstHorizontalCard(BuildContext context, String image, String title, Widget nextPage, String shortcut)
  {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 2,
        child: Container(
          height: MediaQuery.of(context).size.height / 2 - 65,
          width: MediaQuery.of(context).size.width / 4 - 25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>
            [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height:
                  MediaQuery.of(context).size.height / 2 - 110,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Shimmer.fromColors(
                  highlightColor: Constants.GreenColor,
                  baseColor: Constants.OrangeColor,
                  child: Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}