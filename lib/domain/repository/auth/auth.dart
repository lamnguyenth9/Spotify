import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/model/auth/create_user_req.dart';
import 'package:spotify_app/data/model/auth/sign_in_user.dart';

abstract class AuthRepository{
  Future<Either> signIn(SignInUserReq signInUserReq);
  Future<Either> signUp(CreateUserReq createUserReq);
  Future<Either> getUser();

}