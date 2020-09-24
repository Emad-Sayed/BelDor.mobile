import 'package:flutter/material.dart';

import 'app_localization.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final mainKey;

  const MyCustomAppBar({
    Key key,
    @required this.mainKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            size: 40,
            color: Color(0xffCBEEF3),
          ),
          onPressed: () => {},
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
        AppLocalizations.of(context).title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xffCBEEF3), fontSize: 30.0, fontWeight: FontWeight.bold),
      ),
      automaticallyImplyLeading: false,
      elevation: 8.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
