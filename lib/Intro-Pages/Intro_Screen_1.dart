import 'package:alumni_management_client/Constant_File.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Intro_screen2.dart';

class Intro_Screen_1 extends StatefulWidget {
  const Intro_Screen_1({super.key});

  @override
  State<Intro_Screen_1> createState() => _Intro_Screen_1State();
}

class _Intro_Screen_1State extends State<Intro_Screen_1> {
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
                  image: AssetImage(INtro1)
                )
              ),
            ),
            SizedBox(height: height/5.17419,),
            Text("Lesson on demand",style: GoogleFonts.nunito(fontSize: width/19.6,fontWeight: FontWeight.w800),),
            SizedBox(height: height/53.466,),
            SizedBox(
                width:width/1.12,
                child: Text(IntroText1,style: GoogleFonts.nunito(fontSize: width/28,fontWeight: FontWeight.w600,color: Introtextcolor),)),
            SizedBox(height: height/22.914,),
            GestureDetector(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) => IntroScreen2(),));
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
                Text("Already  got an account ?",style: GoogleFonts.nunito(fontSize:  width/32.66,fontWeight: FontWeight.w600),),
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
