
import "dart:convert";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";
import "package:http/http.dart" as http;
import "../Constant_File.dart";
import "../Translator_Module/Translator_Module_Page.dart";

class Group_Chat_Screen extends StatefulWidget {
  String?Docid;
  String?groupImg;
  String?groupdepart;
  String?grouppassesyear;
   Group_Chat_Screen({this.groupImg,this.groupdepart,this.grouppassesyear,this.Docid});

  @override
  State<Group_Chat_Screen> createState() => _Group_Chat_ScreenState();
}

class _Group_Chat_ScreenState extends State<Group_Chat_Screen> {


  ScrollController _scrollController = new ScrollController();

  final TextEditingController msgController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const SizedBox(),
        toolbarHeight: height/10.025,
        flexibleSpace: Material(
          elevation:15,
          color: Color(0xffFFFFFF),
          //color: Colors.red,
          shadowColor: Colors.black12,
          child: Container(
              height: height/10.025,
              width:double.infinity,
              margin: EdgeInsets.only(top: height/16.04),
              decoration: BoxDecoration(
                  color:Color(0xffFFFFFF),
                  //  color: Colors.red,
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
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding:  EdgeInsets.only(left: width/39.2,right: width/39.2),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    Container(
                      height: height/16.04,
                      width: width/7.84,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            image: NetworkImage(widget.groupImg.toString()),

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
                            child:  KText(
                              text:widget.groupdepart.toString(),
                              style: GoogleFonts.nunito(
                                  fontSize: width/26.1333,
                                  color: Color(0xff000000),
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
                              text:"${widget.grouppassesyear.toString()}",
                              style: GoogleFonts.nunito(
                                  fontSize: width/30.153,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff000000),
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
      ),
      body: Container(
        height: height/1,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            image: DecorationImage(

              image: AssetImage(backgroudPattern,),
            )
        ),
        child: SingleChildScrollView(
          reverse: true,
          child:
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Groups").doc(widget.Docid).
            collection('Messages').orderBy("timestamp").snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      reverse: true,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {

                            var messagedata=snapshot.data!.docs[index];
                            return Padding(
                              padding:  EdgeInsets.only(
                                top: height/82.125,
                                bottom:height/82.125,
                              ),
                              child: Container(
                                margin:
                                messagedata['From']=="Client"?
                                EdgeInsets.only(right: width/39.2):
                                EdgeInsets.only(left: width/39.2),
                                child: messagedata['From']=="Client"?
                                Align(
                                  alignment:  Alignment.topRight,
                                  child: Material(
                                    color: msgContentTextColor,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        topRight: Radius.circular(5),
                                        topLeft: Radius.circular(15)
                                    ),
                                    elevation:6,
                                    child: Container(
                                      decoration:  BoxDecoration(
                                          color: msgContentTextColor,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                              topRight: Radius.circular(8),
                                              topLeft: Radius.circular(8)
                                          )
                                      ),
                                      padding: EdgeInsets.only(
                                          top: height/75.9,
                                          bottom: height/75.9,
                                          left: width/39.2,
                                          right: width/39.2
                                      ),

                                      child:  KText(
                                        text:messagedata['Message'].toString(),
                                        style:GoogleFonts.nunito(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize:width/24.5,),),

                                    ),
                                  ),
                                ):
                                Align(
                                  alignment:  Alignment.topLeft,
                                  child: Material(
                                    elevation:10,
                                    color:Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(12),
                                        topRight: Radius.circular(8),
                                        topLeft: Radius.circular(8)
                                    ),

                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color:Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(12),
                                              topRight: Radius.circular(8),
                                              topLeft: Radius.circular(8)
                                          )
                                      ),
                                      padding: EdgeInsets.only(
                                          top: height/75.9,
                                          bottom: height/75.9,
                                          left: width/39.2,
                                          right: width/39.2
                                      ),
                                      child: Column(
                                        children: [
                                          KText(
                                            text:messagedata['Message'].toString(),
                                            style:GoogleFonts.nunito(color: Colors.black,
                                                fontSize:width/24.5,
                                                fontWeight: FontWeight.w600
                                            ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: height / 10.18,
                    )
                  ],
                );
              }return Container();
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding:  EdgeInsets.only(right:width/19.6),
            child: Material(
              elevation:5,
              color: const Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: height/15.04,
                width: width/1.3517,
                decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width/39.2,right: width/39.2
                  ),
                  child:
                  TextField(
                    controller: msgController,
                    style: GoogleFonts.nunito(
                        color: textcolor,
                        fontWeight: FontWeight.w600
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:'Write a message',
                      hintStyle: GoogleFonts.nunito(
                          color: textcolor,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap:(){
              print(widget.Docid);
              if(msgController.text!=""){
                GroupmessageCreateFuntion();
              }

            },
            child: Material(
              elevation:5,
              color: const Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: height/15.7083,
                width: width/7.8,
                decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(100)
                ),
                padding: EdgeInsets.symmetric
                  (
                    vertical: height/100.25,
                    horizontal: width/49
                ),
                child: Image.asset(sendImg),
              ),
            ),
          )
        ],
      ),
    );
  }


  GroupmessageCreateFuntion() async {
    FirebaseFirestore.instance.collection("Groups").doc(widget.Docid).collection("Messages").doc().set({
      "Message": msgController.text,
      "time": DateFormat('hh:mm a').format(DateTime.now()),
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "From": "Client",
      "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
    });
    var Userdata=await FirebaseFirestore.instance.collection("Users").get();
    for(int x=0;x<Userdata.docs.length;x++){
      if(Userdata.docs[x]['subjectStream']==widget.groupdepart){
        if(Userdata.docs[x]['yearofpassed']==widget.grouppassesyear){

          sendPushMessage(
              body:msgController.text ,
              title: "${Userdata.docs[x]['subjectStream']}-${Userdata.docs[x]['yearofpassed']} New Message",
              token:Userdata.docs[x]['Token'].toString() );
          FirebaseFirestore.instance.collection("Users").doc(Userdata.docs[x].id).collection("Groups").doc()
              .set({
            "Message": msgController.text,
            "time": DateFormat('hh:mm a').format(DateTime.now()),
            "timestamp": DateTime.now().millisecondsSinceEpoch,
            "From": "Client",
            "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
          });


        }
      }
    }
    msgController.clear();
  }

  void sendPushMessage({required String token, required String body, required String title}) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key=AAAAMbpijGg:APA91bGJh2qke8JHGkBaJvJ5-mSnllb0aAIi-lF2YKt9MejKB-m51-SQZJR2u3tYdC9UsOB0ps_G6n29EuZPGFW5xAp4lHQDFWi11TFSDn65VyXYyFY0c-SzXuwk2fE31ADp9MdryFBB',        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );

    } catch (e) {
      print("error push notification");
    }
  }

}
