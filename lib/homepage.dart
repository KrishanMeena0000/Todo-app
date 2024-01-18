import 'package:appwrite/appwrite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login/ForgotPassword.dart';
import 'package:login/main.dart';
import 'package:login/provider/animation.dart';
import 'package:login/sidebar.dart';
import 'package:login/splashscreen.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:js';
import 'provider/appwrite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginPageState loginPageState = LoginPageState();

  void animate(bool a) {
    setState(() {
      if (a) {
        height = 75;
        width = 100;
        radius = BorderRadius.circular(10);
        color = Colors.blue[300];
        Future.delayed(Duration(milliseconds: 100));
        // _hover = false;
      } else {
        height = 80;
        width = 105;
        radius = BorderRadius.circular(10);
        color = Colors.green;
        // _hover = true;
        Future.delayed(Duration(milliseconds: 100));
      }
    });
  }

  // late ToDo todo;
  // void initState() {
  //   todo = ToDo(id:  , taskText: task);
  //   super.initState();
  // }

  // ToDo todo = ToDo(id: id, taskText: taskText);
  // id: DateTime.now().millisecondsSinceEpoch.toString(), taskText: task!);
  // List<ToDo> _foundToDo = [];
  // var toDos = ToDo.toDoList();
  TextEditingController searchController = TextEditingController();
  final todoController = TextEditingController();
  bool? _hover;
  String? task;
  Color? color;
  BorderRadius? radius;
  double? height;
  double? width;
  // bool? hover;
  @override
  Widget build(BuildContext context) {
    // void htogle() {
    //   _hover = ! _hover;
    // }
    final appWriteProvider =
        Provider.of<AppWriteProvider>(context, listen: false);
    List<ToDo> toDos = appWriteProvider.toDoList;
    // final appWriteProvider =
    //     Provider.of<AppWriteProvider>(context, listen: false);

    // appWriteProvider.toDos[index];
    // final animationProvider =
    //     Provider.of<AnimationProvider>(context, listen: false);
    // final anime = AnimationProvider();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: AppBar(
          title: Text('ToDo App'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Color.fromARGB(179, 22, 22, 22),
              ),
              onPressed: () async {
                // var pref = await SharedPreferences.getInstance();
                // pref.setBool(SplashScreenState.LogIn, false);
                appWriteProvider.logout(context);
              },
            ),
          ],
          backgroundColor: Color.fromARGB(255, 228, 214, 214),
        ),
        body: SizedBox(
          height: double.infinity,
          child: Column(children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Container(
                height: 30,
                width: 350,
                margin: const EdgeInsets.only(top: 15, bottom: 20),
                // color: Colors.white,
                child: TextField(
                    controller: searchController,
                    onChanged: (value) async {
                      if (searchController.text.isEmpty) {
                        await appWriteProvider.getList();
                        setState(() {});
                      } else {
                        await appWriteProvider
                            .searchList(searchController.text);
                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusColor: Colors.blue[300],
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 20,
                      ),
                      contentPadding: EdgeInsets.only(top: 5),
                      hintText: 'Search',

                      // hintStyle:,
                    )),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 25),
              color: Colors.white,
              child: Text(
                'All ToDos',
                style: TextStyle(fontSize: 30, color: Colors.brown[600]),
                textAlign: TextAlign.left,
              ),
            ),
            // for (ToDo todoo in toDos)
            Expanded(
                child: ListView.builder(
              itemCount: toDos.length,
              itemBuilder: (context, index) {
                return Container(
                  // height: 310,
                  // width: 200,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: height,
                    width: width,
                    child: Container(
                      // height: height,
                      // width: width,
                      margin: const EdgeInsets.only(
                          top: 3, bottom: 3, left: 2, right: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        // height: 40,
                        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                        // width: 200,
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(30)),
                        child: ListTile(
                          onTap: () {
                            appWriteProvider.updateToDo(
                                toDos[index].id, toDos[index].isDone);
                            controlTask(appWriteProvider.toDos[index]);
                          },
                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(10)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          leading: toDos[index].isDone
                              ? const Icon(Icons.check_box)
                              : const Icon(Icons.check_box_outline_blank),
                          iconColor: toDos[index].isDone
                              ? Colors.black26
                              : Colors.black87,
                          title: Text(
                            toDos[index].taskText!,
                            style: TextStyle(
                              fontSize: 20,
                              color: toDos[index].isDone
                                  ? Colors.black26
                                  : Colors.black87,
                              decoration: toDos[index].isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            selectionColor: Colors.amber[50],
                          ),
                          trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                appWriteProvider.deleteTask(toDos[index].id);
                                setState(() {});
                              }),
                          tileColor: toDos[index].isDone
                              ? Colors.blue[100]
                              : Colors.blue[300],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),

            // for (ToDo todo in _foundToDo.reversed)

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(right: 5),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 340,
                      margin: const EdgeInsets.only(
                        left: 5,
                      ),
                      // decoration:
                      //     BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      // color: Colors.grey[600],
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                            hintText: 'Add New Task',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.blueGrey[100],
                            // hoverColor: Colors.blueGrey[600],
                            focusColor: Colors.lightBlueAccent[800]),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        appWriteProvider.addTask(todoController.text);
                        todoController.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.add_box),
                      iconSize: 40,
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void controlTask(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
}

class ToDo {
  var id;
  String? taskText;
  bool isDone = false;

  ToDo({
    required this.id,
    required this.taskText,
    required this.isDone,
  });

  ToDo.fromJson(json1) {
    id = json1.data["\$id"];
    taskText = json1.data["mytask"];
    isDone = json1.data["isDone"];
  }
  // ToDo.toJson(Map<String, dynamic> json2) {
  //   //   this.id = json2["\$id"];
  //   //  this.taskText = json2["mytask"];
  //   'mytask' : taskText;
  // }

  // static List<ToDo> toDoList() {
  //   return [];
  // }
}
