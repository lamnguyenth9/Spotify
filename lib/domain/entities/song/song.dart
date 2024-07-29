import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String name;
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final bool isFavorite;
  final String songId;

  SongEntity( this.songId,
      {required this.name,
      required this.title,
      required this.artist,
      required this.duration,
      required this.releaseDate,
      required this.isFavorite});
}
