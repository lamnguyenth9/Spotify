import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/helper/is_dark.dart';
import 'package:spotify_app/common/widget/button/basic_app_button.dart';
import 'package:spotify_app/core/config/assets/app_image.dart';
import 'package:spotify_app/core/config/assets/app_vector.dart';
import 'package:spotify_app/core/config/themes/app_color.dart';
import 'package:spotify_app/presentation/auth/pages/login_page.dart';
import 'package:spotify_app/presentation/auth/pages/sign_up_page.dart';

import '../../../common/widget/app_bar.dart';

class SignupOrSignin extends StatelessWidget {
  const SignupOrSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        
        children: [
          const BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVector.top_partern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVector.bottom_partern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImage.authImage),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVector.logo),
                  const SizedBox(height: 55,),
                  const Text(
                    "Enjoy listing to music",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
              
                    ),
                  ),
                  const SizedBox(height: 21,),
                  const Text(
                    textAlign: TextAlign.center,
                    "Spotify is a proprietary Swedish audio\n streaming and media services provider ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: AppColor.grey
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicAppButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpPage()));
                        }, text: 'Register')),
                        const SizedBox(width: 20,),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage()));
                          }, 
                          child: Text(
                            "Sign in", style: TextStyle(
                              color: context.isDarkMode? Colors.white:Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          )))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}