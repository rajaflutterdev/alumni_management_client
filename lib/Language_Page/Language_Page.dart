import 'package:alumni_management_client/Constant_File.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Landing_Screen/Landing_Screen.dart';
import '../Translator_Module/Translator_Module_Page.dart';

class Languages_Page extends StatefulWidget {

  @override
  State<Languages_Page> createState() => _Languages_PageState();
}

class _Languages_PageState extends State<Languages_Page> {
  List<LanguageModel> languagesList = [
    LanguageModel(
      name: "Tamil",
      orgName: "தமிழ்",
      code: "ta",
    ),
    LanguageModel(
      name: "English",
      orgName: "English",
      code: "en_US",
    ),
    LanguageModel(
      name: "Hindi",
      orgName: "हिंदी",
      code: "hi",
    ),
    LanguageModel(
      name: "Telugu",
      orgName: "తెలుగు",
      code: "te",
    ),
    LanguageModel(
      name: "Malayalam",
      orgName: "മലയാളം",
      code: "ml",
    ),
    LanguageModel(
      name: "Kannada",
      orgName: "ಕನ್ನಡ",
      code: "kn",
    ),
    LanguageModel(
      name: "Bengali",
      orgName: "বাংলা",
      code: "bn",
    ),
    LanguageModel(
      name: "Gujarati",
      orgName: "ગુજરાતી",
      code: "Gujarath",
    ),
    LanguageModel(
      name: "Urdu",
      orgName: "اُردُو",
      code: "Urdu",
    ),
    LanguageModel(
      name: "Odia",
      orgName: "ଓଡ଼ିଆ",
      code: "Odia",
    ),
    LanguageModel(
      name: "Assamese",
      orgName: "ଓଡ଼ିଆ",
      code: "Assamese",
    ),
    LanguageModel(
      name: "Maithili",
      orgName: "Macushi",
      code: "Maithili",
    ),
    LanguageModel(
      name: "Sanskrit",
      orgName: "संस्कृतम्",
      code: "Sanskrit",
    ),
    LanguageModel(
      name: "Punjabi",
      orgName: "ਪੰਜਾਬੀ",
      code: "Punjabi",
    ),
    LanguageModel(
      name: "Punjabi",
      orgName: "ਪੰਜਾਬੀ",
      code: "Punjabi",
    ),
    LanguageModel(
      name: "Marathi",
      orgName: "मराठी",
      code: "Marathi",
    ),
  ];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F5F5),
        elevation: 0,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.only(left: width / 102.857),
                child: const Icon(Icons.arrow_back),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: width / 27.428),
              child: SizedBox(
                height: height/35.062,
                width:width/1.418,
                child:  FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.centerLeft,
                  child: KText(
                    text: 'Select Your Language',
                    style:
                    GoogleFonts.nunito(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        fontSize: width/19.6,
                        letterSpacing: 0.3),
                  ),
                ),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: height / 9.59,
      ),
      body: SafeArea(
          child: Stack(
            children: [


              SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  children: [

                    Expanded(
                      child: SizedBox(
                          width: double.infinity,
                          child: GridView.builder(
                            itemCount: languagesList.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 26 / 20),
                            itemBuilder: (BuildContext cxt, int i) {
                              return Padding(
                                padding:  EdgeInsets.symmetric(
                                    horizontal: width/78.4, vertical: height/100.25),
                                child: InkWell(
                                  splashColor: Colors.white,
                                   highlightColor: Colors.white,
                                  onTap: (){
                                       setState(() {
                                         changeLocale(cxt, languagesList[i].code!);
                                         languaeName=languagesList[i].name!;
                                       });


                                    Navigator.pop(context);
                                  },
                                  child: Material(
                                    elevation: 5,
                                    shadowColor: Colors.black12,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      height: height/10.957,
                                      width: width/5.142,
                                      decoration: BoxDecoration(
                                        gradient:  LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [buttoncolor, msgContentTextColor.withOpacity(0.8)],
                                        ),
                                        borderRadius: BorderRadius.circular(12),

                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            languagesList[i].orgName!,
                                            style:
                                            GoogleFonts.nunito(
                                                fontWeight: FontWeight.w700,
                                                color:Colors.white,
                                                fontSize: width/20.824,
                                                letterSpacing: 0.3)
                                          ),
                                           SizedBox(height: height/175.30),
                                          Text(
                                            languagesList[i].name!.toUpperCase(),
                                            style:
                                            GoogleFonts.nunito(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: width/26.824,
                                                letterSpacing: 0.3)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class LanguageModel {
  LanguageModel({this.name, this.code, this.orgName});

  String? name;
  String? orgName;
  String? code;
}