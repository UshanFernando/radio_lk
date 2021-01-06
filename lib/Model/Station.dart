import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';

enum Category {
  International,
  Religious,
  News,
  General,
}

class Station {
  static const String QUALITY_SD = "SD 64 Kbps";
  static const String QUALITY_LQ = "LQ 48 Kbps";
  static const String QUALITY_HQ = "HQ 128 Kbps";
  static const String QUALITY_HD = "HD 192 Kbps";
  static const String QUALITY_HIGH_RES = "HI-RES 320 Kbps";

  int id;
  Category category;
  String quality;
  String type;

  Station(
      {@required this.mediaItem,
      @required this.id,
      @required this.category,
      @required this.quality,
      this.type});

  String get getType => type;

  set setType(String type) => this.type = type;
  MediaItem mediaItem;

  int get getId => id;

  set setId(int id) => this.id = id;

  Category get getTitle => category;

  set setCategory(Category category) => this.category = category;

  String get getAlbum => quality;

  set setAlbum(String album) => this.quality = album;

  MediaItem get getMedia => mediaItem;

  set setMedia(MediaItem item) => this.mediaItem = item;
}
