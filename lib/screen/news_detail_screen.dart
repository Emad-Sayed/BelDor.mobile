import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  final String title;

  const NewsDetailScreen({Key key, this.title}) : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final mainKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [],
      ),
    );
  }

  String updateDateFormat(String date) {
    var formatter = DateFormat.yMMMEd('ar_SA').add_jms();
    print(formatter.locale);
    String formatted = formatter.format(DateTime.parse(date).toLocal());
    print(formatted);
    return formatted;
  }
}
