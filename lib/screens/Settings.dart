import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radio_lk/widgets/DeveloperInfo.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _darkMode = false;
  int _quality = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          // Colors.white,
          Color.fromARGB(255, 179, 198, 209),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 255, 148, 114),
            Color.fromARGB(255, 242, 112, 156),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 25,
                          ),
                          onPressed: () => {
                            Navigator.pop(context)
                          }),
                      Text(
                        "Change Your Settings",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Select Broadcast Quality",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\u{26A0} Warning selecting a higher quality may results in higher Data Usage!",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.orangeAccent),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          color:
                              _quality == 0 ? Colors.blue[100] : Colors.white,
                          onPressed: () => {
                            setState(() {
                              _quality = 0;
                            })
                          },
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              Icon(
                                Icons.sd,
                                size: 50,
                                color: Colors.cyan,
                              ),
                              Text("64 kbps")
                            ],
                          ),
                        ),
                        FlatButton(
                          color:
                              _quality == 1 ? Colors.orange[100] : Colors.white,
                          onPressed: () => {
                            setState(() {
                              _quality = 1;
                            })
                          },
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              Icon(
                                Icons.high_quality,
                                size: 50,
                                color: Colors.orangeAccent,
                              ),
                              Text("128 kbps")
                            ],
                          ),
                        ),
                        FlatButton(
                          color: _quality == 2 ? Colors.red[100] : Colors.white,
                          onPressed: () => {
                            setState(() {
                              _quality = 2;
                            })
                          },
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              Icon(
                                Icons.hd,
                                size: 50,
                                color: Colors.redAccent,
                              ),
                              Text("320 kbps")
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "\u{2139} Please Note that Some Stations may not support this feature.",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueAccent),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Dark Mode",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        CupertinoSwitch(
                          value: _darkMode,
                          activeColor: Colors.pinkAccent,
                          onChanged: (value) {
                            setState(() {
                              _darkMode = value;
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
              DevInfo()
            ],
          ),
        ),
      ),
    );
  }
}
