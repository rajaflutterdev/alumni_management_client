import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Constant_File.dart';
import '../Translator_Module/Translator_Module_Page.dart';

class User_JobPost_Page extends StatefulWidget {
  String ?userID;
   User_JobPost_Page({this.userID});

  @override
  State<User_JobPost_Page> createState() => _User_JobPost_PageState();
}

class _User_JobPost_PageState extends State<User_JobPost_Page> {


  TextEditingController qualificationController=TextEditingController();
  TextEditingController positionsController=TextEditingController();
  TextEditingController locationController=TextEditingController();
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController timeController=TextEditingController();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  File? imageFile;
  String Uploadimage='';
  FirebaseStorage fs = FirebaseStorage.instance;
  bool submitted=false;

  @override
  void initState() {
    setDateTime();
    // TODO: implement initState
    super.initState();
  }
  setDateTime() async {
    setState(() {
      dateController.text = formatter.format(DateTime.now());
      timeController.text = DateFormat('hh:mm a').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: KText(
          text:" Add Job Post",style: GoogleFonts.nunito(
            fontSize: width/19.6,
            fontWeight: FontWeight.w700),),
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: width/39.2,right: width/39.2),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [

                  GestureDetector(
                    onTap: (){
                      imageFromGallery();
                    },
                    child: Container(
                      height:height/4.8,
                      width: width/1.5,
                      decoration: BoxDecoration
                        (
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5),
                          image:
                          imageFile==null?
                          DecorationImage(
                              image: AssetImage("")):
                          DecorationImage(
                              image: FileImage(imageFile!),
                              fit: BoxFit.contain
                          )

                      ),
                      child:  imageFile==null?Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          KText(text: "Add Images", style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
                           Icon(Icons.add_circle_outlined,size: width/7.2,),
                        ],
                      )):const SizedBox(),
                    ),
                  ),


               /*   ///Date And Time Container
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            KText(
                              style: GoogleFonts.nunito(fontWeight: FontWeight.w700,),
                              text: "Date",
                            ),
                            Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: dateController,
                                  maxLines: 1,
                                  style: GoogleFonts.nunito(fontWeight: FontWeight.w500,color: Colors.black),
                                  decoration: InputDecoration(
                                      border: InputBorder.none
                                  ),
                                ),
                              ) ,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            KText(
                              style: GoogleFonts.nunito(fontWeight: FontWeight.w700,),
                              text: "Time",
                            ),
                            Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: timeController,
                                  maxLines: 1,
                                  style: GoogleFonts.nunito(fontWeight: FontWeight.w500,color: Colors.black),
                                  decoration: InputDecoration(
                                      border: InputBorder.none
                                  ),
                                ),
                              ) ,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),*/

