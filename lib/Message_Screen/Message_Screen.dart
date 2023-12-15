import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constant_File.dart';
import '../Translator_Module/Translator_Module_Page.dart';
import 'Group_Chat_Screen.dart';
import 'Message_ViewDetails_Page.dart';

class Message_Screen extends StatefulWidget {
  String?UserDepartment;
  String?UserPassedYear;
   Message_Screen({this.UserDepartment,this.UserPassedYear});

  @override
  State<Message_Screen> createState() => _Message_ScreenState();
}

class _Message_ScreenState extends State<Message_Screen> with SingleTickerProviderStateMixin {


  @override
  initState()  {
    getToekt();
    tabController=TabController(length: 2, vsync: this)  ;
    // TODO: implement initState
    super.initState();
  }

  TabController?tabController;
  int selectTabIndex=0;
getToekt()async{
  String? token = await FirebaseMessaging.instance.getToken();
  print(token);
}

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.only(left: width/39.2,right: width/39.2),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(

          children: [

            Padding(
              padding:  EdgeInsets.only(top: height/40.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KText(
                    text:"Messages",style: GoogleFonts.nunito(
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

            TabBar(
              controller: tabController,
              labelColor: buttoncolor,
              dividerColor: Colors.transparent,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: buttoncolor,
              physics: BouncingScrollPhysics(),
              indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: 0, vertical: 0),
              labelPadding: const EdgeInsets.all(0),
              splashBorderRadius: BorderRadius.zero,
              splashFactory: NoSplash.splashFactory,
              labelStyle: GoogleFonts.openSans(
                fontSize: width/25.714,
                fontWeight: FontWeight.w800,
              ),
              unselectedLabelStyle: GoogleFonts.nunito(
                  color: Color(0xff4E4B66)
              ),
              onTap: (index){
                setState(() {
                  selectTabIndex = index;
                });
              },
              tabs: [
                Tab(
                  child:    KText(
                      text:"Personal",style:GoogleFonts.nunito(fontWeight: FontWeight.w700)),
                ),
                Tab(
                  child:   KText(
                      text:"Groups",style:GoogleFonts.nunito(fontWeight: FontWeight.w700)),
                ),

              ],
            ),

            SizedBox(
              height:height/1.008,
              child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [

                  SizedBox(
                   width:width/1.37,
                   child: StreamBuilder(
                       stream:FirebaseFirestore.instance.collection("Users").orderBy("timestamp").snapshots() ,

                       builder: (context, snapshot) {

                         if(!snapshot.hasData){
                           return const Center(child: CircularProgressIndicator(),);
                         }
                         if(snapshot.hasData==null){
                           return const Center(child: CircularProgressIndicator(),);
                         }


                         return
                           ListView.builder(
                           physics: const BouncingScrollPhysics(),
                           shrinkWrap: true,
                           itemCount: snapshot.data!.docs.length,
                           itemBuilder: (context, index) {
                             var Userdata=snapshot.data!.docs[index];
                             if(Userdata['userDocId']!=FirebaseAuth.instance.currentUser!.uid) {
                               return
                                 GestureDetector(
                                   onTap: () {

                                     print(Userdata.id);
                                     print(Userdata['class'].toString());
                                     print(Userdata['UserImg'].toString());
                                     print(Userdata['Name'].toString());
                                     print(Userdata['userDocId'].toString());
                                     // Get.to(
                                     //     Message_ViewDetails_Page(
                                     //       userDocid: Userdata.id,
                                     //       userBatch: Userdata['yearofpassed'].toString(),
                                     //       userdepartment: Userdata['class'].toString(),
                                     //       userName: Userdata['Name'].toString(),
                                     //       userToken: Userdata['Token'].toString(),
                                     //       userProfile: Userdata['UserImg'].toString() == "" ? AvatorImg.toString() : Userdata['UserImg'].toString(),
                                     //     ), transition: Transition.zoom,
                                     //     curve: Curves.linearToEaseOut,
                                     //     duration: Duration(milliseconds: 200)
                                     // );

                                     Navigator.push(context, MaterialPageRoute(builder: (context) =>  Message_ViewDetails_Page(
                                       userDocid: Userdata.id,
                                       userBatch: Userdata['yearofpassed'].toString(),
                                       userdepartment: Userdata['class'].toString(),
                                       userName: Userdata['Name'].toString(),
                                       userToken: Userdata['Token'].toString(),
                                       userProfile: Userdata['UserImg'].toString() == "" ? AvatorImg.toString() : Userdata['UserImg'].toString(),
                                     ),));
                                   },
                                   child: Container(
                                     decoration: BoxDecoration(
                                         border: Border(
                                             bottom: BorderSide(
                                                 color: Colors.grey.shade300
                                             )
                                         )
                                     ),
                                     child:
                                     ListTile(
                                       leading: Container(
                                         height: height / 16.04,
                                         width: width / 7.84,
                                         decoration: BoxDecoration(
                                             color: Colors.grey,
                                             borderRadius: BorderRadius
                                                 .circular(width/3.6),
                                             image: DecorationImage(
                                               fit: BoxFit.cover,
                                               image: NetworkImage(
                                                   Userdata['UserImg']
                                                       .toString()),
                                             )
                                         ),
                                       ),
                                       title: SizedBox(
                                         width: width / 1.6333,
                                         height: height / 40.1,
                                         child:
                                         KText(
                                           text: Userdata['Name']
                                               .toString(),
                                           style: GoogleFonts.nunito(
                                               fontSize: width /
                                                   26.1333,
                                               fontWeight: FontWeight
                                                   .w800,
                                               textStyle: TextStyle(
                                                 //  overflow: TextOverflow.ellipsis,
                                               )
                                           ),),
                                       ),
                                       subtitle:  SizedBox(
                                         width: width / 1.6333,
                                         height: height / 40.1,
                                         child: KText(
                                           text: Userdata['class'].toString(),
                                           style: GoogleFonts.nunito(
                                               fontSize: width /
                                                   30.153,
                                               color: const Color(
                                                   0xff000000),
                                               fontWeight: FontWeight
                                                   .w600,
                                               textStyle: const TextStyle(
                                                   overflow: TextOverflow
                                                       .ellipsis
                                               )
                                           ),),
                                       ),
                                     ),
                                   ),
                                 );
                             }
                             return const SizedBox(
                             );
                           },
                         );
                       },),
                 ),

                  StreamBuilder(
                    stream:FirebaseFirestore.instance.collection("Groups").where("Department",isEqualTo:widget.UserDepartment)
                        .where("AccademicYear",isEqualTo:widget.UserPassedYear).snapshots() ,

                    builder: (context, snap) {

                      if(!snap.hasData){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(snap.hasData==null){
                        return const Center(child: CircularProgressIndicator(),);
                      }


                      return
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snap.data!.docs.length,
                          itemBuilder: (context, index) {
                            var groupData=snap.data!.docs[index];
                            return
                              GestureDetector(
                                onTap: (){
                                  // Get.to(
                                  //     Group_Chat_Screen(
                                  //       Docid: groupData.id,
                                  //       groupdepart: groupData['Department'].toString(),
                                  //       grouppassesyear:  groupData['AccademicYear'].toString(),
                                  //       groupImg: groupData['Img'].toString()==""?AvatorImg.toString():groupData['Img'].toString(),
                                  //     ),transition: Transition.zoom ,
                                  //     curve: Curves.linearToEaseOut,
                                  //     duration: Duration(milliseconds: 200)
                                  // );

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Group_Chat_Screen(
                                    Docid: groupData.id,
                                    groupdepart: groupData['Department'].toString(),
                                    grouppassesyear:  groupData['AccademicYear'].toString(),
                                    groupImg: groupData['Img'].toString()==""?AvatorImg.toString():groupData['Img'].toString(),
                                  ) ,));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade300
                                          )
                                      )
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      height: height/16.04,
                                      width: width/7.84,

                                      child: Center(
                                        child: Text(
                                            groupData['Img'].toString()==""?
                                            groupNameTextfunc(groupData['Department'].toString()):"",
                                          style: GoogleFonts.nunito(
                                              fontSize: width/26.1333,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                              textStyle: TextStyle(
                                                //  overflow: TextOverflow.ellipsis,
                                              )
                                          ),

                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: randomOpaqueColor(),
                                          borderRadius: BorderRadius.circular(width/3.6),
                                          image: DecorationImage(
                                            image: NetworkImage(groupData['Img'].toString()),

                                          )
                                      ),
                                    ),
                                    title:  SizedBox(
                                      width: width/1.6333,
                                      height:height/40.1,
                                      child:
                                      KText(
                                        text:groupData['Department'].toString(),
                                        style: GoogleFonts.nunito(
                                            fontSize: width/26.1333,
                                            fontWeight: FontWeight.w800,
                                            textStyle: TextStyle(
                                              //  overflow: TextOverflow.ellipsis,
                                            )
                                        ),),
                                    ),
                                    subtitle:  SizedBox(
                                      width: width/1.6333,
                                      height: height/40.1,
                                      child:  KText(
                                        text:"${groupData['AccademicYear'].toString()}",
                                        style: GoogleFonts.nunito(
                                            fontSize: width/30.153,
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w600,
                                            textStyle: TextStyle(
                                                overflow: TextOverflow.ellipsis
                                            )
                                        ),),
                                    ),
                                  ),
                                ),
                              );
                          },);
                    },),

                ],
              ),
            ),

            SizedBox(height: height/40.1,),

          ],
        ),
      ),
    );
  }

  groupNameTextfunc(groupName){

    List<String> words = groupName.split(" ");
    String result=words.length>1? "${words[0].substring(0,1)}${words[1].substring(0,1)}":words.toString().substring(1,3);
    return  result;
  }

  static Color randomOpaqueColor() {
    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
  }

}
