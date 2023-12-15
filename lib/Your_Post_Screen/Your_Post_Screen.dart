import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Translator_Module/Translator_Module_Page.dart';

class Your_Post_Screen extends StatefulWidget {
  const Your_Post_Screen({super.key});

  @override
  State<Your_Post_Screen> createState() => _Your_Post_ScreenState();
}

class _Your_Post_ScreenState extends State<Your_Post_Screen> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return
      Scaffold(
        body:  Padding(
          padding:  EdgeInsets.only(left: width/39.2,right: width/39.2),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [

                Padding(
                  padding:  EdgeInsets.only(top: height/20.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KText(
                        text:" Your Job Post",style: GoogleFonts.nunito(
                          fontSize: width/19.6,
                          fontWeight: FontWeight.w700),),


                    ],
                  ),
                ),

                SizedBox(height: height/53.466,),
              ],
            ),
          ),
        ),
      );
  }
}
