//@dart=2.9
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinsoft_movie_app/constants/color_constant.dart';
import 'package:pinsoft_movie_app/constants/context_extension.dart';
import 'package:pinsoft_movie_app/controller/api_services.dart/connection_controller.dart';
import 'package:pinsoft_movie_app/screens/errorpage.dart';
import 'package:pinsoft_movie_app/screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;
  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Widget build(BuildContext context) {
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        return splashToPage(HomePage());
        break;
      case ConnectivityResult.wifi:
        return splashToPage(HomePage());
        break;
      case ConnectivityResult.none:
      default:
        return splashToPage(ErrorPage());
    }
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.instance.backgroundColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                width: 200,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset("assets/icons/pinsoft.png"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "PINSOFT",
            style: TextStyle(
              fontFamily: 'RobotoSlab',
              color: Colors.white,
              fontSize: context.dynamicMultiWidth(0.06),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )),
    );
  }
}
