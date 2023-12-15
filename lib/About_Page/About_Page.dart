import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Translator_Module/Translator_Module_Page.dart';

class About_Page extends StatefulWidget {
  const About_Page({super.key});

  @override
  State<About_Page> createState() => _About_PageState();
}

class _About_PageState extends State<About_Page> {
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
                       text:"Abouts",style: GoogleFonts.nunito(
                         fontSize: width/19.6,
                         fontWeight: FontWeight.w700),),

                     // Material(
                     //   elevation: 5,
                     //   borderRadius: BorderRadius.circular(5),
                     //   color: buttoncolor,
                     //   child: Container(
                     //     height: height/20.05,
                     //     width: width/9.8,
                     //     decoration: BoxDecoration(
                     //       borderRadius: BorderRadius.circular(5),
                     //       color: buttoncolor,
                     //     ),
                     //     child: Icon(Icons.settings,color: Colors.white,),
                     //   ),
                     // )
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
