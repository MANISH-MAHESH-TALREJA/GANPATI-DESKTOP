import 'dart:async';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ganpati_desktop/Models/mantra_model.dart';
import '../../constants.dart';
import 'main_pages/other/app_bar_drawer.dart';

// ignore: must_be_immutable
class MantraList extends StatefulWidget
{
  String url;
  List<String> titles;
  MantraList(this.url, this.titles);
  @override
  State<StatefulWidget> createState() => _MantraListState();
}

class _MantraListState extends State<MantraList>
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

  List<MantraModel>? categories;
  Future<List<MantraModel>> getProductList(String page) async
  {
    Response response;
    response = await get(Uri.parse(page));
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200)
    {
      categories = (body as List).map((i) => MantraModel.fromJson(i)).toList();
      return categories!;
    }
    else
    {
      return categories = [];
    }
  }

  // ignore: non_constant_identifier_names
  Widget TirangaCard(int index, MantraModel value)
  {
    return Padding(
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
                        child: Text(value.mantraName!.toUpperCase(), maxLines: 2, //textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20,color: (index+1)%2==0?Constants.BlueColor:Colors.white, fontFamily: Constants.AppFont, fontWeight: FontWeight.bold)))),
                  ),
                ])
              ],
            ),
          )
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot)
  {
    List<MantraModel> data = snapshot.data;
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