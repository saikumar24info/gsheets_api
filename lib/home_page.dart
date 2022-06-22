// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gsheets_example/sheets_api.dart';
import 'package:gsheets_example/user_fields.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int id = 1;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool isBeginner = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('GSheets'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*Required this Field';
                    } else if (value.length <= 2) {
                      return '*Enter Full Name';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*Enter EmailId';
                    } else if (value.length < 3) {
                      return '*Enter correct Email';
                    } else if (!value.contains('@')) {
                      return '*Enter correct Email';
                    } else {
                      return null;
                    }
                  },
                ),
                SwitchListTile(
                  activeColor: Colors.red,
                  title: Text('Is a Beginner'),
                  value: isBeginner,
                  onChanged: (value) {
                    setState(() {
                      isBeginner = !isBeginner;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 45,
                  width: 140,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shadowColor: Colors.grey,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        visualDensity:
                            VisualDensity(horizontal: 2, vertical: 4)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final user = {
                          UserFields.id: id,
                          UserFields.name: _nameController.text,
                          UserFields.email: _emailController.text,
                          UserFields.isBeginner: isBeginner
                        };
                        await SheetsApi.insert([user]);
                        incrementCount();
                      }
                    },
                    child: Text('Send'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int incrementCount() {
    id += 1;
    return id;
  }
}
