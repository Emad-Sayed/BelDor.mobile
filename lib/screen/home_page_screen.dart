import 'package:bel_dor/utils/custom_app_bar.dart';
import 'package:bel_dor/utils/drawer/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final mainKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainKey,
      drawer: MyDrawer(0),
      appBar: MyCustomAppBar(mainKey: mainKey),
      body: SafeArea(child: Center(child: CircularProgressIndicator())),
    );
  }
}
