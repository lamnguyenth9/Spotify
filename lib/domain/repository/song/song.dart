
import 'package:dartz/dartz.dart';

abstract class SongRepository{
  Future<Either> getNewsSong();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSong();
}