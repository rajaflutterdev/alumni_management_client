import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  String UsersDocID="";
  String UsersrollNo="";
  double lat = 0.0;
  double lon = 0.0;
  @override
  void initState() {
    UserGetDataFuntion();
    // TODO: implement initState
    super.initState();
  }
  
  
  PageController controller =PageController(initialPage: 0,keepPage: true);

  
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    List Pages=[

      Home_Screen(Username: Username,UserAuthID: UsersDocID),

      Member_Screen(
        userLatitude: lat,
        userLongtitude: lon,
        userImage:UserImg,
        userName: Username,
          UsersrollNo:UsersrollNo
      ),
      Message_Screen(
        UserPassedYear: UsersPassedYear,
        UserDepartment: UsersDepartment,

      ),
      Profile_Page(
        userName: Username,
        userLoaction: Userloaction,
        userOcupations: Useroccupation,
        userQuvalification: Userqulification,
        userDocuemtid: UsersDocID,
        userImg: UserImg,
        UsersDepartment: UsersDepartment,
        UsersPassedYear: UsersPassedYear,
          UsersrollNo:UsersrollNo
      ),
    ];



    return Scaffold(
      body:
      //padding:  EdgeInsets.only(left: width/39.2,right: width/39.2),
      SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Pages[bottomItemValue],
        )
      ),
      bottomNavigationBar: Container(
        height: height/11.4,
        color: Colors.white,
        child:BottomBarDivider(
          animated: true,
         styleDivider: StyleDivider.all,
         duration: const Duration(milliseconds: 400),
         curve: Curves.easeIn,
         // visitHighlight: bottomItemValue,
          items: const [
           TabItem(
             icon: Icons.home,
             title: 'Home',
           ),
            TabItem(
              icon: Icons.location_on,
              title: "Near By"

            ),
            TabItem(
              icon: Icons.mail_outlined,
              title: "Messages"
            ),
            TabItem(
              icon: Icons.person,
              title: 'Me',
            ),

          ],
          backgroundColor: Colors.white,
          color: bottomItemUnSlectedColor,
          indexSelected: bottomItemValue,
         // backgroundSelected: buttoncolor,
          enableShadow: true,
          onTap: (int value){
         setState(() {
           bottomItemValue=value;
         });
         print(bottomItemValue);
         print("++++++++++++++++++++++++++++++++++");
          },

          colorSelected: bottomItemSlectedColor,
        ),
      /*  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  bottomItemValue=0;
                });
                controller.animateToPage(bottomItemValue, duration: Duration(milliseconds: 300), curve: Curves.linear);

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
                controller.animateToPage(bottomItemValue, duration: Duration(milliseconds: 300), curve: Curves.linear);
              },
              child: Column(
                children: [

                  Icon(Icons.location_on_sharp,color:bottomItemValue==1?
                  bottomItemSlectedColor:bottomItemUnSlectedColor),
                  // Image.asset(openBookImg,color:bottomItemValue==1?
                  // bottomItemSlectedColor:bottomItemUnSlectedColor,),
                  KText(
                    text:"Near By",style: GoogleFonts.nunito(
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
                controller.animateToPage(bottomItemValue, duration: Duration(milliseconds: 300), curve: Curves.linear);
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
                controller.animateToPage(bottomItemValue, duration: Duration(milliseconds: 300), curve: Curves.linear);
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
        )*/
      ),
    );
  }

  UserGetDataFuntion()async{
    print(widget.userDocumentID);
    print("Enter+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    var Userdata=await FirebaseFirestore.instance.collection('Users').
    where("userDocId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();

   if(Userdata.docs.length>0){
     setState(() {
       Username = Userdata.docs[0]["Name"].toString();
       UsersDocID=Userdata.docs[0].id;
       Userloaction = Userdata.docs[0]["Address"].toString();
       Userqulification = Userdata.docs[0]["educationquvalification"].toString();
       Useroccupation = Userdata.docs[0]["Occupation"].toString();
       UsersDepartment = Userdata.docs[0]["subjectStream"].toString();
       UsersPassedYear = Userdata.docs[0]["yearofpassed"].toString();
       UsersrollNo = Userdata.docs[0]["rollNo"].toString();
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

   print("User Docuemnt Documen ID-----------------------------------------");
   print(UsersDocID);
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude!;
      lon = position.longitude!;
    });
  }



}




