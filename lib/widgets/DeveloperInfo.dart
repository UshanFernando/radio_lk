import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_lk/Providers/ThemeProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class DevInfo extends StatelessWidget {
  const DevInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("About Developer",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
                  SizedBox(height: 5),
                  Text("Developed By Ushan Fernando \n\u{00A9} 2020",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  Text("Feel free to Contact me If you face any Issues",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          const url =
                              "mailto:ushansankalpafernando@example.org?subject=Regarding%20RadioLK%20App&body=message";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: SizedBox(
                            width: 50,
                            child:
                                Image.asset(  Theme.of(context).brightness == Brightness.dark
                                    ? "assets/graphics/gmail-logo_dark.png"
                                    :"assets/graphics/gmail-logo.png")),
                      ),
                      GestureDetector(
                        onTap: () async {
                          const url = "https://github.com/UshanFernando";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: SizedBox(
                            width: 50,
                            child: Image.asset(  Theme.of(context).brightness == Brightness.dark
                                    ? "assets/graphics/github_darl.png"
                                    :"assets/graphics/github.png")),
                      ),
                      GestureDetector(
                        onTap: () async {
                          const url =
                              "https://www.facebook.com/ushan.fernando.315";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: SizedBox(
                            width: 50,
                            child: Image.asset(
                                Theme.of(context).brightness == Brightness.dark
                                    ? "assets/graphics/facebook_dark.png"
                                    : "assets/graphics/facebook.png")),
                      )
                    ],
                  )
                ],
              ),
            ));
  }
}
