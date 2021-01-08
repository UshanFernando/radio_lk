import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_lk/Controller/StationsData.dart';
import 'package:radio_lk/Providers/Stations.dart';
import 'package:radio_lk/screens/Settings.dart';
import 'package:radio_lk/widgets/Stations.dart';
import 'dart:async';
import 'package:radio_lk/widgets/player.dart';
import 'package:rxdart/rxdart.dart';
import 'Model/Station.dart';
import 'PlayerBG/AudioPlayerTask.dart';
import 'Providers/ThemeProvider.dart';

void main() => runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(), child: new MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        title: 'Radio.lk',
        theme: theme.getTheme,
        showPerformanceOverlay: true,
        // ThemeData(
        //   primarySwatch: Colors.red,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        home: MyHomePage(title: 'Radio.lk'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isPlaying;
  Station _selectedStation = Station(
      mediaItem: MediaItem(
        id: "http://live.trusl.com:1180",
        album: "Y FM 92.6",
        title: "On Air",
        artist: Station.QUALITY_HQ,
        duration: null,
        artUri: "https://i.ibb.co/2yND0dM/maxresdefault.jpg",
      ),
      category: Category.General,
      quality: Station.QUALITY_SD,
      id: 1);
  bool _loading;

  // final BehaviorSubject<double> _dragPositionSubject =
  //     BehaviorSubject.seeded(null);

  final _queue = StationsData().queue;

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  Future<void> changeStation(Station station) {
    print("change station called : ${station.mediaItem.id}");
    // setState(() {
    //   _selectedStation = station;
    // });
    if (AudioService.running) {
      AudioService.playFromMediaId(station.mediaItem.id);
    } else {
      playRadio();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          // Colors.white,
          Color.fromARGB(255, 179, 198, 209),
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(context).brightness == Brightness.dark
              ? LinearGradient(colors: [
                  Color.fromARGB(255, 20, 30, 48),
                  Color.fromARGB(255, 36, 59, 85),
                ])
              : LinearGradient(colors: [
                  Color.fromARGB(255, 255, 148, 114),
                  Color.fromARGB(255, 242, 112, 156),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: StreamBuilder<AudioState>(
            stream: _audioStateStream,
            builder: (context, snapshot) {
              final audioState = snapshot.data;
              final mediaItem = audioState?.mediaItem;
              final playbackState = audioState?.playbackState;
              final processingState =
                  playbackState?.processingState ?? AudioProcessingState.none;
              final playing = playbackState?.playing ?? false;
              //  print("Audio State Id : ${audioState.mediaItem.id}");
              //  print("Selected Id : ${statProvider.selectedStation.mediaItem.id}");
              // if (mediaItem != null) if (statProvider
              //         .selectedStation.mediaItem.id !=
              //     mediaItem.id)
              {
                // statProvider.changeStation(_queue
                //     .singleWhere((e) => e.mediaItem.id == mediaItem.id)

                print("State Updated");
              }
              return Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          print("Open Settings Callled");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingScreen()),
                          );
                        },
                        child: SizedBox(
                          width: 50,
                          height: 100,
                          // padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                          child: Icon(
                            Icons.settings,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  SizedBox(
                    child: mediaItem == null
                        ? Stations(changeStation, _selectedStation.mediaItem)
                        : Stations(changeStation, mediaItem),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: AudioServiceWidget(
                          child: Player(
                        selectedStation: mediaItem,
                        playing: playing,
                        processingState: processingState,
                        playFunc: playRadio,
                        changeStation: () => {},
                      )))
                ],
              );
            }),
      ),
    );
    // return SettingScreen();
  }

  playRadio() async {
    print("play radio called");
    if (!AudioService.running) {
      await _startAudioPlayerBtn();
    }
    await AudioService.play();
  }

  _startAudioPlayerBtn() async {
    List<dynamic> list = List();
    for (int i = 0; i < _queue.length; i++) {
      var m = _queue[i].mediaItem.toJson();
      list.add(m);
    }
    String initId;
    if (null == _selectedStation) {
      initId = "http://69.46.24.226:7669/stream";
    } else {
      initId = _selectedStation.mediaItem.id;
    }

    var params = {"data": list, "init": initId};
    setState(() {
      _loading = true;
    });

    await AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Audio Player',
      androidNotificationColor: 0xFF2196f3,
      androidNotificationIcon: 'mipmap/ic_launcher',
      params: params,
    );
    setState(() {
      _loading = false;
    });
    print("satrtbtn called");
  }

  // Widget positionIndicator(MediaItem mediaItem, PlaybackState state) {
  //   double seekPos;
  //   return StreamBuilder(
  //     stream: Rx.combineLatest2<double, double, double>(
  //         _dragPositionSubject.stream,
  //         Stream.periodic(Duration(milliseconds: 200)),
  //         (dragPosition, _) => dragPosition),
  //     builder: (context, snapshot) {
  //       double position =
  //           snapshot.data ?? state.currentPosition.inMilliseconds.toDouble();
  //       double duration = mediaItem?.duration?.inMilliseconds?.toDouble();
  //       return Column(
  //         children: [
  //           if (duration = null)
  //             Slider(
  //               min: 0.0,
  //               max: duration,
  //               value: seekPos ?? max(0.0, min(position, duration)),
  //               onChanged: (value) {
  //                 _dragPositionSubject.add(value);
  //               },
  //               onChangeEnd: (value) {
  //                 AudioService.seekTo(Duration(milliseconds: value.toInt()));
  //                 // Due to a delay in platform channel communication, there is
  //                 // a brief moment after releasing the Slider thumb before the
  //                 // new position is broadcast from the platform side. This
  //                 // hack is to hold onto seekPos until the next state update
  //                 // comes through.
  //                 // TODO: Improve this code.
  //                 seekPos = value;
  //                 _dragPositionSubject.add(null);
  //               },
  //             ),
  //           Text("${state.currentPosition}"),
  //         ],
  //       );
  //     },
  //   );
  // }
}

Stream<AudioState> get _audioStateStream {
  return Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState,
      AudioState>(
    AudioService.queueStream,
    AudioService.currentMediaItemStream,
    AudioService.playbackStateStream,
    (queue, mediaItem, playbackState) => AudioState(
      queue,
      mediaItem,
      playbackState,
    ),
  );
}

void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
