import '../../../domain/entities/song/song.dart';

abstract class NewsSongsState{}

class NewsSongsLoading extends NewsSongsState{}

class NewsSongsLoad extends NewsSongsState{
  final List<SongEntity>  songs;
  NewsSongsLoad({required this.songs});
}
class NewsSongsLoadFailure extends NewsSongsState{}