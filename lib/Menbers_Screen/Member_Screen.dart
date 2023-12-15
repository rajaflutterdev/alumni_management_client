import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import 'package:animate_do/animate_do.dart';
import '../Constant_File.dart';
import '../Message_Screen/Message_ViewDetails_Page.dart';
import '../Translator_Module/Translator_Module_Page.dart';

class Member_Screen extends StatefulWidget {
  double? userLatitude;
  double? userLongtitude;
  String? userImage;
  String? userName;
  String? UsersrollNo;

  Member_Screen(
      {this.userLatitude, this.userLongtitude, this.userName, this.userImage,this.UsersrollNo});

  @override
  State<Member_Screen> createState() => _Member_ScreenState();
}

class _Member_ScreenState extends State<Member_Screen> {
  int value = 0;

  @override
  void initState() {
    getNearByUseravailablefunc();
    // TODO: implement initState
    super.initState();
  }

  List<NearByMember> nearMemberList = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.only(left: width/39.2,right: width/39.2),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.only(top: height / 40.1, bottom: height / 40.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KText(
                    text: "Near By",
                    style: GoogleFonts.nunito(
                        fontSize: width / 19.6, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),

            Container(
              height: height/1.89,
              width: double.infinity,
              color: Colors.transparent,
              child: Stack(
                children: [


                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RippleAnimation(
                          color: buttoncolor,
                          delay: const Duration(milliseconds: 900),
                          repeat: true,
                          minRadius: 100,
                          ripplesCount: 10,
                          duration: const Duration(milliseconds:6*1000),
                          child: CircleAvatar(
                            minRadius: 50,
                            maxRadius: 50,
                            backgroundImage: NetworkImage(
                                widget.userImage.toString() == ""
                                    ? AvatorImg
                                    : widget.userImage.toString()),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top:height/81.375),
                          child: Text(
                            widget.userName.toString(),
                            style: GoogleFonts.nunito(
                                fontSize: width / 20.5,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          widget.UsersrollNo.toString(),
                          style: GoogleFonts.nunito(
                              fontSize: width / 32.5,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),

                  ///Member -1
                  nearMemberList.length > 0
                      ? GestureDetector(
                        onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Message_ViewDetails_Page(
                        userDocid: nearMemberList[0].memberDocumentID.toString(),
                        userBatch: nearMemberList[0].memberPassedOutYear.toString(),
                        userdepartment: nearMemberList[0].memberClass.toString(),
                        userName: nearMemberList[0].membername.toString(),
                        userToken: nearMemberList[0].memberToken.toString(),
                        userProfile: nearMemberList[0].memberNetworkImg.toString() == "" ? AvatorImg.toString() : nearMemberList[0].memberNetworkImg.toString(),
                      ),));
                    },
                        child: ZoomIn(
                                        animate: true,
                          duration: const Duration(seconds: 2),
                          child: Visibility(
                              visible: (nearMemberList.length - 1) >= 0,
                              child: Padding(
                                padding:  EdgeInsets.only(top: height/75.6, left: width/12),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(color: buttoncolor,),
                                        borderRadius: BorderRadius.circular(width/13.66)

                                      ),
                                      child: CircleAvatar(
                                        minRadius: 25,
                                        maxRadius: 25,
                                        backgroundImage: NetworkImage(nearMemberList[0]
                                            .memberNetworkImg
                                            .toString()),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height/378,
                                          horizontal: width/180
                                      ),
                                      child:
                                      Text(
                                        nearMemberList[0].membername.toString(),
                                        style: GoogleFonts.nunito(
                                            fontSize: width / 26.5,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Text(
                                      "${nearMemberList[0].Distance.toString()} Km",
                                      style: GoogleFonts.nunito(
                                          fontSize: width / 28.5,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ),
                      )
                      : const SizedBox(),

                  ///Member -2
                  nearMemberList.length > 1
                      ? GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Message_ViewDetails_Page(
                        userDocid: nearMemberList[1].memberDocumentID.toString(),
                        userBatch: nearMemberList[1].memberPassedOutYear.toString(),
                        userdepartment: nearMemberList[1].memberClass.toString(),
                        userName: nearMemberList[1].membername.toString(),
                        userToken: nearMemberList[1].memberToken.toString(),
                        userProfile: nearMemberList[1].memberNetworkImg.toString() == "" ? AvatorImg.toString() : nearMemberList[1].memberNetworkImg.toString(),
                      ),));
                    },
                    child: ZoomIn(
                           animate: true,
                           duration: const Duration(seconds: 4),
                          child: Visibility(
                              visible: (nearMemberList.length - 2) >= 0,
                              child: Padding(
                                padding: EdgeInsets.only(left: width/1.5, top: height/18.9),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(color: buttoncolor,),
                                          borderRadius: BorderRadius.circular(width/13.66)

                                      ),
                                      child: CircleAvatar(
                                        minRadius: 25,
                                        maxRadius: 25,
                                        backgroundImage: NetworkImage(nearMemberList[1]
                                            .memberNetworkImg
                                            .toString()),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height/378,
                                          horizontal: width/180
                                      ),
                                      child: Text(
                                        nearMemberList[1].membername.toString(),
                                        style: GoogleFonts.nunito(
                                            fontSize: width / 26.5,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Text(
                                      "${nearMemberList[1].Distance.toString()} Km",
                                      style: GoogleFonts.nunito(
                                          fontSize: width / 28.5,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ),
                      )
                      : const SizedBox(),

                  ///Member -3
                  nearMemberList.length > 2
                      ? GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Message_ViewDetails_Page(
                        userDocid: nearMemberList[2].memberDocumentID.toString(),
                        userBatch: nearMemberList[2].memberPassedOutYear.toString(),
                        userdepartment: nearMemberList[2].memberClass.toString(),
                        userName: nearMemberList[2].membername.toString(),
                        userToken: nearMemberList[2].memberToken.toString(),
                        userProfile: nearMemberList[2].memberNetworkImg.toString() == "" ? AvatorImg.toString() : nearMemberList[2].memberNetworkImg.toString(),
                      ),));
                    },
                    child: ZoomIn(
                                        animate: true,
                                        duration: const Duration(seconds: 3),
                                        child: Visibility(
                              visible: (nearMemberList.length - 3) >= 0,
                              child: Padding(
                                padding:  EdgeInsets.only(top: height/5.4, left: width/12),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(color: buttoncolor,),
                                          borderRadius: BorderRadius.circular(width/13.66)

                                      ),
                                      child: CircleAvatar(
                                        minRadius: 25,
                                        maxRadius: 25,
                                        backgroundImage: NetworkImage(nearMemberList[2]
                                            .memberNetworkImg
                                            .toString()),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height/378,
                                          horizontal: width/180
                                      ),
                                      child: Text(
                                        nearMemberList[2].membername.toString(),
                                        style: GoogleFonts.nunito(
                                            fontSize: width / 26.5,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Text(
                                      "${nearMemberList[2].Distance.toString()} Km",
                                      style: GoogleFonts.nunito(
                                          fontSize: width / 28.5,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ),
                      )
                      : const SizedBox(),

                  ///Member -4
                  nearMemberList.length > 3
                      ? GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Message_ViewDetails_Page(
                        userDocid: nearMemberList[3].memberDocumentID.toString(),
                        userBatch: nearMemberList[3].memberPassedOutYear.toString(),
                        userdepartment: nearMemberList[3].memberClass.toString(),
                        userName: nearMemberList[3].membername.toString(),
                        userToken: nearMemberList[3].memberToken.toString(),
                        userProfile: nearMemberList[3].memberNetworkImg.toString() == "" ? AvatorImg.toString() : nearMemberList[3].memberNetworkImg.toString(),
                      ),));
                    },
                    child: ZoomIn(
                           animate: true,
                           duration: const Duration(seconds: 5),
                          child: Visibility(
                              visible: (nearMemberList.length - 4) >= 0,
                              child: Padding(
                                padding:  EdgeInsets.only(top: height/3.9789, left: width/1.384615),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(color: buttoncolor,),
                                          borderRadius: BorderRadius.circular(width/13.66)

                                      ),
                                      child: CircleAvatar(
                                        minRadius: 25,
                                        maxRadius: 25,
                                        backgroundImage: NetworkImage(nearMemberList[3]
                                            .memberNetworkImg
                                            .toString()),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height/378,
                                          horizontal: width/180
                                      ),
                                      child: Text(
                                        nearMemberList[3].membername.toString(),
                                        style: GoogleFonts.nunito(
                                            fontSize: width / 26.5,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Text(
                                      "${nearMemberList[3].Distance.toString()} Km",
                                      style: GoogleFonts.nunito(
                                          fontSize: width / 28.5,
                                          fontWeight: FontWeight.w600),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                        ),
                      )
                      : const SizedBox(),

                  ///Member -5
                  nearMemberList.length > 4
                      ? GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Message_ViewDetails_Page(
                        userDocid: nearMemberList[4].memberDocumentID.toString(),
                        userBatch: nearMemberList[4].memberPassedOutYear.toString(),
                        userdepartment: nearMemberList[4].memberClass.toString(),
                        userName: nearMemberList[4].membername.toString(),
                        userToken: nearMemberList[4].memberToken.toString(),
                        userProfile: nearMemberList[4].memberNetworkImg.toString() == "" ? AvatorImg.toString() : nearMemberList[4].memberNetworkImg.toString(),
                      ),));
                    },
                    child: ZoomIn(
                                        animate: true,
                                        duration: const Duration(seconds: 2),
                                        child: Visibility(
                              visible: (nearMemberList.length - 5) >= 0,
                              child: Padding(
                                padding:  EdgeInsets.only(top: height/2.8, left: width/4.5),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(color: buttoncolor,),
                                          borderRadius: BorderRadius.circular(width/13.66)

                                      ),
                                      child: CircleAvatar(
                                        minRadius: 25,
                                        maxRadius: 25,
                                        backgroundImage: NetworkImage(nearMemberList[4]
                                            .memberNetworkImg
                                            .toString()),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height/378,
                                          horizontal: width/180
                                      ),
                                      child: Text(
                                        nearMemberList[4].membername.toString(),
                                        style: GoogleFonts.nunito(
                                            fontSize: width / 26.5,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Text(
                                      "${nearMemberList[4].Distance.toString()} Km",
                                      style: GoogleFonts.nunito(
                                          fontSize: width / 28.5,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ),)
                      : const SizedBox(),

                     ///Member -6
                      nearMemberList.length > 5
                      ? GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Message_ViewDetails_Page(
                        userDocid: nearMemberList[5].memberDocumentID.toString(),
                        userBatch: nearMemberList[5].memberPassedOutYear.toString(),
                        userdepartment: nearMemberList[5].memberClass.toString(),
                        userName: nearMemberList[5].membername.toString(),
                        userToken: nearMemberList[5].memberToken.toString(),
                        userProfile: nearMemberList[5].memberNetworkImg.toString() == "" ? AvatorImg.toString() : nearMemberList[5].memberNetworkImg.toString(),
                      ),));
                    },
                    child: ZoomIn(
                                        animate: true,
                                        duration: const Duration(seconds: 1),
                                        child: Visibility(
                              visible: (nearMemberList.length - 6) >= 0,
                              child: Padding(
                                padding:  EdgeInsets.only(top: height/2.3625, left: width/1.44),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(color: buttoncolor,),
                                          borderRadius: BorderRadius.circular(width/13.66)

                                      ),
                                      child: CircleAvatar(
                                        minRadius: 25,
                                        maxRadius: 25,
                                        backgroundImage: NetworkImage(nearMemberList[5]
                                            .memberNetworkImg
                                            .toString()),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: height/378,
                                        horizontal: width/180
                                      ),
                                      child: Text(
                                        nearMemberList[5].membername.toString(),
                                        style: GoogleFonts.nunito(
                                            fontSize: width / 26.5,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Text(
                                      "${nearMemberList[5].Distance.toString()} Km",
                                      style: GoogleFonts.nunito(
                                          fontSize: width / 28.5,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ),
                      )
                      : const SizedBox(),
                ],
              ),
            ),

            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: width/45,
                    vertical: height/94.5
                  ),
                  child: Text(
                    "Near By Alumni",
                    style: GoogleFonts.nunito(
                        fontSize: width / 20.5, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),

            ListView.builder(
              shrinkWrap: true,
              itemCount: nearMemberList.length,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                var memberData = nearMemberList[index];

                return Material(
                  elevation: 3,
                  color: Colors.grey[50],
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Message_ViewDetails_Page(
                        userDocid: nearMemberList[index].memberDocumentID.toString(),
                        userBatch: nearMemberList[index].memberPassedOutYear.toString(),
                        userdepartment: nearMemberList[index].memberClass.toString(),
                        userName: nearMemberList[index].membername.toString(),
                        userToken: nearMemberList[index].memberToken.toString(),
                        userProfile: nearMemberList[index].memberNetworkImg.toString() == "" ? AvatorImg.toString() : nearMemberList[index].memberNetworkImg.toString(),
                      ),));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(memberData.memberNetworkImg.toString()),
                    ),
                    title: KText(
                      text: memberData.membername.toString(),
                      style: GoogleFonts.nunito(color: Colors.black),
                    ),
                    subtitle: KText(
                      text: "Near By in : ${memberData.Distance.toString()} KM",
                      style: GoogleFonts.nunito(color: Colors.black),
                    ),
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }

  getDistance({memberlatitude, memberlongtitude}) {
    var p = 0.017453292519943295;
    var c = cos;

    ///another person latitude-current user latitude
    var a = 0.5 -
        c((memberlatitude - widget.userLatitude!.toDouble()) * p) / 2 +

        ///(current User latitude*P) * (another person latitude *P)
        c(widget.userLatitude!.toDouble() * p) *
            c(memberlatitude * p) *

            ///another person longtitude -current Usesr Longtitude
            (1 -
                c((memberlongtitude - widget.userLongtitude!.toDouble()) * p)) /
            2;

    return ((12742 * asin(sqrt(a)))).toInt();
  }

  getNearByUseravailablefunc() async {
    var membersData =
        await FirebaseFirestore.instance.collection("Users").get();

    print(membersData.docs.length);
    print("Docuemtn Length++++++++++++++++++++++++++++++++++++++++++++");
    for (int x = 0; x < membersData.docs.length; x++) {
     if(double.parse(membersData.docs[x]['latitude'].toString())!=widget.userLatitude){

       print("Lattitude____________________________________________");
      if(double.parse(membersData.docs[x]['longtitude'].toString())!=widget.userLongtitude){

        print("Longtitude+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        int kmValue = getDistance(
            memberlatitude: double.parse(membersData.docs[x]['latitude'].toString()),
            memberlongtitude: double.parse(membersData.docs[x]['longtitude'].toString()));
        if (kmValue <= 100) {
          print("kili Metersssssssssssssssssssssss +++++++++++++++$kmValue");
          setState(() {
            nearMemberList.add(
                NearByMember(
                  membername: membersData.docs[x]['Name'].toString(),
                  memberNetworkImg: membersData.docs[x]['UserImg'].toString(),
                  Distance: kmValue,
                  memberClass: membersData.docs[x]['class'].toString(),
                  memberDocumentID: membersData.docs[x].id.toString(),
                  memberPassedOutYear:membersData.docs[x]['yearofpassed'].toString(),
                  memberToken:membersData.docs[x]['Token'].toString(),
            ));
          });
        }
      }
     }
    }
    print(nearMemberList.first.memberNetworkImg);
    print(nearMemberList.first.membername);
    print("Near+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  }
}








class NearByMember {
  String? memberNetworkImg;
  String? membername;
  String ?memberToken;
  String ?memberClass;
  String ?memberPassedOutYear;
  String ?memberDocumentID;
  int? Distance;

  NearByMember({this.membername, this.memberNetworkImg,this.Distance,this.memberClass,this.memberDocumentID,this.memberPassedOutYear,this.memberToken});
}
