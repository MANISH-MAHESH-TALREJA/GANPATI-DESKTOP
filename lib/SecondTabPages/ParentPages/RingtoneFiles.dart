import 'dart:async';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ganpati_desktop/MainPages/Other/AppBarDrawer.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ganpati_desktop/Models/RingtonesModel.dart';
import 'package:ganpati_desktop/SecondTabPages/ChildPages/RingtonesOutput.dart';
import '../../Constants.dart';

// ignore: must_be_immutable
class RingtoneFiles extends StatefulWidget
{
  String url;
  List<String> titles;
  RingtoneFiles(this.url, this.titles);
  @override
  State<StatefulWidget> createState() => _RingtoneFilesState();
}

class _RingtoneFilesState extends State<RingtoneFiles>
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
                    return Center(child: Image.asset("assets/images/ganpati_09.gif"));
                  else
                    return createListView(context, snapshot);
              }
            },
          )
      ),
    );
  }

  List<RingtonesModel> categories;
  Future<List<RingtonesModel>> getProductList(String page) async
  {
    Response response;
    response = await get(Uri.parse(page));
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200)
    {
      categories = (body as List).map((i) => RingtonesModel.fromJson(i)).toList();
      return categories;
    }
    else
    {
      return categories = [];
    }
  }

  // ignore: non_constant_identifier_names
  Widget TirangaCard(int index, RingtonesModel value)
  {
    return GestureDetector(
      onTap: () => showMaterialModalBottomSheet(context: context, builder: (context) => AudioApp(value.audioLink, value.audioName)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
            elevation: 2,
            color: (index+1)%2==0 ? Constants.GreenColor : Color(0xFFFF33C9),
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width-20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:
                [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children:
                  [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/images/app_icon.png", height:75, width:75),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(width: MediaQuery.of(context).size.width*0.8,child: Marquee(
                          textDirection : TextDirection.ltr,
                          animationDuration: Duration(seconds: 3),
                          directionMarguee: DirectionMarguee.oneDirection,
                          child: Text(value.audioName.toUpperCase(), maxLines: 2, //textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20,color: (index+1)%2==0?Constants.BlueColor:Colors.white, fontFamily: Constants.AppFont, fontWeight: FontWeight.bold)))),
                    ),
                  ])
                ],
              ),
            )
        ),
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot)
  {
    List<RingtonesModel> data = snapshot.data;
    return ListView.builder(
      key: UniqueKey(),
      itemCount: data.length,
      itemBuilder: (context, index)
      {
        final value = data[index];
        return TirangaCard(index, value);
      },
    );
  }
}