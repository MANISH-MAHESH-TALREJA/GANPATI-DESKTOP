import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ganpati_desktop/VideoFiles.dart';
import 'package:keyboard_shortcuts/keyboard_shortcuts.dart';
import 'Constants.dart';
import 'FirstTabPages/ParentPages/ImageFiles.dart';
import 'FirstTabPages/ParentPages/NationalSongs.dart';
import 'MainPages/Other/AppBarDrawer.dart';
import 'SecondTabPages/ParentPages/RingtoneFiles.dart';

class SubCategory extends StatefulWidget 
{
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> 
{
  @override
  Widget build(BuildContext context) 
  {
    return WindowBorder(
      color: Constants.BlueColor,
      width: 2,
      child: Scaffold(
        appBar: RepublicDrawer().RepublicAppBar(context, Constants.OutputAppBarTitle),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                  KeyBoardShortcuts(
                    keysToPress: {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyG},
                    onKeysPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ImageFiles(Constants.WallpaperAPI, Constants.AppBarWallpaper,"WALLPAPERS"))),
                    helpLabel: "WALLPAPER PAGE",
                    child: LandScapeCard("assets/images/ganpati_09.gif",  "WALLPAPER", ImageFiles(Constants.WallpaperAPI, Constants.AppBarWallpaper,"WALLPAPERS"), false),
                  ),
                  KeyBoardShortcuts(
                    keysToPress: {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyI},
                    onKeysPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NationalSongs(Constants.NationalSongsAPI, Constants.AppBarSongs))),
                    helpLabel: "AARTI PAGE",
                    child: LandScapeCard("assets/images/ganpati_05.gif", "AARTI",NationalSongs(Constants.NationalSongsAPI, Constants.AppBarSongs), true),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                  KeyBoardShortcuts(
                    keysToPress: {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyK},
                    onKeysPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RingtoneFiles(Constants.RingtoneAPI, Constants.AppBarRingtone))),
                    helpLabel: "AARTI PAGE",
                    child: LandScapeCard("assets/images/ganpati_03.gif", "RINGTONE", RingtoneFiles(Constants.RingtoneAPI, Constants.AppBarRingtone), true),
                  ),
                  KeyBoardShortcuts(
                    keysToPress: {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyJ},
                    onKeysPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WindowsVideoFiles(Constants.VideoStatusAPI, Constants.AppBarStatus))),
                    helpLabel: "WALLPAPER PAGE",
                    child: LandScapeCard("assets/images/ganpati_10.gif", "STATUS",WindowsVideoFiles(Constants.VideoStatusAPI, Constants.AppBarStatus), false),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget LandScapeCard(String image, String title, Widget ReturnWidget, bool fill)
  {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder : (BuildContext context)=>ReturnWidget)),
      child: Container(
          padding: EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height/2-55,
          width: MediaQuery.of(context).size.width/2-25,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(colors: fill?[Constants.OrangeColor, Constants.OrangeColor]:[Constants.GreenColor, Constants.GreenColor])),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
            [
              Image.asset(
                image,
                height: MediaQuery.of(context).size.height*0.25,
                width: MediaQuery.of(context).size.height*0.25,
                fit: BoxFit.fill,
              ),
              Container(
                height: MediaQuery.of(context).size.height/2-45,
                width: MediaQuery.of(context).size.width/4-25,
                alignment: Alignment.center,
                child: Text(title,style: TextStyle(color: fill?Colors.white: Constants.BlueColor, letterSpacing:1,fontWeight: FontWeight.bold,fontSize: 20,),
                  maxLines: 4,),
              ),
            ],
          )
      ),
    );
  }
}

