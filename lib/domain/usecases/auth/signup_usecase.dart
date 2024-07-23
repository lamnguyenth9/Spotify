import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/use_case.dart';
import 'package:spotify_app/data/model/auth/create_user_req.dart';
import 'package:spotify_app/domain/repository/auth/auth.dart';
import 'package:spotify_app/service_located.dart';

class SignupUsecase implements UseCase<Either,CreateUserReq>{
  @override
  Future<Either> call({required CreateUserReq params})async {
    return sl<AuthRepository>().signUp(params);
  }
}