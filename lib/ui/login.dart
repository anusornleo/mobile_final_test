import 'package:final_project_test/model/modelUser.dart';
import 'package:final_project_test/ui/mainHome.dart';
import 'package:final_project_test/ui/signIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController _user = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final _formKey = GlobalKey<ScaffoldState>();
  List<Todo> items = new List();
  final prefs = SharedPreferences.getInstance();

  TodoDatabase db = TodoDatabase();
  @override
  Future initState() {
    super.initState();
    db.getAllTask().then((todos) {
      // restart read data when it changed
      setState(() {
        todos.forEach((note) {
          print(note);
          items.add(Todo.fromMap(note));
          // print(items[0].toMap());
        });
        getLogin();
      });
    });
  }

  Future<String> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final stateLogin = prefs.get('user') ?? 0;
    print(stateLogin);
    if (stateLogin != 0) {
      print("Alrady login");
      print(items);
      for (var i in items) {
        print("5555");
        if (stateLogin == i.id) {
          // final prefs = await SharedPreferences.getInstance();
          // prefs.setInt("user", i.id);
          // prefs.remove('user');
          // print(prefs.getInt('user') ?? 0);
          print("GoHome");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainHome(i)));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 50, left: 30, right: 30),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Image.asset(
              "img/images.jpg",
              height: 150,
            ),
            TextFormField(
              controller: _user,
              decoration: InputDecoration(
                labelText: "User Id",
                hintText: "Plaease input you email",
                prefixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Plaease input you Password",
                prefixIcon: Icon(Icons.lock),
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            Builder(
              builder: (context) => RaisedButton(
                  child: Text('LOGIN'),
                  onPressed: () async {
                    if (_user.text.isEmpty || _password.text.isEmpty) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('กรุณาระบุ user or password'),
                        duration: Duration(seconds: 3),
                      ));
                    } else {
                      for (var i in items) {
                        if (_user.text == i.username &&
                            _password.text == i.password) {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setInt("user", i.id);
                          // prefs.remove('user');
                          print(prefs.getInt('user') ?? 0);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainHome(i)));
                        }
                      }
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('user or password ไม่ถูกต้อง'),
                        duration: Duration(seconds: 3),
                      ));
                    }
                  }),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ButtonTheme(
                padding: EdgeInsets.all(0),
                child: FlatButton(
                  child: Text(
                    "Register New Account",
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInForm()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
