import 'package:flutter/material.dart';
import 'package:phone_form_field_plus/phone_form_field_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<PhoneNumber> _phoneCtrl =
      ValueNotifier(PhoneNumber('', Country.isoCode("US")));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Form Field Demo"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 32,
              ),
              PhoneFormField(
                decoration: InputDecoration(
                    labelText: "Phone Number", border: OutlineInputBorder()),
                controller: _phoneCtrl,
              ),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('Submit')),
              SizedBox(
                height: 32,
              ),
              ValueListenableBuilder(
                  valueListenable: _phoneCtrl,
                  builder: (context, PhoneNumber phoneNumber, _) =>
                      Text("$phoneNumber")),
            ],
          ),
        ),
      ),
    );
  }
}
