import 'dart:math';

import 'package:alumni_management_client/Constant_File.dart';
import 'package:alumni_management_client/Landing_Screen/Landing_Screen.dart';
import 'package:alumni_management_client/Translator_Module/Translator_Module_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Apply_For_Job_Post extends StatefulWidget {
  String ?DocumentId;
  String ?CompanyName;
  String ?CompanydesCription;
  String ?Companypositions;
  String ?AuthID;
   Apply_For_Job_Post({this.DocumentId,this.CompanyName,this.CompanydesCription,this.Companypositions,this.AuthID});

  @override
  State<Apply_For_Job_Post> createState() => _Apply_For_Job_PostState();
}

class _Apply_For_Job_PostState extends State<Apply_For_Job_Post> {




  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController qualificationController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();


  File? _selectedFile;
  var getDownloadUrl;
  List registerEventsList=[];
  
  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: KText(
          text: "Job Post",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w700,
            fontSize: width/16.6,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Company Name : ${widget.CompanyName.toString()}",style: GoogleFonts.nunito(fontWeight: FontWeight.w700),),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Personal Details :",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunito(fontWeight: FontWeight.w700,fontSize: 16),),
              ),


              ///Name Container
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    KText(
                    style: GoogleFonts.nunito(fontWeight: FontWeight.w700,),
                      text: "Name",
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
                          controller: nameController,
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

              ///Phone Container,
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    KText(
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w700,),
                      text: "Phone",
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
                          controller: phoneController,
                          maxLines: 1,
                          maxLength: 10,
                          keyboardType: TextInputType.number,

                          style: GoogleFonts.nunito(fontWeight: FontWeight.w500,color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                            counterText: ""
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


              ///Description container
              SizedBox(
                height: 150,
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
                      height: 100,
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


              ///Document Upload container
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    KText(
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w700,),
                      text: "Documents/Resume",
                    ),
                    GestureDetector(

                     onTap: (){
                       _pickDocument();

                     },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: buttoncolor
                          ),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            _selectedFile==null?
                            Image.asset(DocuemntImg,height: 60,width: 60,):Icon(Icons.done,color: buttoncolor,),

                            Text("Upload Your Doc..",style: GoogleFonts.nunito(fontWeight: FontWeight.w700,color: Colors.black),)
                          ],
                        )
                      ),
                    )
                  ],
                ),


              ),


              ///Submit Button

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(nameController.text==""&&
                          descriptionController.text==""&&
                          qualificationController.text==""&&
                          phoneController.text.length!=10){
                        errorPopup();
                      }
                      else{
                        uploadDocument();
                      }
                    },
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
              )


            ],
          ),
        ),
      ),

    );
  }




  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
   _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles( type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],);

    if (result == null || result.files.isEmpty) return;
    setState(() {
      _selectedFile = File(result.files.single.path!);
    });
  }

  uploadDocument() async {

    registerEventsList.add(widget.AuthID);

     var tempDocId=generateRandomString(16);

     print(widget.DocumentId);
     print(widget.AuthID);
     print("________________________________________");


     print(registerEventsList);
     print("Listttttttttttttttttttttttttttttttttttttttttttttttt");

    if (_selectedFile != null) {
      print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      var ref = FirebaseStorage.instance.ref().child("documents/$fileName").child("$_selectedFile");
      var uploadTask = await ref.putFile(_selectedFile!).catchError((error) async {
      });
      var image = await uploadTask.ref.getDownloadURL();
      setState(() {
        getDownloadUrl=image;
      });
      print(getDownloadUrl);
      print("download Url__________________________________________________________");
    }
    print("Check--------------11111111111111111111111");
    FirebaseFirestore.instance.collection("JobPosts").doc(widget.DocumentId).update({
       "registeredUsers":registerEventsList,
     });
    print("Check--------------22222222222222222222");

    FirebaseFirestore.instance.collection("Users").doc(widget.AuthID).collection('Posted_Jobs').doc(widget.DocumentId).update({
      "registeredUsers":registerEventsList,
    });

    print("Check--------------333333333333333333333");

    FirebaseFirestore.instance.collection("JobPosts").doc(widget.DocumentId).collection('Applied_Jobs').doc(tempDocId).set({
      "name":nameController.text,
      "phone":phoneController.text,
      "qualification":qualificationController.text,
      "description":descriptionController.text,
      "document":getDownloadUrl==""?"":getDownloadUrl,
      "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time":DateFormat("hh:mm a").format(DateTime.now()),
      "timestamp":DateTime.now().millisecondsSinceEpoch,
      "announcecmpname":widget.CompanyName,
      "announcecmpdes":widget.CompanydesCription,
      "announceposition":widget.Companypositions,
      "verfiyed":false,
    });
    FirebaseFirestore.instance.collection("Users").doc(widget.AuthID).collection('Applied_Jobs').doc(tempDocId).set({
      "name":nameController.text,
      "phone":phoneController.text,
      "qualification":qualificationController.text,
      "description":descriptionController.text,
      "document":getDownloadUrl==""?"":getDownloadUrl,
      "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time":DateFormat("hh:mm a").format(DateTime.now()),
      "timestamp":DateTime.now().millisecondsSinceEpoch,
      "announcecmpname":widget.CompanyName,
      "announcecmpdes":widget.CompanydesCription,
      "announceposition":widget.Companypositions,
      "verfiyed":false,
      "docid":widget.DocumentId,
    });

    congrationPopup();

    setState(() {
      nameController.clear();
      descriptionController.clear();
      qualificationController.clear();
      phoneController.clear();
      registerEventsList.clear();
      getDownloadUrl="";
      _selectedFile=null;
    });



  }




  errorPopup(){

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
                    child: Lottie.asset(errorLottie,fit: BoxFit.contain,),
                  ),
                  SizedBox(
                    height: height/53.466,
                  ),
                  Text("Error !..",style: GoogleFonts.nunito(
                      fontWeight:
                      FontWeight.w700,color: Color(0xff202244),fontSize: width/21.777),),
                  SizedBox(
                    height: height/53.466,
                  ),
                  Text("Please Fill the Phone Number Correctly....",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(fontWeight:
                    FontWeight.w600,color: textcolor,fontSize: width/32.666),),

                ],
              ),
            ),
          );

      },);
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Landing_Screen(),));
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
