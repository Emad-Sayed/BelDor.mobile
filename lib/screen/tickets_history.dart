import 'package:bel_dor/models/ticket_details.dart';
import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/utils/app_localization.dart';
import 'package:bel_dor/utils/custom_app_bar.dart';
import 'package:bel_dor/utils/drawer/drawer.dart';
import 'package:bel_dor/utils/preference_utils.dart';
import 'package:bel_dor/utils/shared_fields.dart';
import 'package:bel_dor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TicketsHistory extends StatefulWidget {
  final List<String> selectedBranches, selectedDepartments, selectedState;
  final String selectedDate;

  const TicketsHistory(
      {Key key,
      this.selectedBranches,
      this.selectedDepartments,
      this.selectedState,
      this.selectedDate})
      : super(key: key);

  @override
  _TicketsHistoryState createState() => _TicketsHistoryState();
}

class _TicketsHistoryState extends State<TicketsHistory> {
  final mainKey = GlobalKey<ScaffoldState>();
  List<TicketDetails> tickets;
  final PanelController _pc = new PanelController();
  TicketDetails singleTicket;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    NetworkClient()
        .getTickets(
            token: PreferenceUtils.getString(SharedFields.TOKEN, ""),
            statusIds: widget.selectedState,
            specificDay: widget.selectedDate,
            pageNumber: "1",
            pageSize: "1000",
            branchIds: widget.selectedBranches,
            departmentIds: widget.selectedDepartments)
        .then((result) {
      if (result is SuccessState) {
        setState(() {
          tickets = result.value.data;
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
      drawer: MyDrawer(3),
      appBar: MyCustomAppBar(
        mainKey: mainKey,
        showSearch: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xff26362E),
            image: DecorationImage(
                image: AssetImage("assets/images/pattern.png"),
                fit: BoxFit.fitHeight),
          ),
          child: Stack(
            children: [
              getTickets(),
              SlidingUpPanel(
                minHeight: 0.0,
                controller: _pc,
                renderPanelSheet: false,
                panel: _floatingPanel(),
                backdropEnabled: true,
              )
            ],
          )),
    );
  }

  getTickets() {
    return tickets != null
        ? tickets.isNotEmpty
            ? ListView.builder(
                itemCount: tickets.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3.0,
                    color: AppColors.ACCENT_COLOR,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 80,
                            height: 60,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset('assets/images/ticket.svg'),
                                Text(
                                  tickets[index].ticketNumber.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          child: VerticalDivider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          height: 50,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Visibility(
                                  visible: (tickets[index].statusId == 3 ||
                                      tickets[index].statusId == 4),
                                  child: Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: InkWell(
                                      onTap: () {
                                        _pc.open();
                                        NetworkClient()
                                            .getClosedTicketInfo(
                                                ticketId: tickets[index].id)
                                            .then((result) {
                                          if (result is SuccessState) {
                                            setState(() {
                                              singleTicket = result.value.data;
                                            });
                                          } else {
                                            mainKey.currentState
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                (result as ErrorState)
                                                    .msg
                                                    .message,
                                                style: TextStyle(
                                                    fontFamily: 'Helvetica'),
                                              ),
                                              duration: Duration(seconds: 3),
                                            ));
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.info_outline),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).branch,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: AppColors.PRIMARY_DARK_COLOR),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)
                                                    .languageCode ==
                                                'en'
                                            ? tickets[index].branchNameEN
                                            : tickets[index].branchNameAR,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                AppColors.PRIMARY_DARK_COLOR),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).department,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: AppColors.PRIMARY_DARK_COLOR),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)
                                                    .languageCode ==
                                                'en'
                                            ? tickets[index].departementNameEN
                                            : tickets[index].departementNameAR,
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                AppColors.PRIMARY_DARK_COLOR),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).ticketState,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: AppColors.PRIMARY_DARK_COLOR),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                                  .languageCode ==
                                              'en'
                                          ? tickets[index].statusNameEN
                                          : tickets[index].statusNameAR,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.PRIMARY_DARK_COLOR),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Text(
                                    updateDateFormat(tickets[index].createTime),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: AppColors.PRIMARY_DARK_COLOR),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                })
            : Center(
                child: Text(
                  AppLocalizations.of(context).noHistoryTickets,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.ACCENT_COLOR,
                  ),
                ),
              )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _floatingPanel() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.PRIMARY_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.grey,
            ),
          ]),
      margin: const EdgeInsets.all(24.0),
      padding: EdgeInsets.all(14.0),
      child: singleTicket != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 80,
                  height: 60,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset('assets/images/ticket.svg'),
                      Text(
                        singleTicket.ticketNumber.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  title: Text(
                    'Ticket Number',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColors.PRIMARY_DARK_COLOR,
                    ),
                  ),
                  leading: Icon(
                    Icons.confirmation_number,
                    color: AppColors.PRIMARY_DARK_COLOR,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    singleTicket.id.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      color: AppColors.ACCENT_COLOR,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Closed By',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColors.PRIMARY_DARK_COLOR,
                    ),
                  ),
                  leading: Icon(
                    Icons.no_encryption,
                    color: AppColors.PRIMARY_DARK_COLOR,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    singleTicket.employeeName,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: AppColors.ACCENT_COLOR,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Information',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColors.PRIMARY_DARK_COLOR,
                    ),
                  ),
                  leading: Icon(
                    Icons.info,
                    color: AppColors.PRIMARY_DARK_COLOR,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        singleTicket.information != null
                            ? singleTicket.information
                            : "No Information Available",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: AppColors.ACCENT_COLOR,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  String updateDateFormat(String date) {
    var formatter = DateFormat.yMMMEd(
            AppLocalizations.of(context).languageCode == 'en' ? 'en' : 'ar')
        .add_jm();
    print(formatter.locale);
    String formatted = formatter.format(DateTime.parse(date));
    print(DateTime.parse(date).timeZoneName);
    print(formatted);
    return formatted;
  }
}
