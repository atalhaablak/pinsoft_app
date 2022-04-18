import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pinsoft_movie_app/constants/color_constant.dart';
import 'package:pinsoft_movie_app/constants/context_extension.dart';
import 'package:pinsoft_movie_app/controller/api_services.dart/api_service.dart';
import 'package:pinsoft_movie_app/models/menu_model.dart';
import 'package:pinsoft_movie_app/screens/detailpage.dart';
import 'package:pinsoft_movie_app/screens/searchpage.dart';
import 'package:pinsoft_movie_app/widgets/custom_slider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService serviceMovie = ApiService();
  dynamic movieList = [];
  List<String> suggstionMoviesList = [
    "Tenet",
    "Greyhound",
    "Enola Holmes",
    "Extraction"
  ];

  //APİ

  dynamic allList = [];
  bool pageLoad = false;
  Random random = Random();
  int randomNum;

  getSuggesMovie(String movieName) async {
    var res = await serviceMovie.getMovieDetail(movieName);
    setState(() {
      movieList = res;
      pageLoad = true;
    });
  }

  getSuggestionMovie(String suggesMovie) async {
    var res = await serviceMovie.getMovieDetail(suggesMovie);
    setState(() {
      allList = res;
      pageLoad = true;
    });
  }

  @override
  void initState() {
    getSuggesMovie("Batman");
    randomNum = random.nextInt(4);
    getSuggesMovie(suggstionMoviesList[randomNum].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<MenuModel> menuItem = MenuModel.menu;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.instance.backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(
              top: context.dynamicMultiHeight(0.02),
              left: context.dynamicMultiHeight(0.035),
              right: context.dynamicMultiHeight(0.035)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                headerPart(context),
                menuPart(context, menuItem),
                suggestionPart(context),
                sliderPart(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sliderPart(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: context.dynamicMultiHeight(0.03)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Popüler Filmler",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: context.dynamicMultiWidth(0.05),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Container(
          width: context.dynamicMultiWidth(1),
          child: CustomeCarouselHomePage(),
        ),
      ],
    );
  }

  Widget suggestionPart(BuildContext context) {
    return pageLoad == true
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: context.dynamicMultiHeight(0.05)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "İşte Senin İçin Bir Öneri",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: context.dynamicMultiWidth(0.05),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: context.dynamicMultiWidth(0.04),
                      bottom: context.dynamicMultiHeight(0.04)),
                  child: Stack(
                    children: [
                      Container(
                        width: context.dynamicMultiWidth(1),
                        height: context.dynamicMultiHeight(0.52),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(movieList["Poster"].toString(),
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
                        top: 15,
                        left: 10,
                        child: Column(
                          children: [
                            Text(
                              movieList["Title"].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: context.dynamicMultiWidth(0.04),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          top: 12,
                          right: 10,
                          child: Icon(
                            Icons.link,
                            color: Colors.white,
                            size: 25,
                          ))
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(movieList["Title"].toString())));
                },
              ),
            ],
          )
        : Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          );
  }

  Padding menuPart(BuildContext context, List<MenuModel> menuItem) {
    return Padding(
      padding: EdgeInsets.only(top: context.dynamicMultiHeight(0.04)),
      child: Container(
        width: context.dynamicMultiWidth(1),
        height: context.dynamicMultiHeight(0.040),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: menuItem.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    EdgeInsets.only(right: context.dynamicMultiWidth(0.050)),
                child: Container(
                  width: index == 0
                      ? context.dynamicMultiWidth(0.15)
                      : context.dynamicMultiWidth(0.22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: index == 0 ? Colors.red : Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    menuItem[index].title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: context.dynamicMultiWidth(0.04)),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Row headerPart(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
                radius: 24,
                backgroundColor: Colors.brown,
                child: Icon(
                  Icons.person,
                  size: 30,
                )),
            SizedBox(
              width: 13,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Merhaba,",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: context.dynamicMultiWidth(0.032)),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Ahmet A.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: context.dynamicMultiWidth(0.049),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          child: Container(
            width: context.dynamicMultiWidth(0.1),
            height: context.dynamicMultiWidth(0.1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstant.instance.shadowColor,
            ),
            child: Icon(
              Icons.search,
              size: context.dynamicMultiWidth(0.07),
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Searchpage()));
          },
        ),
      ],
    );
  }
}
