import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:ganpati_desktop/MainPages/Other/AppBarDrawer.dart';
import 'package:ganpati_desktop/VideoStatusOutput.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ganpati_desktop/Models/VideoStatusModel.dart';

import 'Constants.dart';

// ignore: must_be_immutable
class WindowsVideoFiles extends StatefulWidget
{
  String url;
  List<String> titles;

  WindowsVideoFiles(this.url, this.titles);
  @override
  State<StatefulWidget> createState() => _WindowsVideoFilesState();
}

class _WindowsVideoFilesState extends State<WindowsVideoFiles>
{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context)
  {
    return OrientationBuilder(
        builder: (context, orientation)
        {
          return WindowBorder(
            color: Constants.BlueColor,
            width: 2,
            child: Scaffold(
                key: _scaffoldKey,
                appBar: RepublicDrawer().RepublicAppBar(context,widget.titles),
                body: FutureBuilder(
                  future: getProductList(widget.url),
                  builder: (context, AsyncSnapshot snapshot)
                  {
                    switch (snapshot.connectionState)
                    {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return new RepublicDrawer().TirangaProgressBar(context);
                      default:
                        if (snapshot.hasError)
                          return Center(child: Image.asset("assets/images/navratri_07.gif"));
                        else
                          return createListView(context, snapshot);
                    }
                  },
                )
            ),
          );
        }
    );
  }

  List<VideoStatusModel> categories;
  Future<List<VideoStatusModel>> getProductList(String page) async
  {
    Response response;
    response = await get(Uri.parse(page));
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200)
    {
      categories = (body as List).map((i) => VideoStatusModel.fromJson(i)).toList();
      return categories;
    }
    else
    {
      return categories = [];
    }
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot)
  {
    var _width = MediaQuery.of(context).size.width / 2;
    List<VideoStatusModel> data = snapshot.data;
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      itemBuilder: (context, index)
      {
        final value = data[index];
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VideoStatusOutput(value.videoUrl, value.videoName))),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: <Widget>
                [
                  Positioned.fill(
                    child: Container(
                      width: _width,
                      height: MediaQuery.of(context).size.width / 2 -50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CustomCacheImage(imageUrl: value.videoThumbnail,)//Image.network(value.wallpaperImages, fit: BoxFit.fill,)
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.play_circle_outline, size: 100, color: Constants.GreenColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}