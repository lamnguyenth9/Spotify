import '../../../domain/entities/song/song.dart';

abstract class PlayListState{}

class PlayListLoading extends PlayListState{}

class PlayListLoad extends PlayListState{
  final List<SongEntity> songs;
  PlayListLoad({required this.songs});
  
}
class PlayListLoadingFailure extends PlayListState{}