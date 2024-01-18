import 'package:flutter/material.dart%20';
// import 'package:login/CreateAccount.dart';
// import 'dart:js';
import 'package:login/main.dart';
import 'package:login/provider/appwrite.dart';
import 'package:provider/provider.dart';
// import 'package:path/path.dart' as Path;

class ForgotPassword extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  LoginPageState loginPageState = LoginPageState();

  // CreateAccountState createAccountState = CreateAccountState();
  @override
  Widget build(BuildContext context) {
    final appWriteProvider =
        Provider.of<AppWriteProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 250,
              margin: EdgeInsets.only(top: 10),
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
            SizedBox(
              height: 10,
            ),
            Container(
                height: 30,
                width: 235,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[300],
                        foregroundColor: Colors.deepPurpleAccent),
                    onPressed: () {
                      if (emailController.text.isNotEmpty) {
                        appWriteProvider.forgot(emailController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetPassword(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Color.fromARGB(255, 90, 62, 62)),
                    )))
          ],
        ),
      ),
    );
  }
}

class SetPassword extends StatefulWidget {
  @override
  State<SetPassword> createState() => SetPasswordState();
}

class SetPasswordState extends State<SetPassword> {
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  bool iconVisibility = true;
  LoginPageState loginPageState = LoginPageState();

  @override
  Widget build(Object context) {
    final appWriteProvider =
        Provider.of<AppWriteProvider>(this.context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 250,
              margin: EdgeInsets.only(top: 3),
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: TextField(
                  controller: userIdController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 223, 137, 56), width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: "User ID",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 250,
              margin: EdgeInsets.only(top: 3),
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: TextField(
                  controller: newPassController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 223, 137, 56), width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: "New Password",
                  ),
                  obscureText: iconVisibility ? true : false,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 250,
              margin: EdgeInsets.only(top: 3),
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: TextField(
                  controller: confirmPassController,
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
                    hintText: "Confirm Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          iconVisibility = !iconVisibility;
                          print(iconVisibility);
                        });
                      },
                      icon: Icon(iconVisibility
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  obscureText: iconVisibility ? true : false,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 30,
                width: 235,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[300],
                        foregroundColor: Colors.deepPurpleAccent),
                    onPressed: () => appWriteProvider.updatePass(
                        userIdController.text,
                        newPassController.text,
                        confirmPassController.text),
                    // {
                    //   // Navigator.push(
                    //   //     context,
                    //   //     MaterialPageRoute(
                    //   //         builder: (context) => SetPassword()));
                    // },
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Color.fromARGB(255, 90, 62, 62)),
                    ))),
          ],
        ),
      ),
    );
  }
}
