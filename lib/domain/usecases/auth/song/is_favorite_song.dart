import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/use_case.dart';



import 'package:spotify_app/service_located.dart';

import '../../../repository/song/song.dart';

class IsFavoriteSongUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String ? params}) async {
    return await sl<SongRepository>().isFavoriteSong(params!);
  }
}