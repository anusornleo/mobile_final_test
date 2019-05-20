import 'package:final_project_test/ui/login.dart';
import 'package:flutter/material.dart';
import '../model/modelUser.dart';

class SignInForm extends StatefulWidget {
  List<Todo> items = new List();
  SignInForm(this.items);
  @override
  State<StatefulWidget> createState() {
    return SignInFormState(items);
  }
}

class SignInFormState extends State<SignInForm> {
  List<Todo> items = new List();
  SignInFormState(this.items);
  TodoDatabase db = TodoDatabase();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _cpassword = new TextEditingController();
  final _formKey2 = GlobalKey<ScaffoldState>();

  List<Todo> listTodo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("REGISTER"),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
          child: Form(
            key: _formKey2,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Colors.blue),
                  controller: _email,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: "Plaease input you email",
                    hintStyle: TextStyle(color: Colors.blue[200]),
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.blue,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.blue),
                  controller: _password,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: "Plaease input you Password",
                    hintStyle: TextStyle(color: Colors.blue[200]),
                    prefixIcon: Icon(Icons.lock, color: Colors.blue),
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.blue),
                  controller: _cpassword,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: "Plaease input you Password",
                    hintStyle: TextStyle(color: Colors.blue[200]),
                    prefixIcon: Icon(Icons.lock, color: Colors.blue),
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                Builder(
                  builder: (context) => RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_email.text.isEmpty ||
                            _password.text.isEmpty ||
                            _cpassword.text.isEmpty) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('กรุณาระบุข้อมูลให้ครบถ้วน'),
                            duration: Duration(seconds: 3),
                          ));
                        } else {
                          db
                              .saveNewTask(
                                  Todo.getValue(_email.text, _password.text))
                              .then((_) {
                            items.clear();
                            db.getAllTask().then((todos) {
                              // restart read data when it changed
                              setState(() {
                                print(todos.length);
                                todos.forEach((note) {
                                  items.add(Todo.fromMap(note));
                                  print(items.length);
                                  // print(items[0].toMap());
                                });
                              });
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginForm(items)));
                          });
                        }
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
