import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textEditingController = TextEditingController();
  String? text;

  write(String txt) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('txt', txt);
  }

  read() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    text = await pref.getString('txt');
    print(text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.greenAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                helperText: 'Write',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  write(textEditingController.value.text);
                  read();
                });
              },
              child: Text('Send'),
              color: Colors.white,
            ),
            SizedBox(
              height: 30,
            ),
            Text(text.toString()),
          ],
        ),
      ),
    );
  }
}
