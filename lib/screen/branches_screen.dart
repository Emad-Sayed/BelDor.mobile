import 'package:bel_dor/models/branch_details.dart';
import 'package:bel_dor/models/deparment_details.dart';
import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/utils/app_localization.dart';
import 'package:bel_dor/utils/background_widget.dart';
import 'package:bel_dor/utils/custom_app_bar.dart';
import 'package:bel_dor/utils/drawer/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import 'ticket_added_screen.dart';

class BranchesScreen extends StatefulWidget {
  @override
  _BranchesScreenState createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  final mainKey = GlobalKey<ScaffoldState>();
  List<BranchDetails> branches = List();
  List<DropdownMenuItem<String>> branchesMenuItems = List();
  List<DropdownMenuItem<String>> departmentsMenuItems = List();
  List<DepartmentDetails> departments;
  bool showLoading = false, showDepartments;
  int selectedBranchId = 0;
  String selectedBranchName, selectedDepartmentName;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    NetworkClient()
        .getBranches(pageSize: "100", pageNumber: "1")
        .then((result) {
      if (result is SuccessState) {
        setState(() {
          branches = result.value.data;
          branches.forEach((branch) {
            branchesMenuItems.add(
              DropdownMenuItem(
                child: Text(AppLocalizations.of(context).languageCode == "en"
                    ? branch.nameEN
                    : branch.nameAR),
                value: AppLocalizations.of(context).languageCode == "en"
                    ? branch.nameEN
                    : branch.nameAR,
              ),
            );
          });
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
        child: ListView(
          children: [
            buildBranchList(context),
            showDepartments != null
                ? Visibility(
                    visible: showDepartments,
                    replacement: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 4 - 100),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    child: buildDepartmentList(context))
                : Container(),
          ],
        ),
      ),
    );
  }

  Container buildDepartmentList(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(8.0),
      height: 100.0,
      color: Colors.white,
      child: SearchableDropdown.single(
        items: departmentsMenuItems,
        value: selectedDepartmentName,
        hint: "Choose Department",
        searchHint: "Search A Department",
        onChanged: (value) {
          setState(() {
            selectedDepartmentName = value;
          });
          Navigator.of(context)
            ..pop()
            ..push(
              MaterialPageRoute(
                  builder: (BuildContext context) => TicketAddedScreen(
                        departmentId: departments
                            .firstWhere((department) =>
                                (AppLocalizations.of(context).languageCode ==
                                        "en"
                                    ? department.departementNameEN
                                    : department.departementNameAR) ==
                                selectedDepartmentName)
                            .departementId,
                        branchId: selectedBranchId,
                      )),
            );
        },
        dialogBox: true,
        isExpanded: true,
        // menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
      ),
    );
  }

  Container buildBranchList(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(8.0),
      height: 100.0,
      color: Colors.white,
      child: SearchableDropdown.single(
        items: branchesMenuItems,
        value: selectedBranchName,
        hint: "Choose Branch",
        searchHint: "Search A Branch",
        onClear: () {
          setState(() {
            selectedBranchName = null;
            showDepartments = null;
          });
        },
        onChanged: (value) {
          setState(() {
            selectedBranchName = value;
          });
          if (selectedBranchName != null) getDepartments();
        },
        dialogBox: true,
        isExpanded: true,
        // menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
      ),
    );
  }

  void getDepartments() {
    setState(() {
      showDepartments = false;
    });
    print(selectedBranchName);
    selectedBranchId = branches
        .firstWhere((branch) =>
            (AppLocalizations.of(context).languageCode == "en"
                ? branch.nameEN
                : branch.nameAR) ==
            selectedBranchName)
        .id;
    NetworkClient()
        .getBranchDepartments(
      branchId: selectedBranchId.toString(),
    )
        .then((result) {
      if (result is SuccessState) {
        setState(() {
          departments = result.value.data[0].departements;
          departments.forEach((department) {
            departmentsMenuItems.add(
              DropdownMenuItem(
                child: Text(AppLocalizations.of(context).languageCode == "en"
                    ? department.departementNameEN
                    : department.departementNameAR),
                value: AppLocalizations.of(context).languageCode == "en"
                    ? department.departementNameEN
                    : department.departementNameAR,
              ),
            );
          });
          showDepartments = true;
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
  }
}
