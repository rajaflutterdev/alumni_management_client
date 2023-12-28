import 'package:alumni_management_client/Constant_File.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Profile_Page/Add-User_Job_Post_Page.dart';
import '../Translator_Module/Translator_Module_Page.dart';
import '../Your_Job_Screen_2.dart';

class Your_Post_Screen extends StatefulWidget {
  String ?AuthID;
   Your_Post_Screen({this.AuthID});

  @override
  State<Your_Post_Screen> createState() => _Your_Post_ScreenState();
}

class _Your_Post_ScreenState extends State<Your_Post_Screen> {

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return
      Scaffold(
        body:  Padding(
          padding:  EdgeInsets.only(left: width/39.2,right: width/39.2),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [

                Padding(
                  padding:  EdgeInsets.only(top: height/20.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KText(
                        text:" Your Job Post",style: GoogleFonts.nunito(
                          fontSize: width/19.6,
                          fontWeight: FontWeight.w700),),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => User_JobPost_Page(
                            userID: widget.AuthID.toString(),
                          ) ,));
                        },
                        child: Material(
                          elevation: 2,

                          borderRadius: BorderRadius.circular(5),
                          color: buttoncolor,
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: buttoncolor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                const Icon(Icons.add,color: Colors.white,),
                                Padding(
                                  padding: const EdgeInsets.only(left:2),
                                  child: KText(
                                    text: "Add Job",
                                    style: GoogleFonts.nunito(fontWeight: FontWeight.w700,color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )


                    ],
                  ),
                ),

                SizedBox(height: height/53.466,),

                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Users").doc(widget.AuthID).
                    collection("Posted_Jobs").snapshots(),
                    builder: (context, snapshot) {

                      if(snapshot.hasData==null){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(!snapshot.hasData){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      return ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data=snapshot.data!.docs[index];

                          return
                            GestureDetector(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  Your_Job_Screen_2(
                                AppliedUserList: data['registeredUsers'],
                                    appliedDate: data['date'],
                                    appliedtime: data['uploadTime'] ,
                                    comapanyDescription:data['subtitle'] ,
                                    comopanyName: data['title'],
                                    positions: data['positions'],
                                    documentId:data.id,

                              ),));


                            },
                            child:
                            Padding(
                              padding:  EdgeInsets.only(bottom:4),
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
                                            height: height/10.6933,
                                            width: width/5.226,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius: BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(data['img'].toString())
                                                )
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(left:width/49),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(

                                                  width: width/1.7,
                                                  height: height/40.1,
                                                  child:  KText(
                                                    text:data['title'].toString(),
                                                    style: GoogleFonts.nunito(
                                                        fontSize: width/30.153,
                                                        fontWeight: FontWeight.w700,
                                                        color: ItemTitleColor,
                                                        textStyle: const TextStyle(
                                                            overflow: TextOverflow.ellipsis
                                                        )
                                                    ),),
                                                ),

                                                SizedBox(
                                                  width: width/1.7,
                                                  height:height/19.095,
                                                  child:  KText(
                                                    text:data['subtitle'].toString(),
                                                    style: GoogleFonts.nunito(
                                                        fontSize: width/28,
                                                        fontWeight: FontWeight.w700,
                                                        textStyle: const TextStyle(
                                                          //  overflow: TextOverflow.ellipsis,
                                                        )
                                                    ),),
                                                ),

                                                SizedBox(
                                                  width: width/1.7,
                                                  height: height/40.1,
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.access_time_sharp,size: width/26.1333,color: ItemTitleColor,),
                                                      Padding(
                                                        padding:  EdgeInsets.only(left: width/196),
                                                        child:  KText(
                                                          text:data['uploadTime'].toString(),
                                                          style: GoogleFonts.nunito(
                                                              fontSize: width/30.153,
                                                              fontWeight: FontWeight.w700,
                                                              color: ItemTitleColor,
                                                              textStyle: const TextStyle(
                                                                  overflow: TextOverflow.ellipsis
                                                              )
                                                          ),),
                                                      ),

                                                      Padding(
                                                        padding:  EdgeInsets.only(left: width/8),
                                                        child:  KText(
                                                          text:"Applied : ${data['registeredUsers'].length.toString()}",
                                                          style: GoogleFonts.nunito(
                                                              fontSize: width/30.153,
                                                              fontWeight: FontWeight.w700,
                                                              color: ItemTitleColor,
                                                              textStyle: const TextStyle(
                                                                  overflow: TextOverflow.ellipsis
                                                              )
                                                          ),),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: (){
                                                FirebaseFirestore.instance.collection("Users").doc(widget.AuthID).
                                                collection("Posted_Jobs").doc(data.id).delete();
                                                FirebaseFirestore.instance.collection("JobPosts").doc(data.id).delete();

                                              },
                                              child: Icon(Icons.delete,color: Colors.black,))
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                          );

                      },);

                    },),


              ],
            ),
          ),
        ),
      );
  }



  appliedCompanyDetailsPopup({comopanyName,comapanyDescription,appliedDate,appliedtime,positions,docID}) async {

    int appiiedthisJobcounbt=0;

    var compantdetails=await FirebaseFirestore.instance.collection("JobPosts").get();
     for(int i=0;i<compantdetails.docs.length;i++){
       if(docID==compantdetails.docs[i].id){
         setState(() {
           appiiedthisJobcounbt=compantdetails.docs[i]['registeredUsers'].length;
         });
       }
   }

      return showDialog(context: context, builder: (context) {

      return Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 120,bottom: 120),
        child:
       Scaffold(
         body:  Container(
           height: 500,
           width: 320,
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(5),
               color: Colors.white
           ),


           child: Column(
             children: [
               SizedBox(height: 20,),
               Text("Company Details",style: GoogleFonts.nunito(fontWeight: FontWeight.w800,fontSize: 18),),
               SizedBox(height: 10,),
               Row(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("Company Name : ${comopanyName}",style: GoogleFonts.nunito(fontWeight: FontWeight.w600),),
                   ),
                 ],
               ),

               Row(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("Positions : ${positions}",style: GoogleFonts.nunito(fontWeight: FontWeight.w600),),
                   ),
                 ],
               ),

               Row(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("Date : ${appliedDate}",style: GoogleFonts.nunito(fontWeight: FontWeight.w600),),
                   ),
                 ],
               ),

               Row(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("Time : ${appliedtime}",style: GoogleFonts.nunito(fontWeight: FontWeight.w600),),
                   ),
                 ],
               ),

               Row(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("Total Applied Alumna's : ${appiiedthisJobcounbt}",style: GoogleFonts.nunito(fontWeight: FontWeight.w600),),
                   ),
                 ],
               ),

               Row(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("Company Description ",style: GoogleFonts.nunito(fontWeight: FontWeight.w600),),
                   ),
                 ],
               ),

               Container(
                 decoration: BoxDecoration(
                     color: Colors.grey.shade200,
                     borderRadius: BorderRadius.circular(5)
                 ),
                 height: 120,
                 width: 300,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(comapanyDescription,style: GoogleFonts.nunito(fontWeight: FontWeight.w600),),
                 ),
               ),
               SizedBox(height: 20,),

               GestureDetector(
                 onTap: (){
                   Navigator.pop(context);
                 },
                 child: Container(
                   height: 45,
                   width: 100,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(80),
                     color: buttoncolor,

                   ),
                   child: Center(
                     child: KText(
                       text: "Okay",
                       style: GoogleFonts.nunito(fontWeight: FontWeight.w700,color: Colors.white),
                     ),
                   ),
                 ),
               ),



             ],
           ),
         ),
       )
      );
    },);
  }



}
