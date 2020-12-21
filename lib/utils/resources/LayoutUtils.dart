import 'dart:ui';

import 'package:bel_dor/utils/resources/app_strings.dart';
import 'package:flutter/material.dart';

class LayoutUtils {
  static TextDirection getLayoutDirection() {
    return AppStrings.isEnglish ? TextDirection.ltr : TextDirection.rtl;
  }

  static Widget wrapWithtinLayoutDirection({Widget child}) {
    return new Directionality(
        textDirection: getLayoutDirection(), child: child);
  }
}
