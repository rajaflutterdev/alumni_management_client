
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Slider_Screen extends StatefulWidget {
  @override
  _Slider_ScreenState createState() => _Slider_ScreenState();
}

class _Slider_ScreenState extends State<Slider_Screen> {
  int indexValue = 0;
  int _dataLength = 1;

  @override
  void initState() {
    getSliderImageFromDb();
    super.initState();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getSliderImageFromDb() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String,dynamic>> snapshot = await _fireStore.collection('SliderImages').get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot.docs;
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double  width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        if (_dataLength != 0)
          FutureBuilder(
            future: getSliderImageFromDb(),
            builder: (_, AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>> snapShot)  {
              return snapShot.data == null? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  :

              SizedBox(
                height: height / 5.0,
                width: width / 1,
                child: CarouselSlider.builder(
                    itemCount: snapShot.data!.length,
                    itemBuilder: ( context,int index, int) {
                      DocumentSnapshot sliderImage = snapShot.data![index];
                      Map? getImage = sliderImage.data() as Map? ;
                      return
                        Container(
                          height: height / 5.0,
                          width: width / 1.07,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(
                                    getImage!["imgUrl"]
                                ),
                              )

                          ),

                        );
                    },
                    options: CarouselOptions(
                        viewportFraction: 1,
                        initialPage: 0,
                        autoPlay: true,


                        onPageChanged:
                            (int i, carouselPageChangedReason) {
                          setState(() {
                            indexValue = i;
                          });
                        })),
              );
            },
          ),
      ],
    );

  }
}

