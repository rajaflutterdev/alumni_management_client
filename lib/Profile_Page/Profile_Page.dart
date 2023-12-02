import 'package:alumni_management_client/Constant_File.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Translator_Module/Translator_Module_Page.dart';

class Profile_Page extends StatefulWidget {
  String ?userName;
  String ?userLoaction;
  String ?userQuvalification;
  String ?userOcupations;
  String ?userImg;
  String? userDocuemtid;
   Profile_Page({this.userName,this.userLoaction,this.userOcupations,
     this.userImg,this.userDocuemtid,
     this.userQuvalification});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Column(
      children: [

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: height/8.02,
                      width: width/3.92,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.shade300,
                        image: 

                        DecorationImage(
                          fit: BoxFit.cover,
                          image:
                          NetworkImage(widget.userImg.toString()),
                        )
                      ),

                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: buttoncolor,
                      child: Icon(Icons.edit,size: width/26.1333,color: Colors.white,),
                    )
                  ],
                ),

                Padding(
                  padding:  EdgeInsets.only(top: height/100.25),
                  child: Row(
                    children: [
                      Image.asset(crownImg),
                      Padding(
                        padding:  EdgeInsets.only(left: width/49),
                        child: SizedBox(
                          width: width/1.568,
                          child:  KText(
                            text:widget.userName.toString(),
                            style: GoogleFonts.nunito(
                                fontSize: width/28,
                                fontWeight: FontWeight.w700,
                                textStyle: TextStyle(
                                   overflow: TextOverflow.ellipsis,
                                )
                            ),),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                  Icon(Icons.location_on_outlined,color: titleProfileColor,),
                    Padding(
                      padding:  EdgeInsets.only(left: width/49),
                      child: SizedBox(
                        width: width/1.568,
                        child:  KText(
                          text:widget.userLoaction.toString(),
                          style: GoogleFonts.nunito(
                               fontSize: width/28,
                              fontWeight: FontWeight.w700,
                              textStyle: TextStyle(
                                //overflow: TextOverflow.ellipsis,
                              )
                          ),),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Image.asset(bookIMg),
                    Padding(
                      padding:  EdgeInsets.only(left: width/49),
                      child: SizedBox(
                        width: width/1.568,
                        child:  KText(
                          text:widget.userQuvalification.toString(),
                          style: GoogleFonts.nunito(
                               fontSize: width/28,
                              fontWeight: FontWeight.w700,
                              textStyle: TextStyle(
                               // overflow: TextOverflow.ellipsis,
                              )
                          ),),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Image.asset(openBookImg,color: titleProfileColor,),
                    Padding(
                      padding:  EdgeInsets.only(left:width/49),
                      child: SizedBox(
                        width: width/1.568,
                        child:  KText(
                          text:widget.userOcupations.toString(),
                          style: GoogleFonts.nunito(
                               fontSize: width/28,
                              fontWeight: FontWeight.w700,
                              textStyle: TextStyle(
                               // overflow: TextOverflow.ellipsis,
                              )
                          ),),
                      ),
                    ),
                  ],
                ),

              ],
            ),
            // Icon(Icons.settings)
          ],
        ),
        Container(
          height: height/11.457,
          width: double.infinity,
          decoration: BoxDecoration(
            color: TraialProfileColor
          ),
          margin: EdgeInsets.only(top: height/53.466),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                SizedBox(
                  height: height/16.04,
                  width: width/1.4,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KText(
                          text:"Treat your friends ",
                          style: GoogleFonts.nunito(
                              fontSize: width/28,
                              fontWeight: FontWeight.w700,
                              textStyle: TextStyle(
                                overflow: TextOverflow.ellipsis,
                              )
                          ),),
                        KText(
                          text:"Give them a 30-day guest pass.",
                          style: GoogleFonts.nunito(
                              fontSize: width/28,
                              fontWeight: FontWeight.w700,
                              textStyle: TextStyle(
                                overflow: TextOverflow.ellipsis,
                              )
                          ),),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.clear,color: Colors.white,)
              ],
            ),
          ),
        )
      ],
    );
  }
}
