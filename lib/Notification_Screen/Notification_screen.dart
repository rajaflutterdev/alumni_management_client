import 'package:alumni_management_client/Constant_File.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Translator_Module/Translator_Module_Page.dart';

class Notification_screen extends StatefulWidget {
  const Notification_screen({super.key});

  @override
  State<Notification_screen> createState() => _Notification_screenState();
}

class _Notification_screenState extends State<Notification_screen> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: height/20.1,left: width/45),
              child: Row(
                children: [

                  GestureDetector(

                    onTap:(){
                      Navigator.pop(context);
                    },
                      child: Icon(Icons.arrow_back,color: TextColor,)),
                  Padding(
                    padding:  EdgeInsets.only(left:width/45),
                    child: KText(
                      text:"Notification",style: GoogleFonts.nunito(
                        fontSize: width/19.6,
                        fontWeight: FontWeight.w700),),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream:FirebaseFirestore.instance.collection("Notification").orderBy("timestamp",descending: true).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData==null){
                  return const Center(child: CircularProgressIndicator(),);
                }
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator(),);
                }

                if(snapshot.data!.docs.length==0){
                  return Center(child: Text("Notification are empty"),);
                }
                return
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {

                      var notificationdata=snapshot.data!.docs[index];

                      return  Padding(
                        padding:  EdgeInsets.symmetric(
                          horizontal: width/45,
                          vertical: height/94.5
                        ),
                        child: Container(

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.black38,

                              )
                          ),

                          child: ListTile(
                            title:SizedBox(

                              height:height/37.8,
                              width: width /
                                  .6,
                              child:
                              Padding(
                                padding:  EdgeInsets.only(left:width/180),
                                child: Text(
                                  "${notificationdata["title"]}",
                                  style: GoogleFonts
                                      .nunito(
                                      color:
                                      TextColor,
                                      textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                                      fontSize: width/24,
                                      fontWeight:
                                      FontWeight
                                          .w600),
                                ),
                              ),
                            ),
                            subtitle:Column(
                              children: [
                                Row(
                                  children: [

                                    SizedBox(
                                      height:height/42,
                                      width: width / 1.35,
                                      child: Text(
                                        " ${notificationdata["description"]}",
                                        style: GoogleFonts
                                            .nunito(color:
                                        Colors.black54,
                                            textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                                            fontSize:
                                            width/32.0,
                                            fontWeight:
                                            FontWeight
                                                .w600),

                                      ),
                                    ),

                                  ],
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left:width/160),
                                  child: Row(
                                    children: [

                                      SizedBox(
                                        height:height/50.4,
                                        width: width /
                                            5.8,

                                        child: Text(
                                          "${notificationdata["date"]}",
                                          style: GoogleFonts
                                              .nunito(
                                              color:
                                              Colors.black54,textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                                              fontSize:
                                              width/36.0,
                                              fontWeight:
                                              FontWeight
                                                  .w600),

                                        ),
                                      ),

                                      SizedBox(
                                        height:height/50.4,
                                        width: width /
                                            4.6,

                                        child: Text(
                                          "- ${notificationdata["time"]}",
                                          style: GoogleFonts.nunito(color: Colors.black54, fontSize:
                                              10,
                                              fontWeight:
                                              FontWeight
                                                  .w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            /*trailing:notificationdata["readstatus"]==false?
                            Icon(Icons.circle,size: width/24,color: Colors.green,):SizedBox(),*/

                          ),
                        ),
                      );

                    },);
              },),
          ],
        ),
      ),
    );
  }
}
