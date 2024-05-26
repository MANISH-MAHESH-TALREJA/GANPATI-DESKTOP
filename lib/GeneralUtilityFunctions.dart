import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Constants.dart';

void showToast(BuildContext context, String message)
{
  Toast.show(message, duration: Toast.lengthLong, gravity: Toast.bottom, backgroundColor: Constants.OrangeColor, textStyle: TextStyle(color: Constants.GreenColor));
}

String mediaChecker(String url)
{
  String extension="";
  if(url.contains("mp3"))
  {
    extension="mp3";
  }
  if(url.contains("mp4"))
  {
    extension="mp4";
  }
  if(url.contains("jpg"))
  {
    extension="jpg";
  }
  if(url.contains("jpeg"))
  {
    extension="jpeg";
  }
  if(url.contains("png"))
  {
    extension="png";
  }
  if(url.contains("gif"))
  {
    extension="gif";
  }
  return extension;
}

void downloadWindowsFile(BuildContext context, String fileName, String url, MimeType mimeType)
{
  Alert(
    context: context,
    type: AlertType.warning,
    title: "FILE DOWNLOAD",
    desc: "ARE YOU SURE TO DOWNLOAD FILE",
    buttons: [
      DialogButton(
        child: Text(
          "DOWNLOAD",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () async
        {
          Navigator.pop(context);
          Response response;
          response = await get(Uri.parse(url));
          int statusCode = response.statusCode;
          if (statusCode == 200)
          {
            String mediaFileName  = DateTime.now().year.toString()+DateTime.now().month.toString()+DateTime.now().day.toString()+DateTime.now().hour.toString()+DateTime.now().minute.toString()+DateTime.now().second.toString()+DateTime.now().microsecond.toString();
            await FileSaver.instance.saveFile(name: fileName+" - "+mediaFileName, bytes: response.bodyBytes, ext: mediaChecker(url), mimeType: mimeType, );
            Alert(
              context: context,
              style: AlertStyle(
                animationType: AnimationType.fromTop,
                isCloseButton: false,
                isOverlayTapDismiss: false,
                descStyle: TextStyle(fontWeight: FontWeight.bold),
                descTextAlign: TextAlign.start,
                animationDuration: Duration(milliseconds: 400),
                alertBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                titleStyle: TextStyle(
                  color: Colors.red,
                ),
                alertAlignment: Alignment.topCenter,
              ),
              type: AlertType.success,
              title: "DOWNLOAD SUCCESSFUL",
              desc: "FILE DOWNLOADED SUCCESSFULLY AND SAVED TO DOWNLOADS FOLDER.",
              buttons: [
                DialogButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  color: Color.fromRGBO(0, 179, 134, 1.0),
                  radius: BorderRadius.circular(0.0),
                ),
              ],
            ).show();
          }
          else
          {
            Alert(
              context: context,
              style: AlertStyle(
                animationType: AnimationType.fromTop,
                isCloseButton: false,
                isOverlayTapDismiss: false,
                descStyle: TextStyle(fontWeight: FontWeight.bold),
                descTextAlign: TextAlign.start,
                animationDuration: Duration(milliseconds: 400),
                alertBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                titleStyle: TextStyle(
                  color: Colors.red,
                ),
                alertAlignment: Alignment.topCenter,
              ),
              type: AlertType.success,
              title: "DOWNLOAD FAILED",
              desc: "FAILED TO DOWNLOAD FILE. SOME ERROR OCCURRED.",
              buttons: [
                DialogButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  color: Color.fromRGBO(0, 179, 134, 1.0),
                  radius: BorderRadius.circular(0.0),
                ),
              ],
            ).show();
          }
        },
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "CANCEL",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ],
  ).show();
}

void launchLink(String link)
{
  if (canLaunchUrl(Uri.parse(link)) != null)
  {
    launchUrl(Uri.parse(link));
  }
  else
  {
    throw 'UNABLE TO LAUNCH !!!';
  }
}

