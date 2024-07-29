import 'package:get_it/get_it.dart';
import 'package:spotify_app/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify_app/data/repository/song/song_repositpry_impl.dart';
import 'package:spotify_app/data/source/auth/auth_firebase_service.dart';
import 'package:spotify_app/data/source/songs/song_firebase_service.dart';
import 'package:spotify_app/domain/repository/auth/auth.dart';
import 'package:spotify_app/domain/repository/song/song.dart';
import 'package:spotify_app/domain/usecases/auth/get_user.dart';
import 'package:spotify_app/domain/usecases/auth/signup_usecase.dart';
import 'package:spotify_app/domain/usecases/auth/song/add_or_remove_favorite_song.dart';
import 'package:spotify_app/domain/usecases/auth/song/get_favorite_song.dart';

import 'package:spotify_app/domain/usecases/auth/song/get_news_songs_usercase.dart';
import 'package:spotify_app/domain/usecases/auth/song/get_play_list.dart';
import 'package:spotify_app/domain/usecases/auth/song/is_favorite_song.dart';

import 'domain/usecases/auth/signin_usecase.dart';

final sl =GetIt.instance;

Future<void> initializeDependecies()async{

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImplement());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongRepository>(SongRepositpryImpl());
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<SignInUsecase>(SignInUsecase());
   sl.registerSingleton<GetNewsSongsUsecase>(GetNewsSongsUsecase());
   sl.registerSingleton<GetPlayListUsercase>(GetPlayListUsercase());
  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(AddOrRemoveFavoriteSongUseCase());
  sl.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());
  sl.registerSingleton<GetUserUsecase>(GetUserUsecase());
  sl.registerSingleton<GetFavoriteSongUsecase>(GetFavoriteSongUsecase());
  


}