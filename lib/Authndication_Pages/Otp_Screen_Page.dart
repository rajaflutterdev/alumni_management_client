
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../Constant_File.dart';
import '../Landing_Screen/Landing_Screen.dart';

class Otp_Screen_Page extends StatefulWidget {
  String ?name;
  String ?phone;
  String? userDocumentID;
   Otp_Screen_Page({this.name,this.phone,this.userDocumentID});

  @override
  State<Otp_Screen_Page> createState() => _Otp_Screen_PageState();
}

class _Otp_Screen_PageState extends State<Otp_Screen_Page> {


  OtpFieldController otpController = OtpFieldController();
  var _verificationCode;
  String PinValue='';

  double lat = 0.0;
  double lon = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    _verifyphone();
    getLatLng();
    super.initState();
  }


  String _currentAddress="";
  String _currentpincode="";
  Position? _currentPosition;
  TextEditingController name= new TextEditingController();
  TextEditingController area= new TextEditingController();
  TextEditingController pincode= new TextEditingController();
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
                      width: width/1.152941176470588,
                      child: Center(child: Text("Verification code ",style: GoogleFonts.nunito(fontSize: width/22.83333333333333,fontWeight: FontWeight.w800,color: Colors.black),)))
                ],
              ),

              SizedBox(height: width/1.0888,
              child:Lottie.asset(lottieOtpWaiting)
              ),

              Padding(
                padding:  EdgeInsets.only(top: height/53.466),
                child: Text("Verify mobile number",style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,color: Colors.black,
                fontSize: width/21.77
                ),),
              ),
              SizedBox(height: height/53.466,),
              Text("We sent verification code to",style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w600,color: textcolor,
              fontSize: width/26.133
              ),),
              Text("+91${widget.phone} Enter the Code below boxes",style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w600,color: textcolor,
              fontSize: width/26.133
              ),),
              SizedBox(height: height/20.133,),

              OTPTextField(
                controller: otpController,
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: width/9.142,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                otpFieldStyle: OtpFieldStyle(
                  enabledBorderColor: buttoncolor,
                  borderColor: buttoncolor,
                  focusBorderColor: buttoncolor,
                ),

                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                    fontSize: width/23.0588),
                onChanged: (pin) {
                },
                onCompleted: (pin) {
                  setState(() {
                    PinValue=pin;
                  });
                  try{
                    FirebaseAuth.instance.signInWithCredential(
                        PhoneAuthProvider.credential(
                            verificationId:_verificationCode ,
                            smsCode: pin)).then((value){
                      if(value.user!=null){
                        userdata();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context)=>  Landing_Screen(userDocumentID:widget.userDocumentID ,)));
                      }
                    });
                  }
                  catch(e){


                  }
                },
              ),

              SizedBox(height: height/26.7333,),
              GestureDetector(
                onTap: () {
                  try{
                    FirebaseAuth.instance.signInWithCredential(
                        PhoneAuthProvider.credential(
                            verificationId:_verificationCode ,
                            smsCode:PinValue)).then((value) async {
                      if(value.user!=null){
                        userdata();
                        congrationPopup();
                        Future.delayed(Duration(seconds: 2),(){
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Landing_Screen() ,));

                        });

                      }
                    });
                  }
                  catch(e){
                  }

                },
                child: Container(
                  height: height/14.581,
                  width: width/1.1529,
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: buttoncolor
                  )  ,
                  child: Padding(
                      padding:  EdgeInsets.only(left: width/49,right: width/49),
                      child: Center(child:
                      Text("Verify Code",style: GoogleFonts.nunito(fontWeight:
                      FontWeight.w600,color: Colors.white),))
                  ),
                ),
              ),
              SizedBox(height: height/53.466,),
              GestureDetector(
                onTap: (){

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t receive code?",style: GoogleFonts.nunito(fontSize: width/32.666,fontWeight: FontWeight.w600),),
                    Padding(
                      padding:  EdgeInsets.only(left: width/98),
                      child: Text("Resend code",style: GoogleFonts.nunito(fontSize: width/30.1538,fontWeight: FontWeight.w600,color: buttoncolor),),
                    ),

                  ],
                ),
              ),

              SizedBox(height: height/53.466,),

            ],
          ),
        ),
      ),
    );
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
                Text("Congratulations",style: GoogleFonts.nunito(
                    fontWeight:
                FontWeight.w700,color: Color(0xff202244),fontSize: width/21.777),),
                SizedBox(
                  height: height/53.466,
                ),
                Text("Your Account is Ready to Use. You will be \nredirected to the Home Page in a Few Seconds.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(fontWeight:
                FontWeight.w600,color: textcolor,fontSize: width/32.666),),

              ],
            ),
          ),
        );

    },);
  }

  _verifyphone()async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${widget.phone}" ,
        verificationCompleted:(PhoneAuthCredential credential)async{
          await FirebaseAuth.instance.signInWithCredential(credential).then((value)async{
            if(value.user!=null){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=>  Landing_Screen(userDocumentID: widget.userDocumentID,)));
            }
          });
        },
        verificationFailed:(FirebaseAuthException e){

        } ,
        codeSent:(String ?verificationid ,int ?resendtoken ){
          setState(() {
            _verificationCode=verificationid;
          });
        },
        codeAutoRetrievalTimeout:( String verificationid){
          setState(() {
            _verificationCode=verificationid;
          });
        },timeout: const Duration(seconds: 120) );

    //location  function
    //check();

  }

  userdata() async {
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance.collection("Users").doc(widget.userDocumentID).update({
      "Phone":widget.phone,
      "Name":widget.name,
      "Token":token,
      "userDocId":FirebaseAuth.instance.currentUser!.uid,
      "Address":_currentAddress,
      "latitude":lat,
      "longtitude":lon,
      "timestamp":DateTime.now().millisecondsSinceEpoch,
      "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time":DateFormat("hh:mm: a").format(DateTime.now()),
    });

  }

  getLatLng() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude!;
      lon = position.longitude!;
      _currentPosition=position;
    });
    _getAddressFromLatLng(position);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    print("Addressssssssssssssssssssssssssssssssssssssssssssssssssss");
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.postalCode}';
        _currentpincode = '${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

}
