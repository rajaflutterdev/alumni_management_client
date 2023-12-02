import 'package:alumni_management_client/Constant_File.dart';
import 'package:alumni_management_client/Landing_Screen/Landing_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Intro-Pages/Intro_Screen_1.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {

  @override
  void initState() {
    print("Splash Screeen++++++++++++++++++++++++++++++++++++");


    Future.delayed(Duration(seconds: 5),(){
      if(FirebaseAuth.instance.currentUser==null){
        print("Authendiction success");
        Get.offAll(Intro_Screen_1(),
            transition: Transition.zoom,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn
        );
      }
      else{
        print("faild");
      Get.offAll(Landing_Screen(),
      transition: Transition.zoom,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn
      );
      }


    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: buttoncolor,
      child: Image.asset(SplashScreenImg),
    );
  }
}
