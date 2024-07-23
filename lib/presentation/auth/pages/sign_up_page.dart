import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/helper/is_dark.dart';
import 'package:spotify_app/common/widget/app_bar.dart';
import 'package:spotify_app/common/widget/button/basic_app_button.dart';
import 'package:spotify_app/core/config/assets/app_vector.dart';
import 'package:spotify_app/data/model/auth/create_user_req.dart';
import 'package:spotify_app/domain/usecases/auth/signup_usecase.dart';
import 'package:spotify_app/presentation/auth/pages/login_page.dart';
import 'package:spotify_app/presentation/home/pages/home.dart';
import 'package:spotify_app/service_located.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});
   final TextEditingController _fullName=TextEditingController();
   final TextEditingController _email=TextEditingController();

final TextEditingController _password=TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        
        title: SvgPicture.asset(AppVector.logo,width: 40,height: 40,),
      ),
      bottomNavigationBar: _signInText(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Text("Register", style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: context.isDarkMode?Colors.white:Colors.black
            ),
            textAlign: TextAlign.center,),
            const SizedBox(height: 50,),
            _fullNameField(context),
            const SizedBox(height: 20,),
            _emailField(context),
            const SizedBox(height: 20,),
            _passwordField(context),
            const SizedBox(height: 30,),
            BasicAppButton(onPressed: ()async{
              var result = await sl<SignupUsecase>().call(params: CreateUserReq(
                fullName: _fullName.text.toString(), 
                email: _email.text.toString(), 
                password: _password.text.toString()));
                result.fold(
                  (l){
                    var snackBar = SnackBar(content: Text(l));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }, 
                  (r){
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (_)=>HomePage()), 
                      (route)=>false);
                  });
                

            }, 
            text: "Create Account")
          ],
        ),
      ),
    );
  }
  Widget _fullNameField(BuildContext context){
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
        
         hintText: "Full Name"
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
   Widget _emailField(BuildContext context){
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
         hintText: "Your Email"
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
  Widget _passwordField(BuildContext context){
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
         hintText: "Your Password"
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
  Widget _signInText(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Do you have account?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14
            ),
          ),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginPage()));
          }, child: const Text("Sign in",style:TextStyle(
            color: Colors.blue
          )))
        ],
      ),
    );
  }
}