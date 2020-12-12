import 'package:bel_dor/screen/tickets_history_filter.dart';
import 'package:flutter/material.dart';

import 'app_localization.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final mainKey;
  final bool showSearch;

  const MyCustomAppBar(
      {Key key, @required this.mainKey, @required this.showSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Visibility(
          visible: showSearch,
          child: IconButton(
            icon: Icon(
              Icons.search,
              size: 40,
              color: Color(0xffCBEEF3),
            ),
            onPressed: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => TicketsHistoryFilter()),
              )
            },
          ),
        )
      ],
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          size: 40,
          color: Color(0xffCBEEF3),
        ),
        // change this size and style
        onPressed: () => mainKey.currentState.openDrawer(),
      ),
      title: Text(
        AppLocalizations
            .of(context)
            .title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xffCBEEF3),
            fontSize: 30.0,
            fontWeight: FontWeight.bold),
      ),
      automaticallyImplyLeading: false,
      elevation: 8.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
