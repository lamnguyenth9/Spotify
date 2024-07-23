import 'package:get_it/get_it.dart';
import 'package:spotify_app/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify_app/data/repository/song/song_repositpry_impl.dart';
import 'package:spotify_app/data/source/auth/auth_firebase_service.dart';
import 'package:spotify_app/data/source/songs/song_firebase_service.dart';
import 'package:spotify_app/domain/repository/auth/auth.dart';
import 'package:spotify_app/domain/repository/song/song.dart';
import 'package:spotify_app/domain/usecases/auth/signup_usecase.dart';
import 'package:spotify_app/domain/usecases/auth/song/signup_usecase.dart';

import 'domain/usecases/auth/signin_usecase.dart';

final sl =GetIt.instance;

Future<void> initializeDependecies()async{

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImplement());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  
  sl.registerSingleton<SongRepository>(SongRepositpryImpl());
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<SignInUsecase>(SignInUsecase());
   sl.registerSingleton<GetNewsSongsUsecase>(GetNewsSongsUsecase());

}