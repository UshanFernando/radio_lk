import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:radio_lk/Controller/StationsData.dart';
import 'package:radio_lk/Model/Station.dart';
import 'package:radio_lk/PlayerBG/AudioPlayerTask.dart';
import 'package:radio_lk/Providers/Stations.dart';
import 'package:radio_lk/screens/TabsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'carousel_station.dart';

class Stations extends StatefulWidget {
  Function changeStation;
  MediaItem station;
  Stations(this.changeStation, this.station);

  @override
  _StationsState createState() => _StationsState();
}

class _StationsState extends State<Stations> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _queue = StationsData().queue;

  List<int> _favSaved;

  List<Widget> _carouselItems;

  CarouselController cController = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    _loadFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final statProvider = Provider.of<StationsProvider>(context);
    print("station upadted ${widget.station.id}");
    _queue.map((e) => {
          _carouselItems.add(Card(
            child: Text("data"),
          )),
        });
    onChangedItem(widget.station);
    // WidgetsBinding.instance.addPostFrameCallback((_) => onChangedItem(station));
    return Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            CarouselSlider(
              carouselController: cController,
              items: _queue
                  .map((item) => Container(
                        child: Center(child: CarouselStation(item.mediaItem)),
                      ))
                  .toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.25,
                aspectRatio: 16 / 9,
                viewportFraction: 0.4,
                initialPage: _queue
                    .indexWhere((e) => e.mediaItem.id == widget.station.id),
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) => {
                  if (reason == CarouselPageChangedReason.manual)
                    {widget.changeStation(_queue[index])},
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: DefaultTabController(
                length: 4,
                child: Scaffold(
                  appBar: TabBar(
                    labelColor: Colors.black,
                    isScrollable: true,
                    tabs: <Widget>[
                      Tab(text: "All"),
                      Tab(text: "Favourite"),
                      Tab(text: "International"),
                      Tab(text: "Religious")
                    ],
                  ),
                  body: Container(
                      margin: EdgeInsets.all(5),
                      child: TabBarView(children: [
                        listBuilder(null),
                        buildFavourites(),
                        listBuilder(Category.International),
                        listBuilder(Category.Religious)
                      ])),
                ),
              ),
            ),
          ],
        ));
  }

  Widget listBuilder(Category category) {
    return ListView.builder(
        itemCount: _queue.length,
        itemBuilder: (BuildContext contex, int i) {
          Station item = _queue[i];
          if (null != category && item.category != category) {
            return Container();
          }

          return Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 179, 198, 209)))),
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.only(bottom: 2, left: 10, right: 10),
              child: ListTile(
                title: Text(item.mediaItem.album),
                enabled: true,
                onTap: () => {
                  // cController.jumpToPage(_queue[i].id),
                  widget.changeStation(item)
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    height: 35,
                    width: 35,
                    imageUrl: item.mediaItem.artUri,
                    fit: BoxFit.cover,
                    placeholder: (ctx, url) => Image(
                        image: AssetImage(
                            'assets/graphics/placeholder_radio.jpg')),
                  ),
                ),
                dense: true,
                trailing: IconButton(
                    icon: Icon(
                      Icons.star,
                     color:_favSaved.contains(i)?  Colors.orangeAccent:Colors.grey,
                    ),
                    onPressed: () => {_setFavourite(i)}),
              ));
        });
  }

  Widget buildFavourites() {
    return ListView.builder(
        itemCount: _favSaved.length,
        itemBuilder: (BuildContext contex, int i) {
          Station item = _queue[_favSaved[i]];
          return Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 179, 198, 209)))),
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.only(bottom: 2, left: 10, right: 10),
              child: ListTile(
                title: Text(item.mediaItem.album),
                enabled: true,
                onTap: () => {
                  // cController.jumpToPage(_queue[i].id),
                  widget.changeStation(item)
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    height: 35,
                    width: 35,
                    imageUrl: item.mediaItem.artUri,
                    fit: BoxFit.cover,
                    placeholder: (ctx, url) => Image(
                        image: AssetImage(
                            'assets/graphics/placeholder_radio.jpg')),
                  ),
                ),
                dense: true,
                trailing: IconButton(
                    icon: Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                    onPressed: () => {_setFavourite(_favSaved[i])}),
              ));
        });
  }

  Future<void> onChangedItem(MediaItem station) {
    cController
        .animateToPage(_queue.indexWhere((e) => e.mediaItem.id == station.id));
    // cController.animateToPage(5);
    print('onchange called StationsCarusal');
  }

  Future<void> _loadFavorites() async {
    final SharedPreferences prefs = await _prefs;

    // fetch your string list
    List<String> mListSt = (prefs.getStringList('favList') ?? List<String>());

//convert your string list to your original int list

    setState(() {
      _favSaved = mListSt.map((i) => int.parse(i)).toList();
    });
  }

  Future<void> _setFavourite(int station) async {
    final SharedPreferences prefs = await _prefs;
    if (_favSaved.contains(station)) {
      _favSaved.remove(station);
       Fluttertoast.showToast(
        msg: "Removed from Favourites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
      print("removed to Favorites");
    } else {
      _favSaved.add(station);
      print("Added to Favorites");
          Fluttertoast.showToast(
        msg: "Added to Favourites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }

// convert your custom list to string list
    List<String> favList = _favSaved.map((i) => i.toString()).toList();

// store your string list in shared prefs
    print(favList);
    prefs.setStringList("favList", favList);
    _loadFavorites();
    
  }
}
