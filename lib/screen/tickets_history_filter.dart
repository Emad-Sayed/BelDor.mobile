import 'package:bel_dor/models/branch_details.dart';
import 'package:bel_dor/models/departments.dart';
import 'package:bel_dor/models/state_details.dart';
import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/screen/tickets_history.dart';
import 'package:bel_dor/utils/app_localization.dart';
import 'package:bel_dor/utils/background_widget.dart';
import 'package:bel_dor/utils/multiselect_formfield/multiselect_formfield.dart';
import 'package:bel_dor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketsHistoryFilter extends StatefulWidget {
  @override
  _TicketsHistoryFilterState createState() => _TicketsHistoryFilterState();
}

class _TicketsHistoryFilterState extends State<TicketsHistoryFilter> {
  final mainKey = GlobalKey<ScaffoldState>();
  List<BranchDetails> branches;
  List<Departments> departments;
  List<StateDetails> states = List<StateDetails>();
  List<int> selectedBranches, selectedDepartments, selectedState;
  String dateChosen;
  DateTime _selectedDate;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    selectedBranches = List<int>();
    selectedDepartments = List<int>();
    selectedState = List<int>();

    _textEditingController.text =
        DateFormat("yyyy-MM-dd").format(DateTime.now());

    states.add(StateDetails(id: 1, nameAR: "انتظـار", nameEN: "Waiting"));
    states.add(StateDetails(id: 2, nameAR: "تـخـدم", nameEN: "Serving"));
    states.add(StateDetails(id: 3, nameAR: "مـغلـقة", nameEN: "Closed"));
    states.add(StateDetails(id: 4, nameAR: "تـخلـفـت", nameEN: "Missed"));

    NetworkClient()
        .getDepartments(pageNumber: "1", pageSize: "1000")
        .then((result) {
      if (result is SuccessState) {
        setState(() {
          departments = result.value.data;
        });
      } else {
        mainKey.currentState.showSnackBar(SnackBar(
          content: Text(
            (result as ErrorState).msg.message,
          ),
          duration: Duration(seconds: 3),
        ));
      }
    });

    NetworkClient()
        .getBranches(pageNumber: "1", pageSize: "1000")
        .then((result) {
      if (result is SuccessState) {
        setState(() {
          branches = result.value.data;
        });
      } else {
        mainKey.currentState.showSnackBar(SnackBar(
          content: Text(
            (result as ErrorState).msg.message,
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
      body: BackgroundWidget(
        child: branches != null && departments != null
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .filtrationToShowTicketsHistory,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.ACCENT_COLOR,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          focusNode: AlwaysDisabledFocusNode(),
                          controller: _textEditingController,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: AppColors.PRIMARY_COLOR,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: MultiSelectFormField(
                          autovalidate: false,
                          chipBackGroundColor: AppColors.PRIMARY_COLOR,
                          chipLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.ACCENT_COLOR),
                          dialogTextStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: AppColors.PRIMARY_COLOR,
                          checkBoxCheckColor: AppColors.ACCENT_COLOR,
                          dialogShapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: Text(
                            AppLocalizations.of(context).branches,
                            style: TextStyle(fontSize: 20),
                          ),
                          dataSource: branches.map((e) => e.toJson()).toList(),
                          textField:
                              AppLocalizations.of(context).languageCode == "en"
                                  ? 'nameEN'
                                  : 'nameAR',
                          valueField: 'id',
                          okButtonLabel: AppLocalizations.of(context).ok,
                          cancelButtonLabel:
                              AppLocalizations.of(context).cancel,
                          hintWidget: Text(AppLocalizations.of(context)
                              .pleaseSelectOneOrMore),
                          initialValue: selectedBranches,
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              selectedBranches = value.toList().cast<int>();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: MultiSelectFormField(
                          autovalidate: false,
                          chipBackGroundColor: AppColors.PRIMARY_COLOR,
                          chipLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.ACCENT_COLOR),
                          dialogTextStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: AppColors.PRIMARY_COLOR,
                          checkBoxCheckColor: AppColors.ACCENT_COLOR,
                          dialogShapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: Text(
                            AppLocalizations.of(context).departments,
                            style: TextStyle(fontSize: 20),
                          ),
                          dataSource:
                              departments.map((e) => e.toJson()).toList(),
                          textField:
                              AppLocalizations.of(context).languageCode == "en"
                                  ? 'nameEN'
                                  : 'nameAR',
                          valueField: 'id',
                          okButtonLabel: AppLocalizations.of(context).ok,
                          cancelButtonLabel:
                              AppLocalizations.of(context).cancel,
                          hintWidget: Text(AppLocalizations.of(context)
                              .pleaseSelectOneOrMore),
                          initialValue: selectedDepartments,
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              selectedDepartments = value.toList().cast<int>();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: MultiSelectFormField(
                          autovalidate: false,
                          chipBackGroundColor: AppColors.PRIMARY_COLOR,
                          chipLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.ACCENT_COLOR),
                          dialogTextStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: AppColors.PRIMARY_COLOR,
                          checkBoxCheckColor: AppColors.ACCENT_COLOR,
                          dialogShapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: Text(
                            AppLocalizations.of(context).ticketStates,
                            style: TextStyle(fontSize: 20),
                          ),
                          dataSource: states.map((e) => e.toJson()).toList(),
                          textField:
                              AppLocalizations.of(context).languageCode == "en"
                                  ? 'nameEN'
                                  : 'nameAR',
                          valueField: 'id',
                          okButtonLabel: AppLocalizations.of(context).ok,
                          cancelButtonLabel:
                              AppLocalizations.of(context).cancel,
                          hintWidget: Text(AppLocalizations.of(context)
                              .pleaseSelectOneOrMore),
                          initialValue: selectedState,
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              selectedState = value.toList().cast<int>();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    TicketsHistory(
                                      selectedBranches: selectedBranches
                                          .map((e) => e.toString())
                                          .toList(),
                                      selectedDepartments: selectedDepartments
                                          .map((e) => e.toString())
                                          .toList(),
                                      selectedState: selectedState
                                          .map((e) => e.toString())
                                          .toList(),
                                      selectedDate: _textEditingController.text,
                                    )),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.all(16.0),
                          elevation: 3.0,
                          color: AppColors.PRIMARY_COLOR,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              AppLocalizations.of(context).submit,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
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
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat("yyyy-MM-dd").format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
