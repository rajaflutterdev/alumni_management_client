import 'package:alumni_management_client/Constant_File.dart';
import 'package:alumni_management_client/Language_Page/Language_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../About_Page/About_Page.dart';
import '../Apply_For-Job_Post/Apply_For-Job_Post.dart';
import '../Authndication_Pages/Login_Screen.dart';
import '../Slders_screen/Slider_Screen.dart';
import '../Translator_Module/Translator_Module_Page.dart';


class Home_Screen extends StatefulWidget {
  String?Username;
  String?UserAuthID;
   Home_Screen({this.Username,this.UserAuthID});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> with SingleTickerProviderStateMixin{


  @override
  void initState() {
    tabController=TabController(length: 3, vsync: this)  ;
    registerUserfunc();
    AppliedJobPost();
    // TODO: implement initState
    super.initState();
  }

  TabController?tabController;
  int selectTabIndex=0;

  List registerEventsList=[];

  List <regsiterUser> previousregisterEventsList=[];
  List <JOBAppliedUser> jobpostAppliedList=[];


  registerUserfunc() async {
    setState(() {
      previousregisterEventsList.clear();
    });
    var registerUserData=await FirebaseFirestore.instance.collection("Batch_events").orderBy("timestamp").get();

    for(int x=0;x<registerUserData.docs.length;x++){
      for(int  j=0;j<registerUserData.docs[x]['registeredUsers'].length;j++){
        setState(() {
          previousregisterEventsList.add(
            regsiterUser(
              StreamDocID:registerUserData.docs[x].id ,
              UserId: registerUserData.docs[x]['registeredUsers'][j]
            )
          );
        });
      }
    }
    
  }
  
  
  AppliedJobPost()async{

    setState(() {
      jobpostAppliedList.clear();
    });

    var data=await FirebaseFirestore.instance.collection("JobPosts").orderBy("timestamp").get();

    for(int x=0;x<data.docs.length;x++){
      for(int  j=0;j<data.docs[x]['registeredUsers'].length;j++){
        setState(() {
          jobpostAppliedList.add(
              JOBAppliedUser(
                  StreamDocID:data.docs[x].id ,
                  UserId: data.docs[x]['registeredUsers'][j]
              )
          );
        });
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return   Padding(
      padding:  EdgeInsets.only(left: width/39.2,right: width/39.2),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: height/40.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                         "${landingQuote1} ${widget.Username.toString()}👋",style: GoogleFonts.nunito(
                          fontSize: width/16.6,
                          fontWeight: FontWeight.w700),),
                      SizedBox(
                        width:width/1.3,
                        child: FittedBox(
                          child: KText(
                            text:"${landingQuote2}",style: GoogleFonts.nunito(
                              fontSize: width/22.5,
                              fontWeight: FontWeight.w700),),
                        ),
                      ),
                    ],
                  ),
        
                  GestureDetector(
                    onTap: (){
                      showMenuList(context);
                    },
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(5),
                      color: buttoncolor,
                      child: Container(
                        height: height/20.05,
                        width: width/9.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: buttoncolor,
                        ),
                        child: const Icon(Icons.settings,color: Colors.white,),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: height/53.466,),
            SizedBox(
              height: height / 5.0,
              width: width/1.0888,
              child: Slider_Screen(),
            ),
            SizedBox(height: height/53.466,),
            TabBar(
              controller: tabController,
              labelColor: Colors.black,
              dividerColor: Colors.transparent,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: buttoncolor,
              physics: const BouncingScrollPhysics(),
              indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: 0, vertical: 0),
              labelPadding: const EdgeInsets.all(0),
              splashBorderRadius: BorderRadius.zero,
              splashFactory: NoSplash.splashFactory,
              labelStyle: GoogleFonts.nunito(
                fontSize: width/25.714,
                fontWeight: FontWeight.w800,
              ),
              unselectedLabelStyle: GoogleFonts.nunito(
                  color: const Color(0xff4E4B66)
              ),
              onTap: (index){
                setState(() {
                  selectTabIndex = index;
                });
              },
              tabs: [
                Tab(
                  child:    KText(
                      text:"Collage Activities",style:GoogleFonts.nunito(
                    fontWeight: FontWeight.w600
                  )),
                ),
                Tab(
                  child:   KText(
                      text:"Batch Events",style:GoogleFonts.nunito( fontWeight: FontWeight.w600)),
                ),
                Tab(
                  child:   KText(
                      text:"Job Posts",style:GoogleFonts.nunito( fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            SizedBox(
              height:height/1.008,
              child: TabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
        
                  ///College activities Stream Builder
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("ColleageActivities")
                          .orderBy("timestamp").snapshots(),
                    builder:(context, snapshot) {
        
                        if(!snapshot.hasData){
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        if(snapshot.hasData==null){
                          return const Center(child: CircularProgressIndicator(),);
                        }
        
                        return ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var clgActivitied=snapshot.data!.docs[index];
                            return
                              GestureDetector(
                                onTap:(){
                                  streamDetailsPopup(
                                    contentImg:clgActivitied['img'],
                                    contentTime: clgActivitied['uploadTime'],
                                    contentSubtitle: clgActivitied['subtitle'],
                                    contentTitle: clgActivitied['title'],
                                    StreamName: "College Activities",
                                    contectDocID: clgActivitied.id
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
                                                      image: NetworkImage(clgActivitied['img'].toString())
                                                  )
                                              ),
                                            ),
        
                                            Padding(
                                              padding:  EdgeInsets.only(left:width/49),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: width/1.6333,
                                                    height: height/40.1,
                                                    child:  KText(
                                                      text:clgActivitied['title'].toString(),
                                                      style: GoogleFonts.nunito(
                                                          fontSize: width/30.153,
                                                          fontWeight: FontWeight.w700,
                                                          color: ItemTitleColor,
                                                          textStyle: TextStyle(
                                                              overflow: TextOverflow.ellipsis
                                                          )
                                                      ),),
                                                  ),
        
                                                  SizedBox(
                                                    width: width/1.6333,
                                                    height:height/19.095,
                                                    child:  KText(
                                                      text:clgActivitied['subtitle'].toString(),
                                                      style: GoogleFonts.nunito(
                                                          fontSize: width/28,
                                                          fontWeight: FontWeight.w700,
                                                          textStyle: TextStyle(
                                                            //  overflow: TextOverflow.ellipsis,
                                                          )
                                                      ),),
                                                  ),
        
                                                  SizedBox(
                                                    width: width/1.6333,
                                                    height: height/40.1,
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.access_time_sharp,size: width/26.1333,color: ItemTitleColor,),
                                                        Padding(
                                                          padding:  EdgeInsets.only(left: width/196),
                                                          child:  KText(
                                                            text:
                                                              clgActivitied['uploadTime'].toString(),
                                                            style: GoogleFonts.nunito(
                                                                fontSize: width/30.153,
                                                                fontWeight: FontWeight.w700,
                                                                color: ItemTitleColor,
                                                                textStyle: TextStyle(
                                                                    overflow: TextOverflow.ellipsis
                                                                )
                                                            ),),
                                                        ),
                                                      ],
                                                    ),
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
                      }, ),
        
                  ///Batch Events
        
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Batch_events")
                        .orderBy("timestamp").snapshots(),
                    builder:(context, snapshot) {
        
                      if(!snapshot.hasData){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.hasData==null){
                        return const Center(child: CircularProgressIndicator(),);
                      }
        
                      return ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
        
                          var clgActivitied=snapshot.data!.docs[index];
                          return  GestureDetector(
                            onTap:(){
                              streamDetailsPopup(
                                  contentImg:clgActivitied['img'],
                                  contentTime: clgActivitied['uploadTime'],
                                  contentSubtitle: clgActivitied['subtitle'],
                                  contentTitle: clgActivitied['title'],
                                  StreamName: "Batch Events",
                                  contectDocID: clgActivitied.id
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
                                                  image: NetworkImage(clgActivitied['img'].toString())
                                              )
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left:width/49),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                               width: width/1.6333,
                                                height: height/40.1,
                                                child:  KText(
                                                  text:clgActivitied['title'].toString(),
                                                  style: GoogleFonts.nunito(
                                                      fontSize: width/30.153,
                                                      fontWeight: FontWeight.w700,
                                                      color: ItemTitleColor,
                                                      textStyle: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      )
                                                  ),),
                                              ),
        
                                              SizedBox(
                                               width: width/1.6333,
                                                height:height/19.095,
                                                child:  KText(
                                                  text:clgActivitied['subtitle'].toString(),
                                                  style: GoogleFonts.nunito(
                                                      fontSize: width/28,
                                                      fontWeight: FontWeight.w700,
                                                      textStyle: TextStyle(
                                                        //  overflow: TextOverflow.ellipsis,
                                                      )
                                                  ),),
                                              ),
        
                                              SizedBox(
                                               width: width/1.6333,
                                                height: height/40.1,
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.access_time_sharp,size: width/26.1333,color: ItemTitleColor,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left: width/196),
                                                      child:  KText(
                                                        text:clgActivitied['uploadTime'].toString(),
                                                        style: GoogleFonts.nunito(
                                                            fontSize: width/30.153,
                                                            fontWeight: FontWeight.w700,
                                                            color: ItemTitleColor,
                                                            textStyle: TextStyle(
                                                                overflow: TextOverflow.ellipsis
                                                            )
                                                        ),),
                                                    ),
                                                  ],
                                                ),
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
                    }, ),
        
