import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Constant_File.dart';
import 'Translator_Module/Translator_Module_Page.dart';

class Your_Job_Screen_2 extends StatefulWidget {

  List? AppliedUserList;
  String ?appliedDate;
  String ?appliedtime;
  String ?comapanyDescription;
  String ?comopanyName;
  String ?positions;
  String ?documentId;
   Your_Job_Screen_2({this.AppliedUserList,this.positions,this.comopanyName,this.appliedDate,
     this.documentId,
     this.appliedtime,this.comapanyDescription});

  @override
  State<Your_Job_Screen_2> createState() => _Your_Job_Screen_2State();
}

class _Your_Job_Screen_2State extends State<Your_Job_Screen_2> {


  @override
  void initState() {
    AppliedUSerFuntion();
    // TODO: implement initState
    super.initState();
  }



  List <AppliedUserData> dynamicUser=[];

  String FirebaseDocumentUrl='';

  AppliedUSerFuntion()async{

    print(widget.documentId);
    print("Documeneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    for(int i=0;i<widget.AppliedUserList!.length;i++){
      var Userdata=await FirebaseFirestore.instance.collection("Users").doc(widget.AppliedUserList![i]).get();
      Map<String,dynamic>?value=Userdata.data();
      setState(() {
        dynamicUser.add(
          AppliedUserData(
            department: value!['subjectStream'],
            Name: value['Name'],
            Batch: value['yearofpassed'],
            Profile: value['UserImg'],
          )
        );
      });
      var Userdata2=await FirebaseFirestore.instance.collection("Users").doc(widget.AppliedUserList![i]).collection("Applied_Jobs").
      where("announceposition",isEqualTo: widget.positions).where("announcecmpname",isEqualTo: widget.comopanyName).get();

      for(int k=0;k<Userdata2.docs.length;k++){
        print(Userdata2.docs[k].id);
        print("lopp[ KKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
      setState(() {
        FirebaseDocumentUrl= Userdata2.docs[k]["document"];
      });
      }
    }

    print(dynamicUser.length);
    print(FirebaseDocumentUrl);
    print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");

  }


  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title:   KText(
          text:" Applied Job User Lists",style: GoogleFonts.nunito(
            fontSize: width/19.6,
            fontWeight: FontWeight.w700),),
      ),
      body: Column(
        children: [
          dynamicUser.length>0?
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: dynamicUser.length,
            itemBuilder: (context, index) {

              var data =dynamicUser[index];
            return Padding(
              padding:  EdgeInsets.only(bottom:4),
              child: GestureDetector(
                onTap: (){
                  
                  
                  
                  
                  
                  appliedCompanyDetailsPopup(
                    appliedDate: widget.appliedDate.toString(),
                    appliedtime: widget.appliedtime.toString(),
                    comapanyDescription:widget.comapanyDescription.toString(),
                    comopanyName: widget.comopanyName.toString(),
                    positions: widget.positions.toString()
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
                              height: height/10.6933,
                              width: width/5.226,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(data.Profile.toString())
                                  )
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left:width/49),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  const SizedBox(height: 5,),

                                  SizedBox(
                                    width: width/1.7,
                                    height:height/35.095,
                                    child:  KText(
                                      text:"Name : ${data.Name.toString()}",
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
                                    height:height/35.095,
                                    child:  KText(
                                      text:"Department : ${data.department.toString()}",
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
                                    height:height/35.095,
                                    child:  KText(
                                      text:"Batch : ${data.Batch.toString()}",
                                      style: GoogleFonts.nunito(
                                          fontSize: width/28,
                                          fontWeight: FontWeight.w700,
                                          textStyle: const TextStyle(
                                            //  overflow: TextOverflow.ellipsis,
                                          )
                                      ),),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              ),
            );

          },):Center(
            child: SizedBox(
                height: 600,
                width:150,
                child: Center(
                  child: Text("No Applied Users",style: GoogleFonts.nunito(fontWeight: FontWeight.w700),),
                )

            ),

          ),
        ],
      ),
    );
  }

  appliedCompanyDetailsPopup({comopanyName,comapanyDescription,appliedDate,appliedtime,positions,}) async {


    var jobpost =await FirebaseFirestore.instance.collection("JobPosts").doc(widget.documentId).collection("Applied_Jobs").doc().get();
    
    return showDialog(context: context, builder: (context) {

      return Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 80,bottom: 80),
          child:
          Scaffold(
            body:  Container(
              height: 560,
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
                        child: Text("Total Applied Alumna's : ${widget.AppliedUserList!.length.toString()}",style: GoogleFonts.nunito(fontWeight: FontWeight.w600),),
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
                       launch(FirebaseDocumentUrl);
                    },
                    child: Container(
                        height: 70,
                        width: 280,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: buttoncolor
                            ),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(DocuemntImg,height: 60,width: 60,),

                            Text("Download Your Doc..",style: GoogleFonts.nunito(fontWeight: FontWeight.w700,color: Colors.black),)
                          ],
                        )
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


class AppliedUserData{
  String ?Name;
  String ?Batch;
  String ?department;
  String? Profile;
  AppliedUserData({this.department,this.Name,this.Batch,this.Profile});

}
