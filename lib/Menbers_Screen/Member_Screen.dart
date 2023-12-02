import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Translator_Module/Translator_Module_Page.dart';

class Member_Screen extends StatefulWidget {
  const Member_Screen({super.key});

  @override
  State<Member_Screen> createState() => _Member_ScreenState();
}

class _Member_ScreenState extends State<Member_Screen> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(top: height/40.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KText(
                text:"Members",style: GoogleFonts.nunito(
                  fontSize: width/19.6,
                  fontWeight: FontWeight.w700),),


            ],
          ),
        ),
      ],
    );
  }
}
