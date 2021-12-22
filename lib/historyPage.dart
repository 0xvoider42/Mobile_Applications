import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_applications_project/persistance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00796B),
      appBar: AppBar(
        backgroundColor: Color(0xFF00796B)
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Previous calculations',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            FutureBuilder<SharedPreferences>(
              future: Persistence.init(),
              builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                List<String> values = snapshot.data.getKeys().map<String>((key) => snapshot.data.get(key)).toList();
                return Column(
                  children: values.map<Widget>((result) => Text(result)).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}