                  ///Job Posts Stream
        
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("JobPosts").orderBy("timestamp").snapshots(),
                    builder:(context, snapshot) {
        
                      if(!snapshot.hasData){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.hasData==null){
                        return const Center(child: CircularProgressIndicator(),);
                      }
        
                      return ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          var clgActivitied=snapshot.data!.docs[index];

                          if(clgActivitied['verify']==true){

                            return GestureDetector(
                                onTap:(){
                                  streamDetailsPopup(
                                      contentImg:clgActivitied['img'],
                                      contentTime: clgActivitied['uploadTime'],
                                      contentSubtitle: clgActivitied['subtitle'],
                                      contentTitle: clgActivitied['title'],
                                      StreamName: "Job Posts",
                                      contectDocID: clgActivitied.id,
                                      quvalification: clgActivitied['quvalification'],
                                      location: clgActivitied['location'],
                                      position: clgActivitied['positions']
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
                                                      image: NetworkImage(clgActivitied['img'].toString())
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left:width/49),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: width/1.6333,
                                                    height: height/40.1,
                                                    child:  KText(
                                                      text:clgActivitied['title'].toString(),
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
                                                    width: width/1.6333,
                                                    height:height/19.095,
                                                    child:  KText(
                                                      text:clgActivitied['subtitle'].toString(),
                                                      style: GoogleFonts.nunito(
                                                          fontSize: width/28,
                                                          fontWeight: FontWeight.w700,
                                                          textStyle: const TextStyle(
                                                            //  overflow: TextOverflow.ellipsis,
                                                          )
                                                      ),),
                                                  ),

                                                  SizedBox(
                                                    width: width/1.6333,
                                                    height: height/40.1,
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.access_time_sharp,size: width/26.1333,color: ItemTitleColor,),
                                                        Padding(
                                                          padding:  EdgeInsets.only(left: width/196),
                                                          child:  KText(
                                                            text:clgActivitied['uploadTime'].toString(),
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
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              );

                          }
                        },
        
                      );
                    }, ),
        
                ],
              ),
            ),
            SizedBox(height: height/32.08,),
        
          ],
        ),
      ),
    );
  }


  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    return "just now";
  }

  void showMenuList(cnt) async {
    await showMenu(
      context: cnt,
      color: Colors.white,
      shadowColor: buttoncolor.withOpacity(0.7),
      position: RelativeRect.fromLTRB(200, 130, 10, 100),
      items: [
         PopupMenuItem(
           textStyle: GoogleFonts.nunito(
             fontWeight: FontWeight.w700,
           ),
          onTap: (){

             // Get.to(Languages_Page(),
             // curve: Curves.easeIn,
             //   duration: Duration(milliseconds: 500),
             //   transition: Transition.circularReveal
             // );
             Navigator.push(context, MaterialPageRoute(builder: (context) =>Languages_Page() ,));
          },
          value: 1,
          child:  KText(
            text:
            "Language",
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
         PopupMenuItem(
           textStyle: GoogleFonts.nunito(
             fontWeight: FontWeight.w700,
           ),
          onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => const About_Page(),));
          },
          value: 2,
          child:  KText(
            text:
            "About",
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.w700,
            ),

          ),
        ),
         PopupMenuItem(
           textStyle: GoogleFonts.nunito(
             fontWeight: FontWeight.w700,
           ),
          onTap: (){
            siginoutpopup();
          },
          value: 3,
          child:  KText(
            text:
            "Log Out",
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.w700,
            ),

          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) print(value);
    });
  }


  streamDetailsPopup({contentImg,contentTitle,contentSubtitle,contentTime,StreamName,contectDocID,location,quvalification,position}){

    bool registered=false;
    bool AppliedJobUser=false;
    setState(() {
    registerEventsList.clear();
    registered=false;
    AppliedJobUser=false;
    });


   if(StreamName=="Job Posts"){

     print("11111111111111111111111111111111111111111111111111111111111111111111111");
     jobpostAppliedList.forEach((element) {
       if(element.StreamDocID==contectDocID){
         if(element.UserId==widget.UserAuthID){
           setState(() {
             AppliedJobUser=true;
           });
         }
       }
     });
   }
   else{
     previousregisterEventsList.forEach((element) {
       if(element.StreamDocID==contectDocID){
         if(element.UserId==widget.UserAuthID){
           setState(() {
             registered=true;
           });
         }
       }
     });
   }

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return showDialog(context: context,
      barrierColor: Colors.transparent,
      builder: (context){
        return
          Padding(
            padding:  EdgeInsets.only(top: StreamName=="Job Posts"?height/7.5:height/6.0,bottom:  StreamName=="Job Posts"?height/7.5:height/6.0),
            child: AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KText(
                    text: StreamName.toString(),
                    style: GoogleFonts.nunito(
                        fontWeight:
                        FontWeight.w700,color: Color(0xff202244),fontSize: width/21.777),),
                ],
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height/5.8,
                    width: width/2.8,
                    child:
                        contentImg==""?
                    Image.asset(EmptyImg,fit: BoxFit.contain,):
                    Image.network(contentImg.toString(),fit: BoxFit.contain,),
                  ),
                  SizedBox(
                    height: height/53.466,
                  ),

                  SizedBox(
                    width:width/1.6333,
                    child:  Center(
                      child: Text(
                         contentTitle.toString(),
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                          ),
                            fontWeight:
                            FontWeight.w700,color: Color(0xff202244),fontSize: width/21.777),),
                    ),
                  ),

                  Container(
                    height: height/10.04,
                    width:width/1.6333,
                    color:Colors.transparent,
                    child:  Text(
                      "Description: ${contentSubtitle.toString()}",
                      style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            //overflow: TextOverflow.ellipsis
                          ),
                          fontWeight:
                      FontWeight.w700,color: textcolor,fontSize: width/32.666),),
                  ),

                  StreamName=="Job Posts"?
                  SizedBox(
                    width:width/1.6333,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Qualification : ${quvalification.toString()}",
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                //overflow: TextOverflow.ellipsis
                              ),
                              fontWeight:
                              FontWeight.w700,color: textcolor,fontSize: width/32.666),),
                        Text(
                          "Position : ${position.toString()}",
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                //overflow: TextOverflow.ellipsis
                              ),
                              fontWeight:
                              FontWeight.w700,color: textcolor,fontSize: width/32.666),),
                        Text(
                          "Location : ${location.toString()}",
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                //overflow: TextOverflow.ellipsis
                              ),
                              fontWeight:
                              FontWeight.w700,color: textcolor,fontSize: width/32.666),),
                      ],
                    ),
                  ):const SizedBox(),


                  Padding(
                    padding:  EdgeInsets.only(top: height/70.25,bottom: height/70.25),
                    child:  Text(
                       "Upload Time : ${contentTime.toString()}",
                      style: GoogleFonts.nunito(fontWeight:
                      FontWeight.w700,color: textcolor,fontSize: width/32.666),),
                  ),
                  StreamName=="Batch Events"&&
                      registered==true?
                  GestureDetector(
                   onTap: (){
                     Navigator.pop(context);
                   },
                    child: Material(
                      elevation: 5,
                      shadowColor: Colors.indigo,
                      borderRadius: BorderRadius.circular(5),
                      color: buttoncolor,
                      child: Container(
                        height:height/20.05,
                        width: width/1.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: buttoncolor,
                        ),
                        child: Center(
                          child:  Text(" Your Already Register this Events",
                            style: GoogleFonts.nunito(fontWeight:
                            FontWeight.w800,color: Colors.white,fontSize: width/28.666),),
                        ),

                      ),
                    ),
                  ):
                  StreamName=="Batch Events"?
                  GestureDetector(
                    onTap: (){
                      registerEventsList.add(widget.UserAuthID.toString());
                      FirebaseFirestore.instance.collection("Batch_events").doc(contectDocID).update({
                        "registeredUsers":registerEventsList
                      });
                      registerUserfunc();
                      Navigator.pop(context);
                      registerSuccessFullpopup();

                    },
                    child: Material(
                      elevation: 5,
                      shadowColor: Colors.indigo,
                      borderRadius: BorderRadius.circular(55),
                      color: buttoncolor,
                      child: Container(
                        height:height/20.05,
                        width: width/3.2666,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(55),
                          color: buttoncolor,
                        ),
                        child: Center(
                          child:  Text("Book Events",
                            style: GoogleFonts.nunito(fontWeight:
                            FontWeight.w800,color: Colors.white,fontSize: width/26.666),),
                        ),

                      ),
                    ),
                  ):
                  StreamName=="Job Posts"&&AppliedJobUser==true?
                  GestureDetector(

                   onTap: (){
                     Navigator.pop(context);
                   },
                    child: Material(
                      elevation: 5,
                      shadowColor: Colors.indigo,
                      borderRadius: BorderRadius.circular(55),
                      color: buttoncolor,
                      child: Container(
                        height:height/20.05,
                        width: width/2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(55),
                          color: buttoncolor,
                        ),
                        child: Center(
                          child:  Text("Applied this Job",
                            style: GoogleFonts.nunito(fontWeight:
                            FontWeight.w800,color: Colors.white,fontSize: width/26.666),),
                        ),

                      ),
                    ),
                  ):
                  GestureDetector(
                    onTap: (){
                      AppliedJobPost();
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>Apply_For_Job_Post(
                        DocumentId: contectDocID,
                        CompanyName: contentTitle,
                        CompanydesCription: contentSubtitle,
                        Companypositions: position,
                        AuthID: widget.UserAuthID.toString(),
                      ) ,));

                    },
                    child:
                    Material(
                      elevation: 5,
                      shadowColor: Colors.indigo,
                      borderRadius: BorderRadius.circular(55),
                      color: buttoncolor,
                      child: Container(
                        height:height/20.05,
                        width: width/3.2666,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(55),
                          color: buttoncolor,
                        ),
                        child: Center(
                          child:  Text("Apply for Job",
                            style: GoogleFonts.nunito(fontWeight:
                            FontWeight.w800,color: Colors.white,fontSize: width/26.666),),
                        ),

                      ),
                    ),
                  )

                ],
              ),
            ),
          );

      },);
  }


  Future<void> siginoutpopup() async {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding:  EdgeInsets.only(top:15),
            child: KText(
              text:"Are You Want To Logout",
              align:  TextAlign.center,
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: width / 23,
              ),
            ),
          ),
          content: SizedBox(
            height: height / 3.8,
            child: Column(
              children: [
                Container(
                    height: height/5.2,
                    color:Colors.transparent,
                    child:Lottie.asset(LogOutLottie)),
                Padding(
                  padding: EdgeInsets.only(left: width / 45,top:height/86.6),
                  child: GestureDetector(
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LogIn_Screen(),));
                    },
                    child: Container(

                      height: height/24.0,
                      width: width/5.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: buttoncolor,
                      ),
                      child: Center(
                        child: KText(
                          text: "Yes",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width / 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          titlePadding: EdgeInsets.symmetric(
              horizontal: width / 45, vertical: height / 94.5),
        );
      },
    );
  }


  registerSuccessFullpopup() async {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding:  EdgeInsets.only(top:15),
            child: KText(
              text:"Register Submitted Successfully...",
              align:  TextAlign.center,
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: width / 23,
              ),
            ),
          ),
          content: SizedBox(
            height: height / 3.8,
            child: Column(
              children: [
                Container(
                    height: height/5.2,
                    color:Colors.transparent,
                    child:Lottie.asset(successLottie)),
                Padding(
                  padding: EdgeInsets.only(left: width / 45,top:height/86.6),
                  child: GestureDetector(
                    onTap: (){
                    Navigator.pop(context);
                    },
                    child: Container(

                      height: height/24.0,
                      width: width/5.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: buttoncolor,
                      ),
                      child: Center(
                        child: KText(
                          text: "Okay",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width / 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          titlePadding: EdgeInsets.symmetric(
              horizontal: width / 45, vertical: height / 94.5),
        );
      },
    );
  }


}

class regsiterUser{
  String ?UserId;
  String?StreamDocID;
  regsiterUser({this.StreamDocID,this.UserId});

}

class JOBAppliedUser{
  String ?UserId;
  String?StreamDocID;
  JOBAppliedUser({this.StreamDocID,this.UserId});

}
