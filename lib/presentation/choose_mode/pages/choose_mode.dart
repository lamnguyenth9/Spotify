import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/core/config/themes/app_theme.dart';
import 'package:spotify_app/presentation/auth/pages/signup_or_signin.dart';
import 'package:spotify_app/presentation/choose_mode/bloc/theme_cubit.dart';

import '../../../common/widget/button/basic_app_button.dart';
import '../../../core/config/assets/app_image.dart';
import '../../../core/config/assets/app_vector.dart';
import '../../../core/config/themes/app_color.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImage.chooseModeBg))
            ),
            
          ),
          Container(
            color: Colors.black.withOpacity(0.15),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40
            ),
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AppVector.logo)),
                  const Spacer(),
                  const Text("Choose Mode",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white
                  ),),
                  const SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                            },
                            child: ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xff30393C).withOpacity(0.5),
                                  ),
                                  child: SvgPicture.asset(AppVector.moon,fit: BoxFit.none,),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          const Text("Dark mode", style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: AppColor.grey
                          ),)
                        ],
                      ),
                      const SizedBox(width: 40,),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                            },
                            child: ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xff30393C).withOpacity(0.5),
                                  ),
                                  child: SvgPicture.asset(AppVector.sun,fit: BoxFit.none,),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          const Text("Light mode", style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: AppColor.grey
                          ),)
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 100,),
                  BasicAppButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const SignupOrSignin()));
                    }, 
                    text: "Continue")
              
                ],
              ),
            ),
        ],
      ),
    );
    
  }
}