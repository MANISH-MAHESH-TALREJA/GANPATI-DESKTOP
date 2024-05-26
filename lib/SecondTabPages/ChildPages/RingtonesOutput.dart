import 'dart:async';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:ganpati_desktop/GeneralUtilityFunctions.dart';
import '../../Constants.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/widgets.dart';

class AudioApp extends StatefulWidget
{
  final String url, name;
  AudioApp(this.url,this.name);
  @override
  _AudioAppState createState() => _AudioAppState();
}

class _AudioAppState extends State<AudioApp>
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
        medias: [
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
      child: Container(
        height: 135,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>
            [
              SizedBox(height: 5,),
              Text(widget.name, maxLines: 2, textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20,color: Constants.BlueColor, fontFamily: Constants.AppFont, fontWeight: FontWeight.bold)),
              Slider(
                min: 0,
                max: this.position.duration.inMilliseconds.toDouble(),
                value: this.position.position.inMilliseconds.toDouble(),
                onChanged: (double position) => this.player?.seek(Duration(milliseconds: position.toInt()))
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
                        style: TextStyle(fontSize: 14,color: Constants.BlueColor, fontFamily: Constants.AppFont
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
