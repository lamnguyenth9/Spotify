
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_app/core/config/constans/app_url.dart';
import 'package:spotify_app/data/model/auth/create_user_req.dart';
import 'package:spotify_app/data/model/auth/sign_in_user.dart';
import 'package:spotify_app/data/model/auth/user.dart';
import 'package:spotify_app/domain/entities/auth/user.dart';

abstract class AuthFirebaseService{
   Future<Either> signIn(SignInUserReq signInUserReq);
   Future<Either> signUp(CreateUserReq createUserReq);
   Future<Either> getUser();
}
class AuthFirebaseServiceImplement extends AuthFirebaseService{
  @override
  Future<Either> signIn(SignInUserReq signInUserReq)async {
    try{
      
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInUserReq.email, 
        password: signInUserReq.password);
        
        return Right('Sign in was successfull');
    }on FirebaseAuthException catch(e){
      String message='';
    if(e.code=='invalid-email'){
        message='Not user found for that email';
    } else if(e.code=='invalid-credential'){
        message = 'Wrong password provided for that user';
    }
    return Left(message);
    }
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {

    try{
     var data= await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email, 
        password: createUserReq.password);
        FirebaseFirestore.instance.collection('Users').doc(data.user?.uid)
        .set({
          'name':createUserReq.fullName,
          'email':data.user?.email
        });
        return Right('Sign up was successfull');
    }on FirebaseAuthException catch(e){
      String message='';
    if(e.code=='weak-password'){
        message='The password provided is too weak';
    } else if(e.code=='email-already-in-use'){
        message = 'An account already exist with that email';
    }
    return Left(message);
    }
    
    
  }
  
  @override
  Future<Either> getUser() async{
    try{
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    print("1");
    var user = await firebaseFirestore.collection("Users").doc(
      firebaseAuth.currentUser?.uid
    ).get();
    print(user.id);
    print(user);
    UserModel userModel = UserModel.fromJson(user.data()!);
    print("3");
    userModel.imageUrl=firebaseAuth.currentUser?.photoURL??AppUrl.defaultImage;
    UserEntity userEntity =userModel.toEntity();
    return Right(userEntity);
    }catch(e){
     print(e);
     return Left("Some error"); 
    }
  }

}