import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ganpati_desktop/constants.dart';
import 'package:ganpati_desktop/general_utility_functions.dart';
import '../../main_pages/other/app_bar_drawer.dart';

// ignore: must_be_immutable
class ImageOutput extends StatefulWidget
{
  String image;
  String imageType;
  ImageOutput({required this.image, required this.imageType});
  @override
  _ImageOutputState createState() => _ImageOutputState();
}

class _ImageOutputState extends State<ImageOutput>
{
  @override
  Widget build(BuildContext context) 
  {
    return WindowBorder(
      color: Constants.BlueColor,
      width: 2,
      child: Scaffold(
        appBar: RepublicDrawer().RepublicAppBar(context,Constants.OutputAppBarTitle),
        body: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width-25,
              height: MediaQuery.of(context).size.height - 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FadeInImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.fill,
                  placeholder:
                  AssetImage('assets/images/ganpati_09.gif'),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          // marginEnd: 20,
          // marginBottom: 20,
          icon: Icons.file_download,
          activeIcon: Icons.close,
          animatedIconTheme: IconThemeData(size: 22.0),
          visible: true,
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.0,
          tooltip: 'DOWNLOAD IMAGE FILE',
          heroTag: 'SHARE OPTIONS - DIAL',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.image),
                backgroundColor: Colors.yellow,
                label: 'SAVE TO DOWNLOADS FOLDER',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: ()  => downloadWindowsFile(context, widget.imageType, widget.image, MimeType.png),
            ),
          ],
        ),
      ),
    );
  }
}
