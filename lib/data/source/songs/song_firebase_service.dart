import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_app/data/model/song/song.dart';
import 'package:spotify_app/domain/entities/song/song.dart';
import 'package:spotify_app/domain/usecases/auth/song/is_favorite_song.dart';
import 'package:spotify_app/service_located.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSong();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSong();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSong() async {
    try {
      List<SongEntity> songs = [];
      
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(5)
          .get();
      for (var e in data.docs) {
        var songModel = SongModel.fromJson(e.data());
        bool isFavorite =
            await sl<IsFavoriteSongUseCase>().call(params: e.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = e.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return Left("An error occurred");
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var e in data.docs) {
        var songModel = SongModel.fromJson(e.data());
        bool isFavorite =
            await sl<IsFavoriteSongUseCase>().call(params: e.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = e.reference.id;

        songs.add(songModel.toEntity());
        
      }
      
      return Right(songs);
    } catch (e) {
      
      return const Left('An error occurred, Please try again.');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
    late  bool isFavorite = false;
      QuerySnapshot favoriteSong = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();
      if (favoriteSong.docs.isNotEmpty) {
        await favoriteSong.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({'songId': songId, 'addedDate': Timestamp.now()});
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return Left('Somme error occurred');
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSong = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();
      if (favoriteSong.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<Either> getUserFavoriteSong() async {
   try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      List<SongEntity> favoriteSong=[];
      String uId = user!.uid;
      QuerySnapshot favoriteSnapshot= await firebaseFirestore.collection(
        'Users'
      ).doc(uId)
      .collection('Favorites').get();
      for(var element in favoriteSnapshot.docs){
        String songId = element['songId'];
        var song = await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite=true;
        songModel.songId=songId;
        favoriteSong.add(songModel.toEntity());
      }
      return Right(favoriteSong);
    } catch (e) {
      return Left("Some Error");
    }
  }
}
