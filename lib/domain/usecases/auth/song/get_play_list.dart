import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/use_case.dart';



import 'package:spotify_app/service_located.dart';

import '../../../repository/song/song.dart';

class GetPlayListUsercase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({ params}) async {
    return await sl<SongRepository>().getPlayList();
  }
}
