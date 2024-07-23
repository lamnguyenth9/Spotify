import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/use_case.dart';

import 'package:spotify_app/data/source/songs/song_firebase_service.dart';

import 'package:spotify_app/service_located.dart';

class GetNewsSongsUsecase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({ params}) async {
    return await sl<SongFirebaseServiceImpl>().getNewsSong();
  }
}
