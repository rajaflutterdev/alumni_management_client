import 'package:alumni_management_client/Constant_File.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../Authndication_Pages/Login_Screen.dart';
import '../Language_Page/Language_Page.dart';
import '../Notification_Screen/Notification_screen.dart';
import '../Translator_Module/Translator_Module_Page.dart';
import '../Your_Post_Screen/Your_Post_Screen.dart';

class Profile_Page extends StatefulWidget {
  String ?userName;
  String ?userLoaction;
  String ?userQuvalification;
  String ?userOcupations;
  String ?userImg;
  String? userDocuemtid;
  String? UsersPassedYear;
  String? UsersDepartment;
  String? UsersrollNo;
   Profile_Page({this.userName,this.userLoaction,this.userOcupations, this.userImg,
     this.userDocuemtid, this.userQuvalification,this.UsersDepartment,this.UsersPassedYear,this.UsersrollNo});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {

  @override
  void initState() {

    setState(() {
      addressController.text=widget.userLoaction.toString();
      occupationController.text="Working ${widget.userOcupations.toString()}";
    });

    // TODO: implement initState
    super.initState();
  }


  TextEditingController addressController=TextEditingController();
  TextEditingController occupationController=TextEditingController();

  TextEditingController popupController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [

          Container(
              height: height/3.0,
              width: double.infinity,
              decoration:  BoxDecoration(
                 // color: Color(0xff817DE7),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(profileBakcground)
                  )
              ),
              child: Padding(
                padding:  EdgeInsets.only(top:height/37.8),
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top:height/94.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top:height/50.4,left: width/45,bottom: height/94.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      height: height/8.02,
                                      width: width/3.92,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(width/3.6),
                                          color: Colors.grey.shade300,
                                          image:

                                          DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                            NetworkImage(widget.userImg.toString(),),
                                          )
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                          borderRadius:
                                      BorderRadius.circular(50)),
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(
                                          vertical: height/252,
                                          horizontal: width/120
                                        ),
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.grey.shade200,
                                          child: Icon(Icons.edit,size: width/26.1333,color: Colors.black,),
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(top: height/100.25),
                                  child: Row(
                                    children: [
                                     // Image.asset(crownImg),
                                      Padding(
                                        padding:  EdgeInsets.only(left: width/45),
                                        child: SizedBox(
                                          width: width/3,
                                          child:
                                          KText(
                                            text:widget.userName.toString(),
                                            style: GoogleFonts.nunito(
                                                fontSize: width/23,
                                                color: Colors.white,
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
                                    // Image.asset(crownImg),
                                    Padding(
                                      padding:  EdgeInsets.only(left: width/45),
                                      child: SizedBox(
                                        width: width/3,
                                        child:
                                        KText(
                                          text:"ID: ${widget.UsersrollNo.toString()}",
                                          style: GoogleFonts.nunito(
                                              fontSize: width/23,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              textStyle: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                              )
                                          ),),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50)
                            ),
                            child: Container(
                              height: height/8.4,
                              width: width/1.8,
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.only(
                                 topLeft: Radius.circular(50),
                                 bottomLeft: Radius.circular(50)
                               )
                             ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(top:height/50.4),
                                    child: SizedBox(

                                      width: width/2.25,
                                      child: Row(

                                        children: [
                                          Image.asset(Bookmark),
                                          Padding(
                                            padding:  EdgeInsets.only(left: width/45),
                                            child: KText(
                                              text:widget.UsersPassedYear.toString(),
                                              style: GoogleFonts.nunito(
                                                  fontSize: width/28,
                                                  fontWeight: FontWeight.w800,
                                                  color: buttoncolor,
                                                  textStyle: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                  )
                                              ),),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding:  EdgeInsets.only(bottom:height/50.4),
                                    child: SizedBox(
                                      width: width/2.25,

                                      child: Row(

                                        children: [
                                        Image.asset(Graduate),
                                          Padding(
                                            padding:  EdgeInsets.only(left: width/45),
                                            child: KText(
                                              text:widget.UsersDepartment.toString(),
                                              style: GoogleFonts.nunito(
                                                  fontSize: width/28,
                                                  fontWeight: FontWeight.w800,
                                                  color: buttoncolor,
                                                  textStyle: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                  )
                                              ),),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              )),

          Padding(
            padding:  EdgeInsets.only(top: height/37.8),
            child: Material(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade200,
              elevation: 1,
              child: Container(
                height: height/9.45,
                width: width/1.0588,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade200
              ),
                child: Padding(
                  padding:  EdgeInsets.only(top: height/126,bottom: height/126,left: width/45,right: width/45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KText(text: "You are currently living in  ",
                          style: GoogleFonts.nunito(
                            color: Colors.grey
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width/1.5,
                            height: height/15.75,
                            child:TextField(
                              style: GoogleFonts.nunito(
                                  color: Colors.black
                              ),
                              controller: addressController,
                              decoration: InputDecoration(
                                border: InputBorder.none
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              contentChangePopup(
                                contentController: addressController.text,
                                contentName: "Address"
                              );
                            },
                            child: SizedBox(
                              height: height/16.8,
                              width: width/4.5,
                              child:Center(
                                child: KText(
                                  text: "Change",
                                  style: GoogleFonts.nunito(
                                    color: buttoncolor,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ) ,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding:  EdgeInsets.only(top: height/37.8),
            child: Material(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade200,
              elevation: 1,
              child: Container(
                height: height/9.45,
                width: width/1.0588,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade200
                ),
                child: Padding(
                  padding:  EdgeInsets.only(top: height/126,bottom: height/126,left: width/45,right: width/45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KText(text: "Your Carrier ",
                          style: GoogleFonts.nunito(
                              color: Colors.grey
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width/1.5,
                            height: height/15.75,
                            child:TextField(
                              style: GoogleFonts.nunito(
                                  color: Colors.black
                              ),
                              controller: occupationController,
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              contentChangePopup(
                                  contentController: occupationController.text,
                                  contentName: "Carrier"
                              );
                            },
                            child: SizedBox(
                              height: height/16.8,
                              width: width/4.5,
                              child:Center(
                                child: KText(
                                  text: "Change",
                                  style: GoogleFonts.nunito(
                                      color: buttoncolor,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ) ,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(
                left: width / 90,
                right: width / 90,
                top: height / 930),
            height: height / 3.3,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              /*borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: 1.0,

                    offset: Offset(0, 0.5),
                    color: Colors.black12,
                    blurRadius: 2.0,

                  ),

                ]*/
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>Your_Post_Screen(),));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width / 25, right: width / 45,
                        top: height / 94.5, bottom: height / 94.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Icon(Icons.person,
                                color: TextColor,
                                size: width/18,),
                              SizedBox(width: width / 22,),

                              KText(text:"Your Job Posts",
                                style: GoogleFonts.nunito(
                                    color: TextColor,
                                    fontSize:width/25.69,
                                    fontWeight: FontWeight.w500

                                ),),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.black,
                          size: width/18,),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Notification_screen(),));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width / 25, right: width / 45,
                        top: height / 94.5, bottom: height / 94.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Icon(
                                Icons.notifications, color: Colors.black,
                                size: width/18,),

                              SizedBox(width: width / 22,),

                              KText(
                                text:
                                "Notifications", style: GoogleFonts.nunito(
                                  color: TextColor,
                                  fontSize:width/25.69,
                                  fontWeight: FontWeight.w500

                              ),),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.black,
                          size: width/18,),

                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>Languages_Page() ,));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width / 25, right: width / 45,
                        top: height / 94.5, bottom: height / 94.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width/1.8,
                          child: Row(
                            children: [
                              Icon(Icons.translate_rounded, color: Colors.black,
                                size: width/18,),
                              SizedBox(width: width / 22,),

                              KText(text: "Language", style: GoogleFonts.nunito(
                                  color: TextColor,
                                  fontSize:width/25.69,
                                  fontWeight: FontWeight.w500

                              ),),
                            ],
                          ),
                        ),
                        KText(text:languaeName, style: GoogleFonts.nunito(
                            color: buttoncolor,
                            fontSize:width/25.69,
                            fontWeight: FontWeight.w800

                        ),),
                        Icon(Icons.arrow_forward_ios, color: Colors.black,
                          size: width/18,),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){

                    siginoutpopup();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width / 25, right: width / 45,
                        top: height / 94.5, bottom: height / 94.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Icon(Icons.settings_power_rounded,  color: TextColor,
                                size: width/18,),
                              SizedBox(width: width / 22,),

                              KText(text: "Logout", style: GoogleFonts.nunito(
                                  color: TextColor,
                                  fontSize:width/25.69,
                                  fontWeight: FontWeight.w500

                              ),),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.black,
                          size: width/18,),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),

          /*Container(
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
          ),*/




        ],
      ),
    );
  }

  Future<void> siginoutpopup() async {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding:  EdgeInsets.only(top:height/50.4),
            child: KText(
              text:"Are You Want To Logout",
              align:  TextAlign.center,
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: width / 23,
              ),
            ),
          ),
          content: SizedBox(
            height: height / 3.8,
            child: Column(
              children: [
                Container(
                    height: height/5.2,
                    color:Colors.transparent,
                    child:Lottie.asset(LogOutLottie)),
                Padding(
                  padding: EdgeInsets.only(left: width / 45,top:height/86.6),
                  child: GestureDetector(
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LogIn_Screen(),));
                    },
                    child: Container(

                      height: height/24.0,
                      width: width/5.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: buttoncolor,
                      ),
                      child: Center(
                        child: KText(
                          text: "Yes",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width / 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          titlePadding: EdgeInsets.symmetric(
              horizontal: width / 45, vertical: height / 94.5),
        );
      },
    );
  }


  ///address change Popup

  contentChangePopup({contentName, contentController}){
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    setState(() {
      popupController.text=contentController.toString();
    });
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: KText(text: contentName,style: GoogleFonts.nunito(
          fontWeight: FontWeight.w800,color: TextColor
        ),),
        content: SizedBox(
          width: width/1.0588,
          height: height/3.024,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Container(
                height: height/3.78,
                width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.grey
                )
              ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextField(
                    controller: popupController,
                    maxLines: null,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500,
                      color: TextColor
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(contentName=="Carrier"){
                        print("111111111111");
                        print(widget.userDocuemtid);
                        FirebaseFirestore.instance.collection('Users').doc(widget.userDocuemtid).update({
                          "Occupation":popupController.text,
                        });
                        setState(() {
                          occupationController.text="${popupController.text.toString()}";
                        });
                        Navigator.pop(context);

                      }
                      else{
                        print("222222222222");
                        FirebaseFirestore.instance.collection('Users').doc(widget.userDocuemtid).update({
                          "Address":popupController.text,
                        });
                        setState(() {
                          addressController.text=popupController.text.toString();
                        });
                        Navigator.pop(context);
                      }

                    },
                    child: Container(

                      height: height/22.0,
                      width: width/5.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: buttoncolor,
                      ),
                      child: Center(
                        child: KText(
                          text: "Submit",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width / 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height/22.0,
                      width: width/5.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: buttoncolor,
                      ),
                      child: Center(
                        child: KText(
                          text: "Cancel",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width / 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),

      );
    },);
  }


}
