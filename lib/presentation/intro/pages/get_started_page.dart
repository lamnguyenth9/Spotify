import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/widget/button/basic_app_button.dart';
import 'package:spotify_app/core/config/assets/app_image.dart';
import 'package:spotify_app/core/config/assets/app_vector.dart';
import 'package:spotify_app/core/config/themes/app_color.dart';
import 'package:spotify_app/presentation/choose_mode/pages/choose_mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImage.imageBg))
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
                  const Text("Enjoy listening to music",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white
                  ),),
                  const SizedBox(height: 20,),
                  const Text(
                    textAlign: TextAlign.center,
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam."
                    ,style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: AppColor.grey
                  ),),
                  const SizedBox(height: 20,),
                  BasicAppButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ChooseModePage()));
                    }, 
                    text: "Get started")
              
                ],
              ),
            ),
        ],
      ),
    );
  }
}