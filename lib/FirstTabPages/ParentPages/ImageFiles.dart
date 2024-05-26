import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:ganpati_desktop/MainPages/Other/AppBarDrawer.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ganpati_desktop/Models/ImageModel.dart';
import 'package:ganpati_desktop/SecondTabPages/ChildPages/ImageOutput.dart';
import '../../Constants.dart';

// ignore: must_be_immutable
class ImageFiles extends StatefulWidget
{
  String url;
  List<String> titles;
  String imageType;
  ImageFiles(this.url, this.titles, this.imageType);
  @override
  State<StatefulWidget> createState() => _ImageFilesState();
}

class _ImageFilesState extends State<ImageFiles>
{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context)
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

  List<ImageModel> categories;
  Future<List<ImageModel>> getProductList(String page) async
  {
    Response response;
    response = await get(Uri.parse(page));
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200)
    {
      categories = (body as List).map((i) => ImageModel.fromJson(i)).toList();
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
    List<ImageModel> data = snapshot.data;
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index)
      {
        final value = data[index];
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ImageOutput(image: value.wallpaperImages,imageType: widget.imageType,))),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                width: _width,
                height: MediaQuery.of(context).size.width / 4 -50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CustomCacheImage(imageUrl: value.wallpaperImages,)//Image.network(value.wallpaperImages, fit: BoxFit.fill,)
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}