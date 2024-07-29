import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/use_case.dart';
import 'package:spotify_app/data/model/auth/create_user_req.dart';
import 'package:spotify_app/data/model/auth/sign_in_user.dart';
import 'package:spotify_app/domain/repository/auth/auth.dart';
import 'package:spotify_app/service_located.dart';

class GetUserUsecase implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({params})async {
    return await sl<AuthRepository>().getUser();
  }
}