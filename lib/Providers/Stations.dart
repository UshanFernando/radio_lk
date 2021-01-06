import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:radio_lk/Model/Station.dart';

class StationsProvider with ChangeNotifier {
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

  get selectedStation => _selectedStation;

  changeStation(Station station) {
    _selectedStation = station;
    print("provider station changed");
    notifyListeners();
  }

  calcToatal() {}

  loadValues() {}
}
