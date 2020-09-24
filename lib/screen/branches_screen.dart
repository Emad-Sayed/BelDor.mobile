import 'package:bel_dor/models/branch_details.dart';
import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/screen/departments_screen.dart';
import 'package:bel_dor/utils/app_localization.dart';
import 'package:bel_dor/utils/custom_app_bar.dart';
import 'package:bel_dor/utils/drawer/drawer.dart';
import 'package:flutter/material.dart';

class BranchesScreen extends StatefulWidget {
  @override
  _BranchesScreenState createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  final mainKey = GlobalKey<ScaffoldState>();
  List<BranchDetails> branches;

  @override
  void initState() {
    NetworkClient()
        .getBranches(pageSize: "100", pageNumber: "1")
        .then((result) {
      if (result is SuccessState) {
        setState(() {
          branches = result.value.data;
        });
      } else {
        mainKey.currentState.showSnackBar(SnackBar(
          content: Text(
            (result as ErrorState).msg.message,
            style: TextStyle(fontFamily: 'Helvetica'),
          ),
          duration: Duration(seconds: 3),
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainKey,
      drawer: MyDrawer(2),
      appBar: MyCustomAppBar(mainKey: mainKey),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Color(0xff26362E),
            image: DecorationImage(
                image: AssetImage("assets/images/pattern.png"),
                fit: BoxFit.fitHeight)),
        child: branches != null && branches.isNotEmpty
            ? ListView.builder(
                itemCount: branches.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DepartmentsScreen(
                                  branchId: branches[index].id,
                                )),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.all(8.0),
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          AppLocalizations.of(context).languageCode == "en"
                              ? branches[index].nameEN
                              : branches[index].nameAR,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff181C1A)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              )
            : branches == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('No Branches Available'),
                    ),
                  ),
      ),
    );
  }
}
