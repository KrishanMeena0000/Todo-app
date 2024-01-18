import 'dart:async';
// import 'dart:html';
// import 'dart:js';
import 'package:flutter/material.dart%20';
import 'package:login/homepage.dart';
import 'package:login/main.dart';
import 'package:appwrite/appwrite.dart';
import 'package:login/provider/appwrite.dart';
import 'package:provider/provider.dart';
// import 'package:appwrite/models.dart' as models;
// import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      home: _SplashScreen(),
    );
  }
}

class _SplashScreen extends StatefulWidget {
  @override
  State<_SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<_SplashScreen> {
  LoginPageState loginPageState = LoginPageState();
  // static const String LogIn = "login";

  // void app(BuildContext context) {

  // }

  @override
  void initState() {
    super.initState();
    final appWriteProvider =
        Provider.of<AppWriteProvider>(context, listen: false);

    appWriteProvider.checkLogin(context).then((value) {
      if (value) {
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: ((context) => HomePage()),
            ),
          );
        });
      } else {
        Client client = Client();
        client = Client()
            .setEndpoint("https://endpoint.sizifi.com/v1")
            .setProject("6572e84ec228226a59e6");

        Account account = Account(client);
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: ((context) => LoginPage(
                    account: account,
                  )),
            ),
          );
        });
      }
    });
  }

  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          const Color.fromARGB(255, 87, 222, 240),
          Color.fromARGB(200, 231, 174, 69)
        ])),
        child: Center(
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(seconds: 3),
            builder: (context, value, child) {
              return Opacity(
                  opacity: value,
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: value * 80,
                    child: child,
                  ));
            },
            child: Text(
              "ToDo",
              style: TextStyle(fontSize: 50),
            ),
          ),
        ),
      ),
    );
  }
  // setState(() {});
  // void skipLogin() async {
  //   var pref = await SharedPreferences.getInstance();
  //   var isLoggedIn = pref.getBool(LogIn);
  //   WidgetsFlutterBinding.ensureInitialized();
  //   Client client = Client();
  //   client = Client();
  //   // ignore: unused_local_variable
  //   Databases databases = Databases(client);
  //   client
  //       .setEndpoint("https://endpoint.sizifi.com/v1")
  //       .setProject("6572e84ec228226a59e6");

  //   Account account = Account(client);

  //   if (isLoggedIn != null) {
  //     if (isLoggedIn) {
  //       Timer(Duration(seconds: 3), () {
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: ((context) => HomePage())));
  //       });
  //     } else {
  //       Timer(Duration(seconds: 3), () {
  //         Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //                 builder: ((context) => LoginPage(account: account))));
  //       });
  //     }
  //   } else {
  //     Timer(Duration(seconds: 3), () {
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: ((context) => LoginPage(account: account))));
  //     });
  //   }
  // }
}
