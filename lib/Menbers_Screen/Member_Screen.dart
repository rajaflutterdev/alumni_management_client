import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Translator_Module/Translator_Module_Page.dart';

class Member_Screen extends StatefulWidget {
  double ?userLatitude; 
  double ?userLongtitude; 
   Member_Screen({this.userLatitude,this.userLongtitude});

  @override
  State<Member_Screen> createState() => _Member_ScreenState();
}

class _Member_ScreenState extends State<Member_Screen> {

  int value=0;

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

        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Members").orderBy("timestamp").snapshots(),
            builder: (context, snapshot) {

              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.hasData==null){
                return const Center(child: CircularProgressIndicator(),);
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index){
                  var memberData=snapshot.data!.docs[index];

                  return Material(
                    elevation: 5,
                    color: Colors.white70,
                    child: ListTile(
                      title: KText(text:memberData['name'].toString(),style: GoogleFonts.nunito(color: Colors.black),),
                      subtitle:KText(text:"Distance :${getDistance(
                        memberlatitude: double.parse(memberData['lattitude'].toString()),
                        memberlongtitude:  double.parse(memberData['longtitude'].toString()),
                      ).toString()} KM",style: GoogleFonts.nunito(color: Colors.black),),
                    ),
                  );
                },);
            },),

      ],
    );
  }

  getDistance({memberlatitude, memberlongtitude}) {
    var p = 0.017453292519943295;
    var c = cos;
    ///another person latitude-current user latitude
    var a = 0.5 - c((memberlatitude - widget.userLatitude!.toDouble()) * p)/2 +
        ///(current User latitude*P) * (another person latitude *P)
        c(widget.userLatitude!.toDouble() * p) *  c(memberlatitude * p) *
            ///another person longtitude -current Usesr Longtitude
            (1 - c((memberlongtitude- widget.userLongtitude!.toDouble()) * p))/2;

    return ((12742 * asin(sqrt(a)))).toInt();
  }


}
