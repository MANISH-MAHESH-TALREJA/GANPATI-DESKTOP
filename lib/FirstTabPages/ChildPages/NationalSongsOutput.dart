import 'dart:async';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ganpati_desktop/GeneralUtilityFunctions.dart';
import 'package:ganpati_desktop/MainPages/Other/AppBarDrawer.dart';
import '../../Constants.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:file_saver/file_saver.dart';

class NationalSongsOutput extends StatefulWidget
{
  final String english, hindi, name, url;
  NationalSongsOutput(this.name, this.url, this.english, this.hindi);
  @override
  _NationalSongsOutputState createState() => _NationalSongsOutputState();
}

class _NationalSongsOutputState extends State<NationalSongsOutput>
{
  @override
  void initState()
  {
    super.initState();
    initDesktopAudioPlayer();
    if (this.mounted)
    {
      this.player?.currentStream?.listen((current)
      {
        this.setState(() => this.current = current);
      });
      this.player?.positionStream?.listen((position)
      {
        this.setState(() => this.position = position);
      });
      this.player?.playbackStream?.listen((playback)
      {
        this.setState(() => this.playback = playback);
      });
      this.player?.generateStream?.listen((general)
      {
        this.setState(() => this.general = general);
      });
    }
  }
  Player player;
  Media media;
  Playlist playList;
  CurrentState current = new CurrentState();
  PositionState position = new PositionState();
  PlaybackState playback = new PlaybackState();
  GeneralState general = new GeneralState();

  @override
  void dispose()
  {
    player.stop();
    player.dispose();
    super.dispose();
  }

  Future<void> initDesktopAudioPlayer() async
  {
    player = new Player(id: 69420);
    player.open(
      new Playlist(
        medias:
        [
          await Media.network(widget.url),
        ],
      ),
      autoStart: false, // default
    );
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
          appBar: RepublicDrawer().RepublicAppBar(context,Constants.OutputAppBarTitle),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal:5.0),
            child: Container(
              decoration: BoxDecoration(
                color: Constants.OrangeColor,
                  border: Border.all(
                    color: Constants.BlueColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL,
                front: Padding(
                  padding: const EdgeInsets.symmetric(vertical : 5.0),
                  child: Center(child: SingleChildScrollView(child: Html(
                      defaultTextStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      data: '''  ${"<center>"+widget.hindi+"</center>"}   '''),
                  )),
                ),
                back: Container(
                  decoration: BoxDecoration(
                      color: Constants.GreenColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical : 5.0),
                    child: Center(child: SingleChildScrollView(child: Html(
                        defaultTextStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Constants.BlueColor),
                        data: '''  ${"<center>"+widget.english+"</center>"}   '''),
                      controller: ScrollController(),
                    )),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Constants.BlueColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                height: 135,
                width: MediaQuery.of(context).size.width-10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>
                  [
                    SizedBox(height:5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>
                      [
                        Icon(Icons.swipe, color: Constants.BlueColor,),
                        SizedBox(width: 5,),
                        Text("CLICK ON THE CARD TO CHANGE LANGUAGE", maxLines: 2, textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14,color: Constants.BlueColor, fontFamily: Constants.AppFont)),
                      ],
                    ),
                    Slider(
                      min: 0,
                      max: this.position.duration.inMilliseconds.toDouble(),
                      value: this.position.position.inMilliseconds.toDouble(),
                      onChanged: (double position) => this.player?.seek(Duration(milliseconds: position.toInt())),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                      [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.00),
                          child: Text(this.position.position.toString().split(".")[0].split(":")[1] + " : "+this.position.position.toString().split(".")[0].split(":")[2], maxLines: 2, textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14,color: Constants.BlueColor, fontFamily: Constants.AppFont)),
                        ),
                        IconButton(
                          onPressed: () => player.play(),
                          icon: Icon(Icons.play_circle_outline),
                          iconSize: 40,
                          color: Colors.blue,
                        ),
                        IconButton(
                          onPressed: () => player.pause(),
                          iconSize: 40.0,
                          icon: Icon(Icons.pause_circle_outline_outlined),
                          color: Colors.teal,
                        ),
                        IconButton(
                          onPressed: () => player.stop(),
                          icon: Icon(Icons.stop_circle_outlined),
                          iconSize: 40,
                          color: Colors.red,
                        ),
                        IconButton(
                          onPressed: ()  => downloadWindowsFile(context, widget.name, widget.url, MimeType.MP3),
                          iconSize: 40,
                          icon: Icon(Icons.arrow_circle_down_outlined),
                          color: Colors.purple,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.00),
                          child: Text(this.position.duration.toString().split(".")[0].split(":")[1] + " : "+this.position.duration.toString().split(".")[0].split(":")[2], maxLines: 2, textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14,color: Constants.BlueColor, fontFamily: Constants.AppFont)),
                        ),
                      ],
                    ),
                  ],
                )
            ),
          )
      ),
    );
  }
}