import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/domain/usecases/auth/song/get_play_list.dart';
import 'package:spotify_app/presentation/home/bloc/play_list_state.dart';

import '../../../service_located.dart';

class PlayListCubit extends Cubit<PlayListState>{
  PlayListCubit():super(PlayListLoading());
 Future<void> getPlayList()async{
   var returnedSongs = await sl<GetPlayListUsercase>().call();
   returnedSongs.fold(
    (l){
      emit(PlayListLoadingFailure());
    }, 
    (data){
      emit(PlayListLoad(songs: data));
    });
 }
}