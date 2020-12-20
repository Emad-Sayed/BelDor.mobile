import 'package:bel_dor/screen/tickets_history_filter.dart';
import 'package:bel_dor/utils/utils.dart';
import 'package:flutter/material.dart';

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
              color: AppColors.ACCENT_COLOR,
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
          color: AppColors.ACCENT_COLOR,
        ),
        // change this size and style
        onPressed: () => mainKey.currentState.openDrawer(),
      ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(
          image: AssetImage("assets/images/beldoor_logo.png"),
          height: 60,
          width: 150,
        ),
      ),
      automaticallyImplyLeading: false,
      elevation: 8.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
