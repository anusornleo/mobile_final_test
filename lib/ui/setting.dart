import 'package:final_project_test/model/modelUser.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class Setting extends StatefulWidget {
  Todo userdata;
  Setting(this.userdata);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingState(userdata);
  }
}

class SettingState extends State {
  final Todo userdata;
  SettingState(this.userdata);

  String _gen = "male";
  List<String> years = ['1', '2', '3', '4'];
  String _year = '1';

  bool isChecked = true;

  final _formKey = GlobalKey<ScaffoldState>();

  void _handleRadioValueChange1(String value) {
    setState(() {
      _gen = value;
      print(_gen);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _username = new TextEditingController();
    TextEditingController _password = new TextEditingController();
    TextEditingController _dob = new TextEditingController();
    @override
    void dispose() {
      _username.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: _username,

                  // initialValue: userdata.id.toString(),
                  decoration: InputDecoration(
                    labelText: userdata.username.toString(),
                    hintText: "Plaease input you email",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                    labelText: userdata.password.toString(),
                    hintText: "Plaease input you email",
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text("Check"),
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                    ),
                  ],
                ),
                InputDecorator(
                  decoration: const InputDecoration(
                      icon: const Icon(Icons.people), labelText: 'Year'),
                  // isEmpty: year == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _year,
                      isDense: true,
                      onChanged: (String value) {
                        setState(() {
                          _year = value;
                        });
                      },
                      items: years.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Radio(
                      value: "male",
                      groupValue: _gen,
                      onChanged: _handleRadioValueChange1,
                    ),
                    new Text(
                      'Male',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    new Radio(
                      value: "female",
                      groupValue: _gen,
                      onChanged: _handleRadioValueChange1,
                    ),
                    new Text(
                      'Female',
                      style: new TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                DateTimePickerFormField(
                  controller: _dob,
                  inputType: InputType.date,
                  format: DateFormat("EEEE dd MMMM yyyy"),
                  decoration: InputDecoration(labelText: 'Date'),
                ),
                Builder(
                  builder: (context) => RaisedButton(
                      child: Text('OK'),
                      onPressed: () async {
                        print(_username.text);
                        print(_password.text);
                        print(isChecked);
                        print(_year);
                        print(_gen);
                        print(_dob.text);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Define a Custom Form Widget
// class Setting extends StatefulWidget {
//   @override
//   _MyCustomFormState createState() => _MyCustomFormState();
// }

// class _MyCustomFormState extends State<Setting> {
//   final myController = TextEditingController(text: 'sfd');

//   @override
//   void dispose() {
//     myController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Retrieve Text Input'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             // TextField(
//             //   onChanged: (text) {
//             //     print("First text field: $text");
//             //   },
//             // ),
//             TextFormField(
//               controller: myController,
//             ),
//             RaisedButton(
//               child: Text("data"),
//               onPressed: () {
//                 print(myController.text);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
