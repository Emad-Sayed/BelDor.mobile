import 'dart:async';

import 'package:bel_dor/models/api_response_list.dart';
import 'package:bel_dor/models/ticket_details.dart';
import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/utils/app_localization.dart';
import 'package:bel_dor/utils/custom_app_bar.dart';
import 'package:bel_dor/utils/drawer/drawer.dart';
import 'package:bel_dor/utils/preference_utils.dart';
import 'package:bel_dor/utils/shared_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'home_page_screen.dart';

class TicketAddedScreen extends StatefulWidget {
  final int branchId, departmentId;

  const TicketAddedScreen({Key key, this.branchId, this.departmentId})
      : super(key: key);

  @override
  _TicketAddedScreenState createState() => _TicketAddedScreenState();
}

class _TicketAddedScreenState extends State<TicketAddedScreen> {
  final mainKey = GlobalKey<ScaffoldState>();
  TicketDetails ticket;
  ApiResponseList response;

  @override
  void initState() {
    NetworkClient()
        .addTicket(
            branchId: widget.branchId,
            token: PreferenceUtils.getString(SharedFields.TOKEN, ""),
            departmentId: widget.departmentId)
        .then((result) {
      if (result is SuccessState) {
        setState(() {
          response = result.value;
          ticket = response.data[0];
        });

        Timer(
          Duration(seconds: 5),
          () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
          ),
        );
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
      drawer: MyDrawer(2),
      appBar: MyCustomAppBar(mainKey: mainKey),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xff26362E),
            image: DecorationImage(
                image: AssetImage("assets/images/pattern.png"),
                fit: BoxFit.fitHeight)),
        child: ticket != null
            ? Card(
                elevation: 3.0,
                color: Color(0xffCBEEF3),
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: response.errorAR != null,
                      child: Text(
                        response.errorAR != null
                            ? AppLocalizations.of(context).languageCode == "en"
                                ? response.errorEN
                                : response.errorAR
                            : "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
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
                                  ticket.ticketNumber.toString(),
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
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).branch,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xff181C1A)),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)
                                                    .languageCode ==
                                                'en'
                                            ? ticket.branchNameEN
                                            : ticket.branchNameAR,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff181C1A)),
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
                                          color: Color(0xff181C1A)),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)
                                                    .languageCode ==
                                                'en'
                                            ? ticket.departementNameEN
                                            : ticket.departementNameAR,
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff181C1A)),
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
                                          color: Color(0xff181C1A)),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                                  .languageCode ==
                                              'en'
                                          ? ticket.statusNameEN
                                          : ticket.statusNameAR,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff181C1A)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .currentNumber,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xff181C1A)),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      ticket.currentNumber.toString(),
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff181C1A)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Text(
                                    updateDateFormat(ticket.createTime),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff181C1A)),
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
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
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
