import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../general_utility_functions.dart';

class RepublicDrawer extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>
            [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Constants.OrangeColor),
                accountName:  SizedBox(
                  width: MediaQuery.of(context).size.width-25,
                  child: TyperAnimatedTextKit(
                    onTap: () => showToast(context, "HAPPY GANESH CHATURTHI 2021"),
                    speed: Duration(milliseconds: 250),
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    text:
                    [
                      "GANPATI BAPPA"
                    ],
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Tahoma",
                      color: Constants.GreenColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                accountEmail:  SizedBox(
                  width: MediaQuery.of(context).size.width-25,
                  child: TyperAnimatedTextKit(
                    onTap: () => showToast(context, "HAPPY GANESH CHATURTHI 2021"),
                    speed: Duration(milliseconds: 250),
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    text:
                    [
                      "MANISH MAHESH TALREJA"
                    ],
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Tahoma",
                      color: Constants.GreenColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                currentAccountPicture: CircleAvatar(backgroundImage: AssetImage("assets/images/app_icon.png"), backgroundColor: Colors.transparent),
              ),
              Divider(thickness: 2.00,color: Colors.transparent),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                      title: new Text("ABOUT US", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Constants.BlueColor)),
                      trailing: Icon(Icons.arrow_forward_ios, color: Constants.GreenColor),
                      leading: Icon(Icons.info, color: Constants.OrangeColor),
                      onTap: ()
                      {
                        Navigator.of(context).pop();
                        showDialog
                          (
                          context: context,
                          builder: (BuildContext context)
                          {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              title: Center(
                                child:Text("ABOUT DEVELOPERS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00, color: Constants.GreenColor)),
                              ),
                              actions:
                              [
                                MaterialButton(
                                child: Text("CLOSE",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.00)),
                                onPressed: () => Navigator.of(context).pop(),
                                )
                              ],
                              content: SingleChildScrollView(
                                child: Text("DEVELOPER : MANISH MAHESH TALREJA\n\nPURPOSE : \n   GANPATI BAPPA - A VIRTUAL GANPATI BAPPA CELEBRATION APPLICATION.", style:TextStyle(fontFamily: Constants.AppFont, fontWeight: FontWeight.bold, color: Constants.OrangeColor, letterSpacing: 1)
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 2.5),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                      title: new Text("CONTACT US", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Constants.BlueColor)),
                      trailing: Icon(Icons.arrow_forward_ios, color: Constants.GreenColor),
                      leading: Icon(Icons.email, color: Constants.OrangeColor),
                      onTap: ()
                      {
                        Navigator.of(context).pop();
                        _launchURL('manishtalreja189@gmail.com', 'DEVELOPER CONTACT', 'RESPECTED DEVELOPER,\n\n');
                      }
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 2.5),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: new Text("PRIVACY POLICY",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Constants.BlueColor)),
                    trailing: Icon(Icons.arrow_forward_ios, color: Constants.GreenColor),
                    leading: Icon(Icons.lock, color: Constants.OrangeColor),
                    onTap: ()
                    {
                      Navigator.of(context).pop();
                      launchLink(Constants.AppPrivacyPolicyPage);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 2.5),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: new Text("MORE APPS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Constants.BlueColor)),
                    trailing: Icon(Icons.arrow_forward_ios, color: Constants.GreenColor),
                    leading: Icon(Icons.sentiment_satisfied, color: Constants.OrangeColor),
                    onTap: ()
                    {
                      Navigator.of(context).pop();
                      launchLink("https://www.microsoft.com/en-us/search/shop/Apps?q=MANISH+MAHESH+TALREJA");
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 2.5),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: new Text("EXIT APP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Constants.BlueColor)),
                    trailing: Icon(Icons.arrow_forward_ios, color: Constants.GreenColor),
                    leading: Icon(Icons.cancel, color: Constants.OrangeColor),
                    onTap: () => appWindow.close(),
                  ),
                ),
              ),
              Divider(thickness: 2.00,color: Colors.transparent)
            ],
          ),
        )
    );
  }

  _launchURL(String toMailId, String subject, String body) async
  {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    launchLink(url);
  }

  // ignore: non_constant_identifier_names
  AppBar RepublicAppBar(BuildContext context, List<String> title)
  {
    return AppBar(
      actions: <Widget>
      [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: IconButton
            (
              icon: Icon(Icons.close_fullscreen, color: Constants.OrangeColor,),
              tooltip: 'MINIMIZE APPLICATION',
              onPressed: () => appWindow.minimize(),
          ),
        ),
        IconButton
          (
            icon: Icon(Icons.zoom_out_map_rounded, color: Constants.OrangeColor,),
            tooltip: 'MAXIMIZE APPLICATION',
            onPressed: () => showToast(context, "MAXIMIZE IS NOT ALLOWED"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: IconButton
            (
              icon: Icon(Icons.close, color: Constants.OrangeColor, size: 30,),
              tooltip: 'CLOSE APPLICATION',
              onPressed: () => appWindow.close(),
          ),
        ),
      ],
      title: WindowTitleBarBox(
        child: MoveWindow(
          child: ScaleAnimatedTextKit(
              onTap: () {},
              text: title,
              textStyle: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "Tahoma",
                  color: Constants.OrangeColor,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
              repeatForever: true,
          ),
        ),
      ),
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: Constants.OrangeColor),
      backgroundColor: Colors.transparent,
    );
  }

  // ignore: non_constant_identifier_names
  Widget TirangaProgressBar(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height*0.4,
            width: MediaQuery.of(context).size.width*0.4,
          child: Center(
              child: Image.asset("assets/images/navratri_08.gif", fit: BoxFit.fill,)
          ),
        ),
      ),
    );
  }
}

class CustomCacheImage extends StatelessWidget
{
  final String imageUrl;
  const CustomCacheImage({required this.imageUrl});

  @override
  Widget build(BuildContext context)
  {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
      placeholder: (context, url) => Container(child: Image.asset("assets/images/navratri_07.gif")),
      errorWidget: (context, url, error) => Image.asset("assets/images/app_icon.png", fit: BoxFit.fill,),
    );
  }
}