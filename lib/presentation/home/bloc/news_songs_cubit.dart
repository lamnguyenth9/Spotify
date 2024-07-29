 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/domain/usecases/auth/song/get_news_songs_usercase.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_app/service_located.dart';

class NewsSongsCubit extends Cubit<NewsSongsState>{
  NewsSongsCubit():super(NewsSongsLoading());
 Future<void> getNewsSongs()async{
   var returnedSongs = await sl<GetNewsSongsUsecase>().call();
   returnedSongs.fold(
    (l){
      emit(NewsSongsLoadFailure());
    }, 
    (data){
      emit(NewsSongsLoad(songs: data));
    });
 }
}