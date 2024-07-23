import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/model/song/song.dart';
import 'package:spotify_app/domain/entities/song/song.dart';

abstract class SongFirebaseService{
  Future<Either> getNewsSong();
}
class SongFirebaseServiceImpl extends SongFirebaseService{
  @override
  Future<Either> getNewsSong()async {
    try{
      List<SongEntity> songs = [];
    var data = await FirebaseFirestore.instance.collection('Songs').orderBy('releaseDate',descending: true)
    .limit(3)
    .get();
    for(var e in data.docs){
      var songModel = SongModel.fromJson(e.data());
      songs.add(
        songModel.toEntity()
      );  
      
    }
    return Right(songs);  
    }catch(e){
      return Left("An error occurred");
    }
  }

}