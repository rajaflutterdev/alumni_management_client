
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constant_File.dart';
import 'Otp_Screen_Page.dart';

class LogIn_Screen extends StatefulWidget {
  const LogIn_Screen({super.key});

  @override
  State<LogIn_Screen> createState() => _LogIn_ScreenState();
}

class _LogIn_ScreenState extends State<LogIn_Screen> {


  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  String userDocumentID="";
  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [

              SizedBox(height: height/32.08,),

              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: width/39.2),
                    child: Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                      width: width/1.1529,
                      child: Center(child: Text("Sign in",style: GoogleFonts.
                      nunito(fontSize: width/18,fontWeight: FontWeight.w800,color: Colors.black),)))
                ],
              ),

              SizedBox(height: height/14.581,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Logo),
                  Padding(
                    padding:  EdgeInsets.only(left: width/26.133,right: width/26.133),
                    child: Text("Alumni Management",style: GoogleFonts.nunito(fontSize: width/17.8181
                        ,fontWeight: FontWeight.w800,color: buttoncolor),),
                  )

                ],
              ),

              SizedBox(height: height/17.822,),

              Container(
                height: height/14.5818,
                width: width/1.0888,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:Border.all(
                    color: buttoncolor,
                    width: width/261.3333
                  )
                )  ,
                child: Padding(
                  padding:  EdgeInsets.only(left: width/49,right: width/49),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Name",
                      prefixIcon: Icon(Icons.mail,color: Color(0xff515960),)
                    ),
                  ),
                ),
              ),

              SizedBox(height: height/53.466,),


              Container(
                height: height/14.5818,
                width: width/1.0888,
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:Border.all(
                        color: buttoncolor,
                        width: width/261.3333
                    )
                )  ,
                child: Padding(
                  padding:   EdgeInsets.only(left: width/49,right: width/49),
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                        hintText: "Phone Number",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock_open_sharp,color: Color(0xff515960),)
                    ),
                  ),
                ),
              ),

              SizedBox(height: height/22.914,),

              GestureDetector(
                onTap: (){
                  print("Login _______________________________");
                  AlumniDatacheckfuntion();
                },
                child: Container(
                  height: height/14.5818,
                  width: width/1.0888,
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                     color: buttoncolor
                  )  ,
                  child: Padding(
                    padding:  EdgeInsets.only(left: width/49,right: width/49),
                    child: Center(child:
                    Text("Log in ",style: GoogleFonts.nunito(fontWeight:
                    FontWeight.w600,color: Colors.white),))
                  ),
                ),
              ),
              SizedBox(height: height/26.733,),
              Text('OR',style: GoogleFonts.nunito(fontWeight:
              FontWeight.w600,color: Colors.grey.shade500),),
              SizedBox(height: height/26.733,),

              Container(
                height: height/14.5818,
                width: width/1.0888,
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffE3EDFF)
                )  ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset(appleImg),
                    Padding(
                      padding:  EdgeInsets.only(left:width/49),
                      child: Text("Sign up with Apple ",
                        style: GoogleFonts.nunito(
                          fontSize: width/24.5,
                            fontWeight:
                      FontWeight.w600,color: Colors.black),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height/80.2,),

              Container(
                height: height/14.5818,
                width: width/1.0888,
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffE3EDFF)
                )  ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset(googleImg),
                    Padding(
                      padding:  EdgeInsets.only(left: width/49),
                      child: Text("Sign in with Google",
                        style: GoogleFonts.nunito(
                            fontSize: width/24.5,
                            fontWeight:
                            FontWeight.w600,color: Colors.black),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height/80.2,),

              Container(
                height: height/14.5818,
                width: width/1.0888,
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffE3EDFF)
                )  ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                   Image.asset(chatImg),
                    Padding(
                      padding:  EdgeInsets.only(left:width/49,right: width/39.2),
                      child: Text("Sign up with SMS",
                        style: GoogleFonts.nunito(
                            fontSize: width/24.5,
                            fontWeight:
                            FontWeight.w600,color: Colors.black),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height/53.466,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already  got an account ?",style: GoogleFonts.nunito(fontSize: width/32.666,fontWeight: FontWeight.w600),),
                  Padding(
                    padding:  EdgeInsets.only(left: width/98),
                    child: Text("Login",style: GoogleFonts.nunito(fontSize: width/30.153,fontWeight: FontWeight.w600,color: buttoncolor),),
                  ),

                ],
              ),

              SizedBox(height: height/53.466,),


            ],
          ),
        ),
      ),
    );
  }




  AlumniDatacheckfuntion()async{

    var userdata=await FirebaseFirestore.instance.collection("Users").where("verifyed",isEqualTo:true).where("Phone",isEqualTo: phoneController.text).get();
    print(userdata.docs.length);
    print("Length++++++++++++++++++");
    print(nameController.text);
    print(phoneController.text);
    print("Length++++++++++++++++++__________________________________________________");
    if(userdata.docs.length>0){
      print("Enter_____________++++++++++++");
    setState(() {
    userDocumentID=userdata.docs[0].id;
    });
    // Get.to(Otp_Screen_Page(
    //   name: nameController.text,
    //   phone: phoneController.text,
    //   userDocumentID: userDocumentID,
    // ),
    //     transition: Transition.cupertino,duration: Duration(milliseconds: 200));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Otp_Screen_Page(
      name: nameController.text,
      phone: phoneController.text,
      userDocumentID: userDocumentID,
    ),));

    }
    else{
      userNotVerifyedPopup();
    }

  }

  userNotVerifyedPopup(){

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
                  Text("Sorry!.. You Are Not Alumni Person",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontWeight:
                      FontWeight.w700,color: Color(0xff202244),fontSize: width/21.777),),
                  SizedBox(
                    height: height/53.466,
                  ),
                  Text("Your Account is  Not Ready to Use. You will be Wait Alumni Member",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(fontWeight:
                    FontWeight.w600,color: textcolor,fontSize: width/32.666),),

                ],
              ),
            ),
          );

      },);
  }


}
