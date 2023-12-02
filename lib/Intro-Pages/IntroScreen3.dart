

import 'package:alumni_management_client/Authndication_Pages/Login_Screen.dart';
import 'package:alumni_management_client/Constant_File.dart';
import 'package:alumni_management_client/Landing_Screen/Landing_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class IntroScreen3 extends StatefulWidget {
  const IntroScreen3({super.key});

  @override
  State<IntroScreen3> createState() => _IntroScreen3State();
}

class _IntroScreen3State extends State<IntroScreen3> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height/2.864,
              width: width/1.0888,
              decoration: BoxDecoration(

                  image: DecorationImage(
                      image: AssetImage(INtro3)
                  )
              ),
            ),

            SizedBox(height: height/4.86060,),

            Text("Take learning beyond the \nclassroom walls",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(fontSize: width/19.6,fontWeight: FontWeight.w800),),

            SizedBox(height: height/53.466,),

            SizedBox( width:width/1.12,
                child: Text(IntroText3,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(fontSize: width/28,fontWeight: FontWeight.w600,color: Introtextcolor),)),
            SizedBox(height: height/22.914,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn_Screen(),));
              },
              child: Container(
                height: height/17.82222222222222,
                width: width/1.225,
                decoration: BoxDecoration(
                  color: buttoncolor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:  Center(child:
                Text("Let's go",style: GoogleFonts.nunito(fontSize: width/24.5,fontWeight: FontWeight.w800,color: Colors.white),)),

              ),
            ),
            SizedBox(height: height/80.2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already  got an account ?",style: GoogleFonts.nunito(fontSize: width/32.66,fontWeight: FontWeight.w600),),
                Padding(
                  padding:  EdgeInsets.only(left: width/98),
                  child: Text("Login",style: GoogleFonts.nunito(fontSize: width/30.153,fontWeight: FontWeight.w600,color: buttoncolor),),
                ),

              ],
            )


          ],
        ),
      ),
    );
  }
}
