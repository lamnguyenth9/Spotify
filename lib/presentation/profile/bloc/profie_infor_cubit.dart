import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/domain/usecases/auth/get_user.dart';
import 'package:spotify_app/presentation/profile/bloc/profile_infor_state.dart';
import 'package:spotify_app/service_located.dart';

class ProfieInforCubit extends Cubit<ProfileInforState>{
  ProfieInforCubit():super(ProfileInforLoading());

  Future<void> getUser()async{
    var user = await sl<GetUserUsecase>().call();
    user.fold(
      (l){
        print(l);
        emit(ProfileInforFailure());}, 
      (userEntity){
        emit(ProfileInforLoaded(userEntity: userEntity));
      });
  }
}