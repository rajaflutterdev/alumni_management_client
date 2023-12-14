import 'dart:math';

import 'package:alumni_management_client/Translator_Module/Translator_Module_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../Authndication_Pages/Login_Screen.dart';
import '../Constant_File.dart';
import '../Home_Screen/Home_Screen.dart';
import '../Menbers_Screen/Member_Screen.dart';
import '../Message_Screen/Message_Screen.dart';
import '../Profile_Page/Profile_Page.dart';


class Landing_Screen extends StatefulWidget {
  String?userDocumentID;
   Landing_Screen({this.userDocumentID});

  @override
  State<Landing_Screen> createState() => _Landing_ScreenState();
}

class _Landing_ScreenState extends State<Landing_Screen> with SingleTickerProviderStateMixin {

  int bottomItemValue=0;
  String Username="";
  String Userloaction="";
  String Userqulification="";
  String Useroccupation="";
  String UserImg="";
  String UsersDepartment="";
  String UsersPassedYear="";
  double lat = 0.0;
  double lon = 0.0;
  @override
  void initState() {
    UserGetDataFuntion();
    getLatLng();
    // TODO: implement initState
    super.initState();
  }
  
  
  
  
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
      body:

      SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(left: width/39.2,right: width/39.2),
          child:SingleChildScrollView(
              physics: ScrollPhysics(),
              child:
              bottomItemValue==0?
              Home_Screen(Username: Username,):
              bottomItemValue==1?
               Member_Screen(
                userLatitude: lat,
                userLongtitude: lon,
              ):
              bottomItemValue==2?
               Message_Screen(
                UserDepartment: UsersDepartment,
                UserPassedYear: UsersPassedYear,
              )
              :Profile_Page(
                userName: Username,
                userLoaction: Userloaction,
                userOcupations: Useroccupation,
                userQuvalification: Userqulification,
                userDocuemtid: FirebaseAuth.instance.currentUser!.uid,
                 userImg: UserImg,
              ),
          )

        ),
      ),
      bottomNavigationBar: Container(
        height: height/13.3666,
        color: Colors.white,
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){
                print(height);
                print(width);
                setState(() {
                  bottomItemValue=0;
                });
              },
              child: Column(
                children: [
                  Image.asset(homeImg,color:bottomItemValue==0?
                  bottomItemSlectedColor:bottomItemUnSlectedColor,),
                  KText(
                    text:
                    "Home",style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    color: bottomItemValue==0?
                    bottomItemSlectedColor:bottomItemUnSlectedColor
                  ),)
                ],
              ),
            ),

            GestureDetector(
              onTap: (){
                setState(() {
                  bottomItemValue=1;
                });
              },
              child: Column(
                children: [
                  Image.asset(openBookImg,color:bottomItemValue==1?
                  bottomItemSlectedColor:bottomItemUnSlectedColor,),
                  KText(
                    text:"Member",style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      color: bottomItemValue==1?
                      bottomItemSlectedColor:bottomItemUnSlectedColor
                  ),)
                ],
              ),
            ),

            GestureDetector(
              onTap: (){
                setState(() {
                  bottomItemValue=2;
                });
              },
              child: Column(
                children: [
                  Image.asset(bookIMg,color:bottomItemValue==2?
                  bottomItemSlectedColor:bottomItemUnSlectedColor,),
                  KText(
                    text:"Messages",style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      color: bottomItemValue==2?

                      bottomItemSlectedColor:bottomItemUnSlectedColor
                  ),)
                ],
              ),
            ),

            GestureDetector(
              onTap: (){
                setState(() {
                  bottomItemValue=3;
                });
              },
              child: Column(
                children: [
                  Image.asset(userImg,color:bottomItemValue==3?
                  bottomItemSlectedColor:bottomItemUnSlectedColor,),
                  KText(
                    text:"Me",style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      color: bottomItemValue==3?

                      bottomItemSlectedColor:bottomItemUnSlectedColor
                  ),)
                ],
              ),
            ),

          ],
        )
      ),
    );
  }

  UserGetDataFuntion()async{
    print(widget.userDocumentID);
    print("Enter+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    var Userdata=await FirebaseFirestore.instance.collection('Users').
    where("userDocId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude!;
      lon = position.longitude!;
    });
   if(Userdata.docs.length>0){
     setState(() {
       Username = Userdata.docs[0]["Name"].toString();
       Userloaction = Userdata.docs[0]["Address"].toString();
       Userqulification = Userdata.docs[0]["educationquvalification"].toString();
       Useroccupation = Userdata.docs[0]["Occupation"].toString();
       UsersDepartment = Userdata.docs[0]["subjectStream"].toString();
       UsersPassedYear = Userdata.docs[0]["yearofpassed"].toString();
       UserImg =Userdata.docs[0]["UserImg"].toString()==""?AvatorImg: Userdata.docs[0]["UserImg"].toString();
     });

     FirebaseFirestore.instance.collection('Users').doc(Userdata.docs[0].id).update({
       "latitude":lat,
       "longtitude":lon
     });

     print(Username);
     print(Userloaction);
     print(Userqulification);
     print(Useroccupation);
     print(UserImg);

     print("departmentsssssssssssssssssssssssssssssssssssssssssssssssssssssss");
     print(UsersDepartment);
     print(UsersPassedYear);
     print("Printing the Users Detailsssssssssssssssssssssssssssssssssssssssss");
   }
  }


  getLatLng() async {



    print("Longtitude_____________________________________$lon");
    print("Lattttitude_____________________________________$lat");
  }





}




