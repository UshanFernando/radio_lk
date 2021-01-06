import 'package:audio_service/audio_service.dart';
import 'package:radio_lk/Model/Station.dart';

class StationsData {
  final List<Station> queue = [
    Station(
        mediaItem: MediaItem(
          id: "http://s3.voscast.com:8404/;stream1472803644663/1",
          album: "Kiss FM 96.9",
          title: "On Air",
          artist: Station.QUALITY_SD,
          duration: null,
          artUri:
              "https://upload.wikimedia.org/wikipedia/commons/0/05/KissFMSriLankaLogo2012.png",
        ),
        category: Category.General,
        quality: Station.QUALITY_SD,
        id: 0),
    Station(
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
        id: 1),
    Station(
        mediaItem: MediaItem(
          id: "http://69.46.24.226:7669/stream",
          album: "Neth FM",
          title: "On Air",
          artist: Station.QUALITY_HQ,
          duration: null,
          artUri:
              "https://www.logolynx.com/images/logolynx/b9/b91942f11ef947f83b147ff1151c98b8.jpeg",
        ),
        category: Category.General,
        quality: Station.QUALITY_SD,
        id: 2),
    Station(
        mediaItem: MediaItem(
          id: "http://hirufm.asiabroadcasting.stream:7018/",
          album: "Hiru FM",
          title: "On Air",
          artist: Station.QUALITY_SD,
          duration: null,
          artUri: "https://uptime.com/media/website_profiles/hirufm.lk.jpg",
        ),
        category:Category.Religious,
        quality: Station.QUALITY_SD,
        id: 3),
    Station(
        mediaItem: MediaItem(
          id: "http://shaincast.caster.fm:48148/listen.mp3",
          album: "Siyatha FM",
          title: "On Air",
          artist: Station.QUALITY_HD,
          duration: null,
          artUri:
              "https://static-media.streema.com/media/cache/18/b9/18b9ef3325f83342074f4e6d5cd48b68.jpg",
        ),
        category: Category.General,
        quality: Station.QUALITY_SD,
        id: 4),
    Station(
        mediaItem: MediaItem(
          id: "http://ice3.somafm.com/thetrip-128-mp3",
          album: "Soma FM (The Trip)",
          title: "On Air",
          artist: Station.QUALITY_HD,
          duration: null,
          artUri:
              "https://somafm.com/img3/thetrip-400.jpg",
        ),
        category: Category.International,
        quality: Station.QUALITY_SD,
        id: 5),
        Station(
        mediaItem: MediaItem(
          id: "http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1_mf_p",
          album: "BBC Radio1 Channel 567",
          title: "On Air",
          artist: Station.QUALITY_HD,
          duration: null,
          artUri:
              "https://www.livetracklist.com/wp-content/uploads/bbc-radio-1-artwork.jpg",
        ),
        category: Category.International,
        quality: Station.QUALITY_SD,
        id: 6),
  ];

  get stationsList {
    return queue;
  }
}
