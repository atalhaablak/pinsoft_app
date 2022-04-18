import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinsoft_movie_app/constants/color_constant.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.instance.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: CircleAvatar(
              child: Image.asset("assets/icons/erroricon.png"),
              radius: 30,
              backgroundColor: Colors.red,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "İnternet Bağlantısı Bulunamadı",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Çıkış Yap"),
        backgroundColor: Colors.red,
        icon: Icon(Icons.logout),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Bağlantı Hatası!'),
            content: Text('Çıkış Yapılacak'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    SystemChannels.platform.invokeMethod("SystemNavigator.pop"),
                child: Text('Tamam'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
