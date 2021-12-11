import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'student.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TablePage(),
  ));
}

class TablePage extends StatefulWidget {
  _State createState() => _State();
}

class _State extends State<TablePage> {
  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  List _list = [];
  Future fetchUser() async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      setState(() {
        _list = responseData;
      });

      print(_list.length);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table'),
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return Table(
            border: TableBorder.all(width: 1, color: Colors.black),
            children: [
              TableRow(children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Center(
                      child: Text(
                    _list[index]['id'].toString(),
                    style: TextStyle(fontSize: 20),
                  )),
                ),
                TableCell(
                  child: Text(_list[index]['name'].toString()),
                ),
                TableCell(
                  child: Text(_list[index]['email'].toString()),
                ),
              ])
            ],
          );
        },
      ),
    );
  }
}