                  ///title container
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        KText(
                          style: GoogleFonts.nunito(fontWeight: FontWeight.w700,),
                          text: "Title",
                        ),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xffDDDEEE),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: titleController,
                              maxLines: 1,
                              style: GoogleFonts.nunito(fontWeight: FontWeight.w500,color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ) ,
                        )
                      ],
                    ),
                  ),

                  ///Positions container
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        KText(
                          style: GoogleFonts.nunito(fontWeight: FontWeight.w700,),
                          text: "Positions",
                        ),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xffDDDEEE),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: positionsController,
                              maxLines: 1,
                              style: GoogleFonts.nunito(fontWeight: FontWeight.w500,color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ) ,
                        )
                      ],
                    ),
                  ),

                  ///Qualification container
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        KText(
                          style: GoogleFonts.nunito(fontWeight: FontWeight.w700,),
                          text: "Qualification",
                        ),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xffDDDEEE),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: qualificationController,
                              maxLines: 1,
                              style: GoogleFonts.nunito(fontWeight: FontWeight.w500,color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ) ,
                        )
                      ],
                    ),
                  ),

                  ///Locations container
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        KText(
                          style: GoogleFonts.nunito(fontWeight: FontWeight.w700,),
                          text: "Location",
                        ),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xffDDDEEE),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: locationController,
                              maxLines: 1,
                              style: GoogleFonts.nunito(fontWeight: FontWeight.w500,color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ) ,
                        )
                      ],
                    ),
                  ),

                  ///Description container
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        KText(
                          style: GoogleFonts.nunito(fontWeight: FontWeight.w700,),
                          text: "Description",
                        ),
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xffDDDEEE),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: descriptionController,
                              maxLines: null,
                              style: GoogleFonts.nunito(fontWeight: FontWeight.w500,color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ) ,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height/35.12,),
                  ///Submit Button

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap:submitted==false?
                            (){
                          if(dateController.text!=""&& timeController.text!="") {
                            jobPostCreateFunction();
                          }
                        }:(){},
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            color: buttoncolor,

                          ),
                          child: Center(
                            child: KText(
                              text: "Submit",
                              style: GoogleFonts.nunito(fontWeight: FontWeight.w700,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height/15.12,)



                ],
              ),
            ),
            submitted==true?
            Material(
              elevation: 2,
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text("Please Wait...",style: GoogleFonts.nunito(fontWeight: FontWeight.w700,),),
                    ),
                    const CircularProgressIndicator(),
                  ],
                ),

              ),
            ):
            const SizedBox()
          ],
        ),
      ),
    );
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  imageFromGallery() async {
    var pickedFile = (await ImagePicker().pickImage(
        source: ImageSource.gallery));
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        Uploadimage = "";
      });
    }
  }

  jobPostCreateFunction() async {
    setState(() {
      submitted=true;
    });
    var tempDocId = generateRandomString(16);

    if(Uploadimage==""&&imageFile!=null){
      var ref = FirebaseStorage.instance.ref().child('Images').child("$imageFile.jpg");
      var uploadTask = await ref.putFile(imageFile!).catchError((error) async {

      });
      var image = await uploadTask.ref.getDownloadURL();
      setState(() {
        Uploadimage=image;
      });
    }

    String userName="";
    String userbatch="";
    String userOccupation="";

    var Userdata=await FirebaseFirestore.instance.collection("Users").doc(widget.userID).get();
    Map<String,dynamic>?value=Userdata.data();

    setState(() {
      userName=value!['Name'];
      userbatch=value['yearofpassed'];
      userOccupation=value['subjectStream'];
    });

    FirebaseFirestore.instance.collection("Users").doc(widget.userID).collection("Posted_Jobs").doc(tempDocId).set({
      "date": dateController.text,
      "uploadTime": timeController.text,
      "id": tempDocId,
      "img": Uploadimage==""?"":Uploadimage,
      "location": locationController.text,
      "subtitle": descriptionController.text,
      "positions": positionsController.text,
      "quvalification": qualificationController.text,
      "title": titleController.text,
      "registeredUsers": [],
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "verify": false,
      "views": [],
      "userName":userName,
      "UserOccupation":userOccupation,
      "Batch":userbatch
    });
    FirebaseFirestore.instance.collection("JobPosts").doc(tempDocId).set({
      "date": dateController.text,
      "uploadTime": timeController.text,
      "id": tempDocId,
      "img": Uploadimage==""?"":Uploadimage,
      "location": locationController.text,
      "subtitle": descriptionController.text,
      "positions": positionsController.text,
      "quvalification": qualificationController.text,
      "title": titleController.text,
      "registeredUsers": [],
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "verify": false,
      "views": [],
      "userName":userName,
      "UserOccupation":userOccupation,
      "Batch":userbatch

});
    setState(() {
      Uploadimage=="";
      imageFile=null;
      locationController.clear();
      descriptionController.clear();
      positionsController.clear();
       qualificationController.clear();
       titleController.clear();
      submitted=false;
    });

    setDateTime();
    congrationPopup();
  }

  congrationPopup(){

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return showDialog(context: context,

      builder: (context){
        return
          Padding(
            padding:  EdgeInsets.only(top:height/4.4555,bottom: height/4.4555),
            child: AlertDialog(
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height/4.4555,
                    width: width/2.1777,
                    child: Image.asset(PopUpImag,fit: BoxFit.contain,),
                  ),
                  SizedBox(
                    height: height/53.466,
                  ),
                  Text("SuccessFull",style: GoogleFonts.nunito(
                      fontWeight:
                      FontWeight.w700,color: Color(0xff202244),fontSize: width/21.777),),
                  SizedBox(
                    height: height/53.466,
                  ),
                  Text("New Job Post Successfully......",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(fontWeight:
                    FontWeight.w600,color: textcolor,fontSize: width/32.666),),

                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(top: 15),
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(50),
                          color: buttoncolor,
                        ),
                        child: Center(child: Text("Okay",style: GoogleFonts.nunito(fontWeight: FontWeight.w700,color: Colors.white),)),
                      ),
                    ),
                  )

                ],
              ),
            ),
          );

      },);
  }
}
