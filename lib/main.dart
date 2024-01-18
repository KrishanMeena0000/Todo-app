import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart ';
import 'package:login/CreateAccount.dart';
import 'package:login/ForgotPassword.dart';
import 'package:login/homepage.dart';
import 'package:login/provider/animation.dart';
import 'package:login/provider/appwrite.dart';
import 'package:login/provider/slidebarprovider.dart';
import 'package:login/providerexample.dart';
import 'package:login/splashscreen.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:js';
// import 'package:provider/provider.dart';
// import { Client, Databases } from "appwrite";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Client client = Client();
  client = Client();
  Databases databases = Databases(client);
  client
      .setEndpoint("https://endpoint.sizifi.com/v1")
      .setProject("6572e84ec228226a59e6");

  Account account = Account(client);

  runApp(MyApp(account: account));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => OpacityProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => CountProvider(),
          ),
          ChangeNotifierProvider(create: (_) => AppWriteProvider()),
          ChangeNotifierProvider(create: (_) => AnimationProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.grey),
          title: 'My ToDo App',
          home: SplashScreen(),
        ));
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({required this.account});
  final Account account;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late models.User? loggedInUser;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  // final TextEditingController loginController = TextEditingController();

  bool iconVisibility = true;

//

  // void goHome() {
  //   if (mounted) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => const HomePage()));
  //   }
  // }

  void toggle() {
    setState(() {
      iconVisibility = !iconVisibility;
      print(iconVisibility);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appWriteProvider =
        Provider.of<AppWriteProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Center(
        Container(
          height: 40,
          width: 250,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 223, 137, 56), width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: "E-Mail",
              ),
            ),
          ),
        ),
        // ),

        // Center(
        Container(
          height: 40,
          width: 250,
          margin: EdgeInsets.only(top: 3),
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: TextField(
              controller: passController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 223, 137, 56), width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: "Password",
                suffixIcon: IconButton(
                  onPressed: () => toggle(),
                  icon: Icon(
                      iconVisibility ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              obscureText: iconVisibility ? true : false,
            ),
          ),
        ),
        // ),
        // Center(
        TextButton(
            child: Text(
              "Forgot Password",
              style: TextStyle(
                fontSize: 10,
              ),
              textAlign: TextAlign.justify,
            ),
            onPressed: () {
              print("forgetted");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()));
            }),
        // ),
        Container(
          height: 30,
          width: 200,
          decoration: BoxDecoration(
              // color: Colors.blue[300],
              border: Border.all(color: Color.fromARGB(255, 38, 212, 243)),
              borderRadius: BorderRadius.circular(15)),
          // margin: const EdgeInsets.all(10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                  foregroundColor: Colors.deepPurpleAccent),
              child: Text(
                "Login",
                style: TextStyle(color: Color.fromARGB(255, 90, 62, 62)),
              ),
              onPressed: () async {
                // var pref = await SharedPreferences.getInstance();
                // pref.setBool(SplashScreenState.LogIn, true);
                appWriteProvider.login(
                    emailController.text, passController.text);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const HomePage()));
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Did'nt have account?",
              style: TextStyle(fontSize: 10),
            ),
            TextButton(
                child: Text(
                  "Create New",
                  style: TextStyle(fontSize: 10),
                ),
                onPressed: () {
                  print("registered");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateAccount()));
                  // register(emailControlouteler.text, passController.text,
                  //     nameController.text);
                })
          ],
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.facebook)),
      ]),
    );
  }
}
