import 'package:bel_dor/models/deparment_details.dart';
import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/screen/ticket_added_screen.dart';
import 'package:bel_dor/utils/app_localization.dart';
import 'package:bel_dor/utils/background_widget.dart';
import 'package:bel_dor/utils/custom_app_bar.dart';
import 'package:bel_dor/utils/drawer/drawer.dart';
import 'package:bel_dor/utils/utils.dart';
import 'package:flutter/material.dart';

class DepartmentsScreen extends StatefulWidget {
  final int branchId;

  const DepartmentsScreen({Key key, @required this.branchId}) : super(key: key);

  @override
  _DepartmentsScreenState createState() => _DepartmentsScreenState();
}

class _DepartmentsScreenState extends State<DepartmentsScreen> {
  final mainKey = GlobalKey<ScaffoldState>();
  List<DepartmentDetails> departments;

  @override
  void initState() {
    NetworkClient()
        .getBranchDepartments(
      branchId: widget.branchId.toString(),
    )
        .then((result) {
      if (result is SuccessState) {
        setState(() {
          departments = result.value.data[0].departements;
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
      appBar: MyCustomAppBar(
        mainKey: mainKey,
        showSearch: false,
      ),
      body: BackgroundWidget(
        child: departments != null && departments.isNotEmpty
            ? ListView.builder(
                itemCount: departments.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TicketAddedScreen(
                                  branchId: widget.branchId,
                                  departmentId:
                                      departments[index].departementId,
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
                              ? departments[index].departementNameEN
                              : departments[index].departementNameAR,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.PRIMARY_DARK_COLOR),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              )
            : departments == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('No Departments Available'),
                    ),
                  ),
      ),
    );
  }
}
