import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color hexToColor(String hexCode) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hexCode),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hexCode.substring(1), radix: 16) +
        (hexCode.length == 7 ? 0xff000000 : 0x00000000),
  );
}

double pxToDouble({required double px}) {
  return 0.08333333 * px;
}

String formatToCurrency(dynamic d) {
  final f = NumberFormat("###,###.###", "tr_TR");
  final res = f.format(
      d.runtimeType == double ? d.truncateToDouble() : (d as int).truncate());
  return res;
}
