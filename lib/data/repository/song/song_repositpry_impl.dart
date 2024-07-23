import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/source/songs/song_firebase_service.dart';
import 'package:spotify_app/domain/repository/song/song.dart';
import 'package:spotify_app/service_located.dart';

class SongRepositpryImpl extends SongRepository{
  @override
  Future<Either> getNewsSong()async {
    return await sl<SongFirebaseService>().getNewsSong();
  }

}