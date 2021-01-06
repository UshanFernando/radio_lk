import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:radio_lk/Model/Station.dart';

class Player extends StatelessWidget {
  final Function changeStation;
  final Function playFunc;
  final MediaItem selectedStation;
  final processingState;
  final playing;
  var queue = <MediaItem>[];

  Player(
      {this.selectedStation,
      this.changeStation,
      this.processingState,
      this.playing,
      this.playFunc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: null != selectedStation
                    ? CachedNetworkImage(
                        height: 60,
                        width: 60,
                        imageUrl: selectedStation.artUri,
                        fit: BoxFit.cover,
                        placeholder: (ctx, url) => Image(
                            image: AssetImage(
                                'assets/graphics/placeholder_radio.jpg')),
                      )
                    : Image(
                        image: AssetImage(
                            'assets/graphics/placeholder_radio.jpg')),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          selectedStation != null
                              ? selectedStation.title
                              : "On Air",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          selectedStation != null
                              ? "(${selectedStation.artist})"
                              : "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 170,
                      height: 25,
                      child: FittedBox(
                        alignment: Alignment.topLeft,
                        child: Text(
                          selectedStation != null
                              ? selectedStation.album
                              : "Play Radio",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              if (processingState != AudioProcessingState.none)
                ClipOval(
                  child: Material(
                    shadowColor: Colors.blue,
                    elevation: 8,
                    // button color
                    child: InkWell(
                      splashColor: Colors.purpleAccent, // inkwell color
                      child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.stop,
                            size: 40,
                            color: Colors.black,
                          )),
                      onTap: AudioService.stop,
                    ),
                  ),
                ),
              ClipOval(
                child: Material(
                  shadowColor: Colors.blue,
                  elevation: 8,

                  // button color
                  child: InkWell(
                    splashColor: Colors.purpleAccent, // inkwell color
                    child: SizedBox(
                        width: 56,
                        height: 56,
                        child: !playing
                            ? Icon(
                                Icons.play_arrow,
                                size: 50,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.pause,
                                size: 50,
                                color: Colors.black,
                              )),
                    onTap: !playing ? playFunc : AudioService.pause,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: AudioService.skipToNext,
              )
            ],
          ),
        ],
      ),
    );
  }
}
