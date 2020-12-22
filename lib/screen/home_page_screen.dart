import 'package:bel_dor/models/ticket_details.dart';
import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/screen/branches_screen.dart';
import 'package:bel_dor/utils/background_widget.dart';
import 'package:bel_dor/utils/drawer/drawer.dart';
import 'package:bel_dor/utils/preference_utils.dart';
import 'package:bel_dor/utils/resources/LayoutUtils.dart';
import 'package:bel_dor/utils/resources/app_strings.dart';
import 'package:bel_dor/utils/resources/refresh_screen.dart';
import 'package:bel_dor/utils/shared_fields.dart';
import 'package:bel_dor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin
    implements RefreshScreen {
  final mainKey = GlobalKey<ScaffoldState>();
  List<TicketDetails> tickets;
  List<TicketDetails> closedTickets;
  List<TicketDetails> waitingTickets;
  List<TicketDetails> missedTickets;
  TabController _tabController;
  final PanelController _pc = new PanelController();
  TicketDetails singleTicket;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
    _tabController.animateTo(0);

    NetworkClient()
        .getTickets(
            token: PreferenceUtils.getString(SharedFields.TOKEN, ""),
            statusIds: ["1", "3", "4"],
            specificDay: "",
            pageNumber: "1",
            pageSize: "1000",
            branchIds: [],
            departmentIds: [])
        .then((result) {
      if (result is SuccessState) {
        setState(() {
          tickets = result.value.data;
          waitingTickets = tickets.where((e) => e.statusId == 1).toList();
          closedTickets = tickets.where((e) => e.statusId == 3).toList();
          missedTickets = tickets.where((e) => e.statusId == 4).toList();
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

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutUtils.wrapWithtinLayoutDirection(
      child: Scaffold(
        key: mainKey,
        drawer: MyDrawer(0, this),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 40,
              color: AppColors.ACCENT_COLOR,
            ),
            // change this size and style
            onPressed: () => mainKey.currentState.openDrawer(),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage("assets/images/beldoor_logo.png"),
              height: 50,
              width: 170,
            ),
          ),
          bottom: TabBar(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            indicatorColor: AppColors.PRIMARY_COLOR,
            labelColor: AppColors.PRIMARY_COLOR,
            unselectedLabelColor: AppColors.ACCENT_COLOR,
            tabs: [
              Tab(
                text: AppStrings.waitingTickets,
              ),
              Tab(
                text: AppStrings.closedTickets,
              ),
              Tab(
                text: AppStrings.missedTickets,
              )
            ],
          ),
          automaticallyImplyLeading: false,
          elevation: 8.0,
        ),
        body: BackgroundWidget(
          child: TabBarView(
//          physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              getWaitingTickets(),
              getClosedTickets(),
              getMissedTickets()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => BranchesScreen()),
            );
          },
          label: Text(
            AppStrings.generateTicket,
            style: TextStyle(fontSize: 16.0, color: AppColors.PRIMARY_COLOR),
          ),
          icon: Icon(
            Icons.add,
            color: AppColors.PRIMARY_COLOR,
          ),
          backgroundColor: AppColors.PRIMARY_DARK_COLOR,
        ),
      ),
    );
  }

  getWaitingTickets() {
    return waitingTickets != null
        ? waitingTickets.isNotEmpty
            ? buildTicketsList(waitingTickets, true)
            : Center(
                child: Text(
                  AppStrings.noWaitingTickets,
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

  getClosedTickets() {
    return closedTickets != null
        ? closedTickets.isNotEmpty
            ? Stack(
                children: [
                  buildTicketsList(closedTickets, false),
                  SlidingUpPanel(
                    minHeight: 0.0,
                    controller: _pc,
                    renderPanelSheet: false,
                    panel: _floatingPanel(),
                    backdropEnabled: true,
                  )
                ],
              )
            : Center(
                child: Text(
                  AppStrings.noClosedTickets,
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

  getMissedTickets() {
    return missedTickets != null
        ? missedTickets.isNotEmpty
            ? Stack(
                children: [
                  buildTicketsList(missedTickets, false),
                  SlidingUpPanel(
                    minHeight: 0.0,
                    controller: _pc,
                    renderPanelSheet: false,
                    panel: _floatingPanel(),
                    backdropEnabled: true,
                  )
                ],
              )
            : Center(
                child: Text(
                  AppStrings.noMissedTickets,
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
    var formatter =
        DateFormat.yMMMEd(AppStrings.isEnglish ? 'en' : 'ar').add_jm();
    print(formatter.locale);
    String formatted = formatter.format(DateTime.parse(date));
    print(DateTime.parse(date).timeZoneName);
    print(formatted);
    return formatted;
  }

  Widget buildTicketsList(List<TicketDetails> items, bool isWaiting) {
    return AnimationLimiter(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: items.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(seconds: 1),
              child: SlideAnimation(
                verticalOffset: 100.0,
                child: ScaleAnimation(
                  child: Card(
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
                                  items[index].ticketNumber.toString(),
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
                                isWaiting
                                    ? Container()
                                    : Align(
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
                                                  singleTicket =
                                                      result.value.data;
                                                });
                                              } else {
                                                mainKey.currentState
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                    (result as ErrorState)
                                                        .msg
                                                        .message,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Helvetica'),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 3),
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
                                Row(
                                  children: [
                                    Text(
                                      AppStrings.branch,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: AppColors.PRIMARY_DARK_COLOR),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppStrings.isEnglish
                                            ? items[index].branchNameEN
                                            : items[index].branchNameAR,
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
                                      AppStrings.department,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: AppColors.PRIMARY_DARK_COLOR),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppStrings.isEnglish
                                            ? items[index].departementNameEN
                                            : items[index].departementNameAR,
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
                                      AppStrings.ticketState,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: AppColors.PRIMARY_DARK_COLOR),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      AppStrings.isEnglish
                                          ? items[index].statusNameEN
                                          : items[index].statusNameAR,
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
                                Row(
                                  children: [
                                    Text(
                                      AppStrings.currentNumber,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: AppColors.PRIMARY_DARK_COLOR),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      items[index].currentNumber.toString(),
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
                                    updateDateFormat(items[index].createTime),
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
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  void loadPage() {
    setState(() {});
  }
}
