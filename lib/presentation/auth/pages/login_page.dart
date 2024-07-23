import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_app/common/helper/is_dark.dart';
import 'package:spotify_app/core/config/themes/app_color.dart';
import 'package:spotify_app/data/model/auth/sign_in_user.dart';
import 'package:spotify_app/domain/usecases/auth/signin_usecase.dart';
import 'package:spotify_app/presentation/auth/pages/sign_up_page.dart';
import 'package:spotify_app/presentation/home/pages/home.dart';
import 'package:spotify_app/service_located.dart';

import '../../../common/widget/app_bar.dart';
import '../../../common/widget/button/basic_app_button.dart';
import '../../../core/config/assets/app_vector.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});
   final TextEditingController _email = TextEditingController();
   final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVector.logo,
          width: 40,
          height: 40,
        ),
      ),
      bottomNavigationBar: _signInText(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign in",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: context.isDarkMode ? Colors.white : Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "If you need Any Support",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                TextButton(onPressed: () {}, child: Text("Click here"))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _emailField(context),
            const SizedBox(
              height: 20,
            ),
            
            _passwordField(context),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: (){},
                  child: Text(
                  
                  "Recovery Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: context.isDarkMode?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),
                    fontSize: 15
                  ),
                  ),
                ),
              ),
            ),
              const SizedBox(
              height: 20,
            ),
            BasicAppButton(onPressed: () async{
               var result = await sl<SignInUsecase>().call(params: SignInUserReq(
                
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
            }, text: "Login")
          ],
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(hintText: "Email")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(hintText: "Your Password")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Not a member?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          TextButton(onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpPage()));
          }, child: Text("Register Now",style:TextStyle(
            color: Colors.blue
          )))
        ],
      ),
    );
  }
}
