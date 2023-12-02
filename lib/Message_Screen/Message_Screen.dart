import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constant_File.dart';
import '../Translator_Module/Translator_Module_Page.dart';
import 'Message_ViewDetails_Page.dart';

class Message_Screen extends StatefulWidget {
  const Message_Screen({super.key});

  @override
  State<Message_Screen> createState() => _Message_ScreenState();
}

class _Message_ScreenState extends State<Message_Screen> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    tabController=TabController(length: 2, vsync: this)  ;
    // TODO: implement initState
    super.initState();
  }

  TabController?tabController;
  int selectTabIndex=0;


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
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.red,
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
            physics: NeverScrollableScrollPhysics(),
            children: [

             StreamBuilder(
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
                       return
                         GestureDetector(
                         onTap: (){
                           print(Userdata.id);
                           print(Userdata['Batch'].toString());
                           print(Userdata['department'].toString());
                           print(Userdata['UserImg'].toString());
                           print(Userdata['Name'].toString());
                           print(Userdata['userDocId'].toString());
                           Get.to(
                               Message_ViewDetails_Page(
                             userDocid:Userdata.id,
                             userBatch: Userdata['Batch'].toString(),
                             userdepartment: Userdata['department'].toString(),
                             userName: Userdata['Name'].toString(),
                             userProfile:Userdata['UserImg'].toString()==""?AvatorImg.toString():Userdata['UserImg'].toString(),
                           ),transition: Transition.zoom ,
                               curve: Curves.linearToEaseOut,
                               duration: Duration(milliseconds: 200)
                           );
                         },
                         child: Material(
                           elevation:15,
                           color: Color(0xffFFFFFF),
                           //color: Colors.red,
                           shadowColor: Colors.black12,
                           child: Container(
                               height: height/8.02,
                               width:double.infinity,
                               decoration: BoxDecoration(
                                   color:Color(0xffFFFFFF),
                                   // color: Colors.red,
                                   border: Border(
                                       bottom: BorderSide(
                                           color: Colors.grey.shade300
                                       )
                                   )
                               ),
                               child:Padding(
                                 padding:  EdgeInsets.symmetric(
                                     horizontal: width/49,
                                     vertical: height/100.25
                                 ),
                                 child: Row(
                                   children: [
                                     Container(
                                       height: height/16.04,
                                       width: width/7.84,
                                       decoration: BoxDecoration(
                                           color: Colors.grey,
                                           borderRadius: BorderRadius.circular(100),
                                           image: DecorationImage(
                                             image: NetworkImage(Userdata['UserImg'].toString()),

                                           )
                                       ),
                                     ),
                                     Padding(
                                       padding:  EdgeInsets.only(left:width/49),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           SizedBox(
                                            width: width/1.6333,
                                             height:height/40.1,
                                             child:
                                             KText(
                                               text:Userdata['Name'].toString(),
                                               style: GoogleFonts.nunito(
                                                   fontSize: width/26.1333,
                                                   fontWeight: FontWeight.w800,
                                                   textStyle: TextStyle(
                                                     //  overflow: TextOverflow.ellipsis,
                                                   )
                                               ),),
                                           ),
                                           SizedBox(
                                            width: width/1.6333,
                                             height: height/40.1,
                                             child:  KText(
                                               text:"${Userdata['department'].toString()} ${Userdata['Batch'].toString()}Batch",
                                               style: GoogleFonts.nunito(
                                                   fontSize: width/30.153,
                                                   color: Color(0xff000000),
                                                   fontWeight: FontWeight.w600,
                                                   textStyle: TextStyle(
                                                       overflow: TextOverflow.ellipsis
                                                   )
                                               ),),
                                           ),


                                         ],
                                       ),
                                     )
                                   ],
                                 ),
                               )
                           ),
                         ),
                       );
                     },
                   );
                 },),





            ],
          ),
        ),
        SizedBox(height: height/40.1,),

      ],
    );
  }
}
