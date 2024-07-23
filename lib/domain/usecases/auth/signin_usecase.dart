import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/use_case.dart';
import 'package:spotify_app/data/model/auth/create_user_req.dart';
import 'package:spotify_app/data/model/auth/sign_in_user.dart';
import 'package:spotify_app/domain/repository/auth/auth.dart';
import 'package:spotify_app/service_located.dart';

class SignInUsecase implements UseCase<Either,SignInUserReq>{
  @override
  Future<Either> call({required SignInUserReq params})async {
    return sl<AuthRepository>().signIn(params);
  }
}