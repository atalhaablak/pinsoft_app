import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pinsoft_movie_app/constants/context_extension.dart';
import 'package:pinsoft_movie_app/controller/api_services.dart/api_service.dart';
import 'package:pinsoft_movie_app/screens/detailpage.dart';

class CustomeCarouselHomePage extends StatefulWidget {
  @override
  _CustomeCarouselHomePageState createState() =>
      _CustomeCarouselHomePageState();
}

class _CustomeCarouselHomePageState extends State<CustomeCarouselHomePage> {
  ApiService movieController = ApiService();
  dynamic allList = [];
  bool pageLoad = false;
  Random random = Random();
  int randomNum;
  List<String> sliderMoviesList = [
    "Tenet",
    "Greyhound",
    "Enola Holmes",
    "Extraction"
  ];
  int activeIndex = 0;
  setActiveDot(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  void initState() {
    getSliderMovie();
    super.initState();
  }

  getSliderMovie() async {
    for (int i = 0; i < 4; i++) {
      var res =
          await movieController.getMovieDetail(sliderMoviesList[i].toString());
      if (mounted) {
        allList.add(res);
        setState(() {
          pageLoad = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: context.dynamicMultiWidth(1),
          height: context.dynamicMultiWidth(0.70),
          child: CarouselSlider(
            options: CarouselOptions(
                aspectRatio: 1.0,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setActiveDot(index);
                },
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                autoPlayAnimationDuration: Duration(seconds: 2),
                viewportFraction: 0.5),
            items: allList.map<Widget>((item) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            height: context.dynamicMultiWidth(0.50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                  image:
                                      NetworkImage(item["Poster"].toString()),
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Center(
                                          child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      )),
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.red,
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ));
                                  }),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: context.dynamicMultiHeight(0.02)),
                            child: Text(
                              item["Title"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: context.dynamicMultiWidth(0.045),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(item["Title"].toString())));
                      });
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class ActiveDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 25,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class InactiveDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
