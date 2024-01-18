import 'package:flutter/material.dart%20';
import 'package:login/main.dart';
import 'package:login/homepage.dart';
import 'package:login/provider/appwrite.dart';
import 'package:provider/provider.dart';
// import 'dart:js';

class CreateAccount extends StatefulWidget {
  @override
  State<CreateAccount> createState() => CreateAccountState();
}

class CreateAccountState extends State<CreateAccount> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  bool iconVisibility = true;

  //  Future<void> register(String email, String password, String name) async {
  LoginPageState loginPageState = LoginPageState();

  @override
  Widget build(BuildContext context) {
    final appWriteProvider =
        Provider.of<AppWriteProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          // title: IconButton(
          //   icon: Icon(Icons.arrow_back_ios_new),
          //   onPressed: () {},
          // ),
          backgroundColor: Color.fromARGB(0, 247, 203, 203),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            // alignment: Alignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 250,
                // margin: EdgeInsets.only(top: 10),
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 223, 137, 56), width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: "Enter Your Name",
                    ),
                  ),
                ),
              ),
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
              // ),
              // SizedBox(
              //   height: ,
              // ),
              // Center(
              Container(
                height: 40,
                width: 250,
                margin: EdgeInsets.only(top: 10),
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
              Container(
                height: 30,
                width: 200,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 38, 212, 243)),
                    borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[300],
                        foregroundColor: Colors.deepPurpleAccent),
                    child: Text(
                      "Create Account",
                      style: TextStyle(color: Color.fromARGB(255, 90, 62, 62)),
                    ),
                    onPressed: () {
                      print("sddsdssd");
                      appWriteProvider.register(
                        emailController.text,
                        passController.text,
                        nameController.text,
                      );
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have Account?",
                      style: TextStyle(fontSize: 11),
                    ),
                    // SizedBox(
                    //   width: null,
                    // ),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Log In",
                          style: TextStyle(fontSize: 11),
                        ))
                  ],
                ),
              ),

              IconButton(onPressed: () {}, icon: Icon(Icons.facebook)),
            ],
          ),
        ));
  }
}
