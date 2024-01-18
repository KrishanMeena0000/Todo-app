// import 'package:flutter/material.dart%20';
// import 'dart:js';

import 'dart:async';
// import 'dart:js';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

// class AppWriteProvider{
//     WidgetsFlutterBinding.ensureInitialized();
//   Client client = Client();
//   client = Client();
//   Databases databases = Databases(client);
//   client
//       .setEndpoint("https://endpoint.sizifi.com/v1")
//       .setProject("6572e84ec228226a59e6");

//   Account account = Account(client);
// }
import 'package:flutter/material.dart%20';
import 'package:login/homepage.dart';
import 'package:login/main.dart';
import 'package:login/splashscreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppWriteProvider with ChangeNotifier {
  // const AppWriteProvider({required this.account});
  LoginPageState loginPageState = LoginPageState();
  late models.User? loggedInUser;
  //final toDos = ToDo.toDoList();
  List<ToDo> toDos = [];
  final TextEditingController todoController = TextEditingController();

  HomePage homePage = HomePage();

  List<ToDo> get toDoList => toDos;

  AppWriteProvider() {
    _init();
  }

  _init() {
    getList();
  }

  Future<void> login(String email, String password) async {
    // print("Logging in...");
    Client client = Client();
    client = Client()
        .setEndpoint("https://endpoint.sizifi.com/v1")
        .setProject("6572e84ec228226a59e6");

    Account account = Account(client);

    final session =
        await account.createEmailSession(email: email, password: password);
    // print(session);
    final user = await account.get();
    getList();
    // print(user.email);
    // setState(() {
    //   loggedInUser = user;
    // });
    //  Navigator.of(context,MaterialPageRoute(builder: (context) => ,))

    notifyListeners();
  }

  Future<void> logout(cont) async {
    print("Logging out");

    Client client = Client();
    client = Client()
        .setEndpoint("https://endpoint.sizifi.com/v1")
        .setProject("6572e84ec228226a59e6");

    Account account = Account(client);

    await account
        .deleteSession(sessionId: 'current')
        .then((value) => print(value));
    Navigator.pushReplacement(
        cont,
        MaterialPageRoute(
            builder: (cont) => LoginPage(
                  account: account,
                )));

    notifyListeners();
    // setState(() {
    //   loggedInUser = null;
    // });
    // LoginPage(account: widget.account);
  }

  Future<void> register(String email, String password, String name) async {
    Client client = Client();
    client = Client()
        .setEndpoint("https://endpoint.sizifi.com/v1")
        .setProject("6572e84ec228226a59e6");

    Account account = Account(client);

    final user = await account.create(
        userId: ID.unique(), email: email, password: password);
    print(user);
    await login(email, password);
    notifyListeners();
  }

  Future<void> forgot(String email) async {
    Client client = Client();
    client = Client()
        .setEndpoint("https://endpoint.sizifi.com/v1")
        .setProject("6572e84ec228226a59e6");

    Account account = Account(client);
    // final user = await account.get();

    await account.createRecovery(
        email: email, url: 'https://endpoint.sizifi.com/v1');

    // print("password forgeted");
    notifyListeners();
  }

  Future<void> updatePass(
      String userId, String newPass, String confirmPass) async {
    Client client = Client();
    client = Client()
        .setEndpoint("https://endpoint.sizifi.com/v1")
        .setProject("6572e84ec228226a59e6");

    Account account = Account(client);
    await account.updateRecovery(
        userId: userId,
        secret: '',
        password: newPass,
        passwordAgain: confirmPass);
    notifyListeners();
  }

//
//
//
//
  Future addTask(String task) async {
    // final Databases databases;
    // final id = ID.unique();
    // setState(() {

    // });
    Client client = Client();
    client = Client();
    client
        .setEndpoint("https://endpoint.sizifi.com/v1")
        .setProject("6572e84ec228226a59e6");
    Databases databases = Databases(client);

    Future result = databases.createDocument(
      databaseId: 'My_todo_123',
      collectionId: 'Collection_123',
      documentId: ID.unique(),
      data: {
        'mytask': task,
      },
    );
    toDos.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        taskText: task,
        isDone: false));
    notifyListeners();
  }

  void deleteTask(var id) async {
    // setState(() {
    toDos.removeWhere((item) => item.id == id);
    // });
    Client client = Client();
    client = Client();
    client
        .setEndpoint("https://endpoint.sizifi.com/v1")
        .setProject("6572e84ec228226a59e6");
    Databases databases = Databases(client);
    models.DocumentList result;
    result = await databases.deleteDocument(
      databaseId: 'My_todo_123',
      collectionId: 'Collection_123',
      documentId: id,
    );
    toDos = result.documents.map((toDo) => ToDo.fromJson(toDo)).toList();
    notifyListeners();
  }

  //
  //
  //
  //
  Future checkLogin(BuildContext context) async {
    try {
      Client client = Client();
      client = Client()
          .setEndpoint("https://endpoint.sizifi.com/v1")
          .setProject("6572e84ec228226a59e6");

      Account account = Account(client);
      final user = await account.get();
      account.getPrefs();
      // Future result = account.getSession(sessionId: 'current');
      return true;
    } catch (e) {
      return false;
    }
  }

  // notifyListeners();
  //
  //

  Future getList() async {
    Client client = Client();
    client = Client();
    client
        .setEndpoint("https://endpoint.sizifi.com/v1")
        .setProject("6572e84ec228226a59e6");
    Databases databases = Databases(client);
    models.DocumentList res;
    res = await databases.listDocuments(
      databaseId: 'My_todo_123',
      collectionId: 'Collection_123',
    );
    toDos = res.documents.map((toDo) => ToDo.fromJson(toDo)).toList();

    // Query.search("mytask", searchController.text);
    notifyListeners();
  }

  Future searchList(String search) async {
    Client client = Client();
    client = Client();
    client
        .setEndpoint("https://endpoint.sizifi.com/v1")
        .setProject("6572e84ec228226a59e6");
    Databases databases = Databases(client);
    models.DocumentList res;
    res = await databases.listDocuments(
      databaseId: 'My_todo_123',
      collectionId: 'Collection_123',
      queries: [
        Query.search('mytask', search),
      ],
    );
    toDos = res.documents.map((toDo) => ToDo.fromJson(toDo)).toList();

    // Query.search("mytask", searchController.text);
    notifyListeners();
  }

  //
  //
  //
  //
  Future updateToDo(var id, bool isDone) async {
    Client client = Client();
    client = Client();
    client
        .setEndpoint("https://endpoint.sizifi.com/v1")
        .setProject("6572e84ec228226a59e6");
    Databases databases = Databases(client);
    //  models.DocumentList result;
    isDone = !isDone;
    await databases.updateDocument(
      databaseId: 'My_todo_123',
      collectionId: 'Collection_123',
      documentId: id,
      data: {
        'isDone': isDone,
      },
    );

    //   void controlTask(ToDo todo) {
    //   todo.isDone = !todo.isDone;
    // }
    // loginPageState.controlTask(toDos[index]);
    notifyListeners();
  }

//
//
//
}
