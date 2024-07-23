import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/model/auth/create_user_req.dart';
import 'package:spotify_app/data/model/auth/sign_in_user.dart';
import 'package:spotify_app/data/source/auth/auth_firebase_service.dart';
import 'package:spotify_app/domain/repository/auth/auth.dart';
import 'package:spotify_app/service_located.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signIn(SignInUserReq signInUserReq)async {
    return await sl<AuthFirebaseService>().signIn(signInUserReq);
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async{
   return await sl<AuthFirebaseService>().signUp(createUserReq);
  }
}