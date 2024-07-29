import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/source/songs/song_firebase_service.dart';
import 'package:spotify_app/domain/repository/song/song.dart';
import 'package:spotify_app/service_located.dart';

class SongRepositpryImpl extends SongRepository{
  @override
  Future<Either> getNewsSong()async {
    return await sl<SongFirebaseService>().getNewsSong();
  }
  
  @override
  Future<Either> getPlayList()async {
    return await sl<SongFirebaseService>().getPlayList();
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSong(songId);
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await sl<SongFirebaseService>().isFavoriteSong(songId);
  }
  
  @override
  Future<Either> getUserFavoriteSong() async {
    return await sl<SongFirebaseService>().getUserFavoriteSong();
  }

}