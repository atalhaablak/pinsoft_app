import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinsoft_movie_app/constants/color_constant.dart';
import 'package:pinsoft_movie_app/constants/context_extension.dart';
import 'package:pinsoft_movie_app/controller/api_services.dart/api_service.dart';
import 'package:pinsoft_movie_app/screens/detailpage.dart';
import 'package:pinsoft_movie_app/screens/homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Searchpage extends StatefulWidget {
  Searchpage({Key key}) : super(key: key);

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  ApiService movieController = ApiService();
  TextEditingController searchController = TextEditingController();
  dynamic movieIDList = []; //movieIDList
  dynamic movieList = [];
  bool pageLoad = false;
  bool pageList = true;

  @override
  void initState() {
    getMovieSearch("Batman");
    super.initState();
  }

  getMovieSearch(String movieName) async {
    var res = await movieController.getMovieSearch(movieName);
    if (res["Response"] == "True") {
      for (var item in res["Search"]) {
        movieIDList.add(item["imdbID"]);
      }
      for (int i = 0; i < movieIDList.length; i++) {
        var res =
            await movieController.getImdbDetail(movieIDList[i].toString());
        movieList.add(res);
      }
      setState(() {
        pageLoad = true;
        pageList = true;
      });
    } else {
      setState(() {
        pageList = false;
        pageLoad = false;
      });
    }
  }

  getImdbIdList(int index) async {
    var res =
        await movieController.getImdbDetail(movieIDList[index].toString());
    movieList.add(res);
    pageLoad = true;
  }

  @override
  Widget build(BuildContext context) {
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
                buildMenuBar(context),
                buildSearchBar(context),
                pageList == true
                    ? pageLoad == true
                        ? buildMovieList(context)
                        : Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          )
                    : Center(
                        child: Text(
                          "Veri Bulunamadı!",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Container(
            width: context.dynamicMultiWidth(0.1),
            height: context.dynamicMultiWidth(0.1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstant.instance.shadowColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 7.0),
              child: Icon(
                Icons.arrow_back_ios,
                size: context.dynamicMultiWidth(0.05),
                color: Colors.white,
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
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
              Icons.settings,
              size: context.dynamicMultiWidth(0.05),
              color: Colors.white,
            ),
          ),
          onTap: () {
            Fluttertoast.showToast(
                msg: "Bu uygulama ayarsız",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3);
          },
        ),
      ],
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicMultiHeight(0.05)),
      child: TextField(
        controller: searchController,
        cursorColor: Colors.red,
        textInputAction: TextInputAction.next,
        style: TextStyle(
            color: Colors.white, fontSize: context.dynamicMultiWidth(0.035)),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorConstant.instance.shadowColor, width: 2.0),
              borderRadius: BorderRadius.all(Radius.elliptical(30, 30))),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorConstant.instance.shadowColor, width: 2.0),
              borderRadius: BorderRadius.all(Radius.elliptical(30, 30))),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorConstant.instance.shadowColor, width: 2.0),
          ),
          contentPadding:
              EdgeInsets.only(left: 40.0, top: 20.0, right: 20.0, bottom: 20.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorConstant.instance.shadowColor, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.elliptical(30, 30),
            ),
          ),
          suffixIcon: GestureDetector(
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                movieIDList.clear();
                movieList.clear();
                pageList = true;
              });
              getMovieSearch(searchController.text);
            },
          ),
          hintText: 'örn: Batman',
          hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontStyle: FontStyle.italic,
              fontSize: context.dynamicMultiWidth(0.03)),
        ),
        onSubmitted: (string) {
          FocusScope.of(context).unfocus();
          setState(() {
            movieIDList.clear();
            movieList.clear();
            pageList = true;
          });
          getMovieSearch(searchController.text);
        },
      ),
    );
  }

  Widget buildMovieList(BuildContext context) {
    return SizedBox(
      width: context.dynamicMultiWidth(1),
      height: context.dynamicMultiHeight(0.7),
      child: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            var item = movieList[index];
            return GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                width: context.dynamicMultiWidth(1),
                height: 200,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: context.dynamicMultiWidth(0.32),
                            child: Image.network(item["Poster"].toString(),
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
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ));
                                }),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                              child: Text(
                                item["Title"].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.dynamicMultiWidth(0.04),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: context.dynamicMultiHeight(0.165),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item["Plot"].length > 130
                                        ? item["Plot"].substring(0, 130) + '...'
                                        : item["Plot"].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          context.dynamicMultiWidth(0.027),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            item["Genre"].length > 25
                                                ? item["Genre"]
                                                        .substring(0, 25) +
                                                    '...'
                                                : item["Genre"].toString(),
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontSize: context
                                                  .dynamicMultiWidth(0.025),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          item["Year"].toString(),
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: context
                                                .dynamicMultiWidth(0.025),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(item["Title"].toString())));
              },
            );
          }),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('movieIDList', movieIDList));
  }
}
