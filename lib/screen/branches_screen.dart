import 'package:bel_dor/models/branch_details.dart';
import 'package:bel_dor/models/deparment_details.dart';
import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/screen/ticket_added_screen.dart';
import 'package:bel_dor/utils/app_localization.dart';
import 'package:bel_dor/utils/background_widget.dart';
import 'package:bel_dor/utils/custom_app_bar.dart';
import 'package:bel_dor/utils/drawer/drawer.dart';
import 'package:bel_dor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BranchesScreen extends StatefulWidget {
  @override
  _BranchesScreenState createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  final mainKey = GlobalKey<ScaffoldState>();
  List<BranchDetails> branches = List();
  List<BranchDetails> branchItems;
  List<DepartmentDetails> departments;
  List<DepartmentDetails> departmentItems;
  bool showLoading = false, showDepartments;
  TextEditingController branchEditingController = TextEditingController();
  TextEditingController departmentEditingController = TextEditingController();
  int selectedBranch = 0;

  @override
  void dispose() {
    branchEditingController.dispose();
    departmentEditingController.dispose();
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
          branchItems = List.of(branches);
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
              buildBranchExpansionTile(context),
              showDepartments != null
                  ? Visibility(
                  visible: showDepartments,
                  replacement: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery
                            .of(context)
                            .size
                            .height / 4 - 100),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  child: buildDepartmentExpansionTile(context))
                  : Container(),
            ],
          )),
    );
  }

  Container buildDepartmentExpansionTile(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height / 4 - 100,
          left: 16.0,
          right: 16.0,
          bottom: 16.0),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          AppLocalizations
              .of(context)
              .departments,
          style: TextStyle(fontSize: 20, color: AppColors.PRIMARY_COLOR),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: TextField(
              controller: departmentEditingController,
              onChanged: (value) => filterSearchDepartmentsResults(value),
              decoration: InputDecoration(
                labelText: AppLocalizations
                    .of(context)
                    .search,
                hintText: AppLocalizations
                    .of(context)
                    .search,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        children: [
          departmentItems != null && departmentItems.isNotEmpty
              ? Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 4,
            child: ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: departmentItems.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                      ..pop()
                      ..push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TicketAddedScreen(
                                  departmentId: departmentItems[index]
                                      .departementId,
                                  branchId: selectedBranch,
                                )),
                      );
                  },
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        AppLocalizations
                            .of(context)
                            .languageCode == "en"
                            ? departmentItems[index].departementNameEN
                            : departmentItems[index].departementNameAR,
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
            ),
          )
              : departmentItems == null
              ? Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 4,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 4,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('No Departments Available'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildBranchExpansionTile(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      color: Colors.white,
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          AppLocalizations
              .of(context)
              .branches,
          style: TextStyle(fontSize: 20, color: AppColors.PRIMARY_COLOR),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: TextField(
              controller: branchEditingController,
              onChanged: (value) => filterSearchBranchesResults(value),
              decoration: InputDecoration(
                labelText: AppLocalizations
                    .of(context)
                    .search,
                hintText: AppLocalizations
                    .of(context)
                    .search,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        children: [
          branchItems != null && branchItems.isNotEmpty
              ? Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 4,
            child: ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: branchItems.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      showDepartments = false;
                      selectedBranch = branchItems[index].id;
                    });
                    NetworkClient()
                        .getBranchDepartments(
                      branchId: selectedBranch.toString(),
                    )
                        .then((result) {
                      if (result is SuccessState) {
                        setState(() {
                          departments = result.value.data[0].departements;
                          departmentItems = List.of(departments);
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
                  },
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        AppLocalizations
                            .of(context)
                            .languageCode == "en"
                            ? branchItems[index].nameEN
                            : branchItems[index].nameAR,
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
            ),
          )
              : branchItems == null
              ? Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 4,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 4,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('No Branches Available'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void filterSearchBranchesResults(String query) {
    List<BranchDetails> dummySearchList = List<BranchDetails>();
    dummySearchList.addAll(branches);
    if (query.isNotEmpty) {
      List<BranchDetails> dummyListData = List<BranchDetails>();
      dummySearchList.forEach((item) {
        var itemName = AppLocalizations
            .of(context)
            .languageCode == "en"
            ? item.nameEN
            : item.nameAR;
        if (itemName.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        branchItems.clear();
        branchItems.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        branchItems.clear();
        branchItems.addAll(branches);
      });
    }
  }

  void filterSearchDepartmentsResults(String query) {
    List<DepartmentDetails> dummySearchList = List<DepartmentDetails>();
    dummySearchList.addAll(departments);
    if (query.isNotEmpty) {
      List<DepartmentDetails> dummyListData = List<DepartmentDetails>();
      dummySearchList.forEach((item) {
        var itemName = AppLocalizations
            .of(context)
            .languageCode == "en"
            ? item.departementNameEN
            : item.departementNameAR;
        if (itemName.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        departmentItems.clear();
        departmentItems.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        departmentItems.clear();
        departmentItems.addAll(departments);
      });
    }
  }
}
