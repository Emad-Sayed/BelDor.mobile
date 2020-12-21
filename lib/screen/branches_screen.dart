import 'package:bel_dor/models/branch_details.dart';
import 'package:bel_dor/models/deparment_details.dart';
import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/screen/ticket_added_screen.dart';
import 'package:bel_dor/utils/background_widget.dart';
import 'package:bel_dor/utils/custom_app_bar.dart';
import 'package:bel_dor/utils/drawer/drawer.dart';
import 'package:bel_dor/utils/resources/LayoutUtils.dart';
import 'package:bel_dor/utils/resources/app_strings.dart';
import 'package:bel_dor/utils/resources/refresh_screen.dart';
import 'package:bel_dor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class BranchesScreen extends StatefulWidget {
  @override
  _BranchesScreenState createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> implements RefreshScreen {
  final mainKey = GlobalKey<ScaffoldState>();
  List<BranchDetails> branches = List();
  List<DropdownMenuItem<String>> branchesMenuItems = List();
  List<DropdownMenuItem<String>> departmentsMenuItems = List();
  List<DepartmentDetails> departments;
  bool showLoading = false,
      disableDepartments = true,
      disableSubmitButton = true;
  int selectedBranchId = 0, selectedDepartmentId = 0;
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
                child:
                    Text(AppStrings.isEnglish ? branch.nameEN : branch.nameAR),
                value: AppStrings.isEnglish ? branch.nameEN : branch.nameAR,
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
    return LayoutUtils.wrapWithtinLayoutDirection(
      child: Scaffold(
        key: mainKey,
        drawer: MyDrawer(2, this),
        appBar: MyCustomAppBar(
          mainKey: mainKey,
          showSearch: false,
        ),
        body: BackgroundWidget(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildBranchList(context),
                buildDepartmentList(context),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () {
                      disableSubmitButton ? null : Navigator.of(context)
                        ..pushReplacement(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TicketAddedScreen(
                                    departmentId: selectedDepartmentId,
                                    branchId: selectedBranchId,
                                  )),
                        );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: AppColors.PRIMARY_DARK_COLOR,
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Get A Ticket",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: AppColors.ACCENT_COLOR,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDepartmentList(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(8.0),
      height: 100.0,
      color: Colors.white,
      child: SearchableDropdown.single(
        readOnly: disableDepartments,
        items: departmentsMenuItems,
        value: selectedDepartmentName,
        hint: "Choose Department",
        searchHint: "Search A Department",
        onClear: () {
          setState(() {
            selectedDepartmentName = null;
            disableSubmitButton = true;
          });
        },
        onChanged: (value) {
          setState(() {
            selectedDepartmentName = value;
            if (selectedDepartmentName != null)
              selectedDepartmentId = departments
                  .firstWhere((department) =>
                      (AppStrings.isEnglish
                          ? department.departementNameEN
                          : department.departementNameAR) ==
                      selectedDepartmentName)
                  .departementId;
          });
          if (selectedDepartmentName != null) disableSubmitButton = false;
        },
        dialogBox: true,
        isExpanded: true,
        // menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
      ),
    );
  }

  Widget buildBranchList(BuildContext context) {
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
            disableDepartments = true;
            disableSubmitButton = true;
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
    selectedBranchId = branches
        .firstWhere((branch) =>
            (AppStrings.isEnglish ? branch.nameEN : branch.nameAR) ==
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
                child: Text(AppStrings.isEnglish
                    ? department.departementNameEN
                    : department.departementNameAR),
                value: AppStrings.isEnglish
                    ? department.departementNameEN
                    : department.departementNameAR,
              ),
            );
          });
          disableDepartments = false;
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

  @override
  void loadPage() {
    setState(() {

    });
  }
}
