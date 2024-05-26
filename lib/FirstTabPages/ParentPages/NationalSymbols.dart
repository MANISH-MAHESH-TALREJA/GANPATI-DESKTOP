import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ganpati_desktop/MainPages/Other/AppBarDrawer.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ganpati_desktop/Models/NationalDetailModel.dart';
import '../../Constants.dart';
import '../../GeneralUtilityFunctions.dart';

// ignore: must_be_immutable
class NationalSymbols extends StatefulWidget
{
  String url;
  List<String> titles;
  NationalSymbols(this.url, this.titles);
  @override
  State<StatefulWidget> createState() => _NationalSymbolsState();
}

class _NationalSymbolsState extends State<NationalSymbols>
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
            future: getData(widget.url),
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


  List<NationalDetailModel>? categories;
  Future<List<NationalDetailModel>> getData(String page) async
  {
    Response response;
    response = await get(Uri.parse(page));
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200)
    {
      categories = (body as List).map((i) => NationalDetailModel.fromJson(i)).toList();
      return categories!;
    }
    else
    {
      return categories = [];
    }
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot)
  {
    List<NationalDetailModel> data = snapshot.data;
    return  ExpandableTheme(
      data: const ExpandableThemeData(
        iconColor: Constants.BlueColor,
        useInkWell: true,
      ),
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index)
          {
            final value = data[index];
            return ContactWidget(value.image!, value.name!, value.detail!, value.link!);
          }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,
      ),),
    );
  }
}

// ignore: must_be_immutable
class ContactWidget extends StatelessWidget
{
  String? image, title, description, link;

  ContactWidget(String image, String title, String description, String link)
  {
    this.image = image;
    this.title = title;
    this.description = description;
    this.link = link;
  }

  @override
  Widget build(BuildContext context)
  {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            elevation: 2,
            shadowColor: Constants.BlueColor,
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: ScrollController(),
              child: Column(
                children: <Widget>
                [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height*0.6,
                      width: MediaQuery.of(context).size.width*0.6,
                      child: ClipRRect(borderRadius: BorderRadius.circular(8.0),child: CustomCacheImage(imageUrl: image!,)
                      )
                    ),
                  ),
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            title!,
                            style: TextStyle(fontSize: 20,color: Constants.OrangeColor, fontFamily: Constants.AppFont, fontWeight: FontWeight.bold),
                          )
                      ),
                      collapsed: Text(
                        description!,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(fontSize: 15,color: Constants.BlueColor, fontFamily: Constants.AppFont),
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                description!,
                                softWrap: true,
                                style: TextStyle(fontSize: 15,color: Constants.BlueColor, fontFamily: Constants.AppFont),
                                overflow: TextOverflow.fade,
                              )
                          ),
                          Center(
                            child: ElevatedButton(
                                child: Container(
                                  width: 160,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.info_outline, color: Colors.white,),
                                        SizedBox(width: 10,),
                                        Text(
                                            "READ MORE".toUpperCase(),
                                            style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)
                                        ),
                                      ]
                                  ),
                                ),
                                style: ButtonStyle(
                                    foregroundColor: WidgetStateProperty.all<Color>(Constants.OrangeColor),
                                    backgroundColor: WidgetStateProperty.all<Color>(Constants.OrangeColor),
                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.00),
                                            side: BorderSide(color: Constants.GreenColor)
                                        )
                                    )
                                ),
                                onPressed: () => launchLink(link!)
                            ),
                          ),
                        ],
                      ),
                      builder: (_, collapsed, expanded)
                      {
                        return Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
