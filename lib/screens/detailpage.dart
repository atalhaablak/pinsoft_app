import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pinsoft_movie_app/constants/color_constant.dart';
import 'package:pinsoft_movie_app/constants/context_extension.dart';
import 'package:pinsoft_movie_app/constants/icon_constant.dart';
import 'package:pinsoft_movie_app/controller/api_services.dart/api_service.dart';
import 'package:pinsoft_movie_app/widgets/linepath.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailPage extends StatefulWidget {
  String title;
  DetailPage(this.title);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ApiService controllerMovie = ApiService();
  bool pageLoad = false;
  dynamic movieDetail = [];

  @override
  void initState() {
    getMovieDetail(widget.title);
    super.initState();
  }

  getMovieDetail(String movieName) async {
    var res = await controllerMovie.getMovieDetail(movieName);
    movieDetail = res;

    setState(() {
      pageLoad = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.instance.backgroundColor,
        body: pageLoad == true
            ? Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: context.dynamicMultiWidth(1),
                        height: context.dynamicMultiHeight(0.6),
                        child: Image.network(movieDetail["Poster"].toString(),
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                                    child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                )),
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Colors.red,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ));
                            }),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.09,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 50,
                          left: 35,
                          child: GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: context.dynamicMultiWidth(0.08),
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Searchpage()));*/
                            },
                          )),
                      Positioned(
                          top: 50,
                          right: 35,
                          child: GestureDetector(
                            child: Icon(
                              Icons.share_outlined,
                              size: context.dynamicMultiWidth(0.08),
                              color: Colors.white,
                            ),
                            onTap: () {
                              Fluttertoast.showToast(
                                  msg: "Çok Yakında!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 3);
                            },
                          )),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Text(
                            movieDetail["Title"].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: context.dynamicMultiWidth(0.07),
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                  Center(
                      child: Padding(
                    padding:
                        EdgeInsets.only(left: context.dynamicMultiWidth(0.17)),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      child: CustomPaint(
                        painter: PointedLinePainter(
                            context.dynamicMultiWidth(1) -
                                2 * context.dynamicMultiWidth(0.2)),
                      ),
                    ),
                  )),
                  Container(
                    width: context.dynamicMultiWidth(1),
                    height: context.dynamicMultiHeight(0.04),
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: context.dynamicMultiHeight(0.01)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  movieDetail["Year"].toString(),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          context.dynamicMultiWidth(0.04)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          context.dynamicMultiWidth(0.02)),
                                  child: Icon(
                                    Icons.circle,
                                    size: context.dynamicMultiWidth(0.02),
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                                Text(
                                  movieDetail["Genre"].toString(),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          context.dynamicMultiWidth(0.04)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          context.dynamicMultiWidth(0.02)),
                                  child: Icon(
                                    Icons.circle,
                                    size: context.dynamicMultiWidth(0.02),
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                                Text(
                                  movieDetail["Runtime"].toString(),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          context.dynamicMultiWidth(0.04)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: context.dynamicMultiHeight(0.015)),
                    child: Container(
                      width: context.dynamicMultiWidth(1),
                      height: context.dynamicMultiHeight(0.02),
                      child: Center(
                        child: ListView.builder(
                            itemCount: double.parse(
                                        movieDetail["imdbRating"].toString()) >
                                    7.5
                                ? 4
                                : 3,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    child: Icon(
                                      Icons.star,
                                      size: context.dynamicMultiWidth(0.08),
                                      color: Colors.amber,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.amber,
                                            offset: Offset(1.0, 8.0),
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0,
                                          ),
                                        ]),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: context.dynamicMultiHeight(0.035),
                        right: context.dynamicMultiHeight(0.035),
                        top: context.dynamicMultiHeight(0.04)),
                    child: Container(
                      height: context.dynamicMultiHeight(0.27),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Story Line",
                                  style: TextStyle(
                                      fontSize: context.dynamicMultiWidth(0.04),
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.9),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: context.dynamicMultiHeight(0.02)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      movieDetail["Plot"].toString(),
                                      style: TextStyle(
                                          fontSize:
                                              context.dynamicMultiWidth(0.03),
                                          color: Colors.white.withOpacity(0.7),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: context.dynamicMultiHeight(0.03)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Detail",
                                    style: TextStyle(
                                        fontSize:
                                            context.dynamicMultiWidth(0.04),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.9),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: context.dynamicMultiHeight(0.02)),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        IconConstants.instance.medal,
                                        color: Colors.amber,
                                        width: context.dynamicMultiWidth(0.05),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          movieDetail["Awards"].toString(),
                                          style: TextStyle(
                                              fontSize: context
                                                  .dynamicMultiWidth(0.03),
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: context.dynamicMultiHeight(0.02)),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        IconConstants.instance.starperson,
                                        color: Colors.amber,
                                        width: context.dynamicMultiWidth(0.05),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          movieDetail["Actors"].toString(),
                                          style: TextStyle(
                                              fontSize: context
                                                  .dynamicMultiWidth(0.03),
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: context.dynamicMultiHeight(0.02)),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        IconConstants.instance.clapperboard,
                                        color: Colors.amber,
                                        width: context.dynamicMultiWidth(0.05),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          movieDetail["Country"].toString(),
                                          style: TextStyle(
                                              fontSize: context
                                                  .dynamicMultiWidth(0.03),
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: context.dynamicMultiHeight(0.02)),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        IconConstants.instance.language,
                                        color: Colors.amber,
                                        width: context.dynamicMultiWidth(0.05),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          movieDetail["Language"].toString(),
                                          style: TextStyle(
                                              fontSize: context
                                                  .dynamicMultiWidth(0.03),
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ));
  }
}
