import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ganpati_desktop/constants.dart';
import 'package:file_saver/file_saver.dart';
import 'general_utility_functions.dart';
import 'main_pages/other/app_bar_drawer.dart';

class VideoStatusOutput extends StatefulWidget
{
  final String url, name;
  VideoStatusOutput(this.url, this.name);

  @override
  _VideoStatusOutputState createState() => _VideoStatusOutputState();
}

class _VideoStatusOutputState extends State<VideoStatusOutput>
{
  Player? player;
  Media? media;
  Playlist? playList;
  Future<void> initDesktopAudioPlayer() async
  {
    player = new Player(id: 69420, videoDimensions: VideoDimensions(620,360));
    player!.open(
      new Playlist(
        medias:
        [
          await Media.network(widget.url),
        ],
      ),
      autoStart: true, // default
    );
  }

  @override
  void dispose()
  {
    player!.stop();
    player!.dispose();
    super.dispose();
  }

  @override
  void initState()
  {
    super.initState();
    initDesktopAudioPlayer();
  }

  @override
  Future<void> didChangeDependencies() async
  {
    super.didChangeDependencies();
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context)
  {
    return WindowBorder(
      color: Constants.BlueColor,
      width: 2,
      child: Scaffold(
        appBar: RepublicDrawer().RepublicAppBar(context, Constants.OutputAppBarTitle),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
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
          tooltip: 'DOWNLOAD VIDEO FILE',
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
              onTap: ()  => downloadWindowsFile(context, widget.name, widget.url, MimeType.mpeg),
            ),
          ],
        ),
        body: Center(
          child: Video(
            // playerId: 69420,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.9,
            showControls: true, // default
          ),
        ),
      ),
    );
  }
}
