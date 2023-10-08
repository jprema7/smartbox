import 'package:flutter/material.dart';
import 'package:smartbox/view/home/home.dart';
import 'package:smartbox/view/home/new_storage_box_flow/add_storage_header.dart';
import 'package:smartbox/view/home/new_storage_box_flow/add_storage_items.dart';
import 'package:smartbox/view/home/new_storage_box_flow/set_fullness.dart';
import 'package:smartbox/view/home/scan_qr.dart';
import 'package:smartbox/view/home/generate_qr.dart';
import 'package:smartbox/view/home/new_storage_box_flow/add_storage_header.dart';
import 'package:smartbox/view/home/new_storage_box_flow/add_storage_items.dart';
import 'package:smartbox/util/constants.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true
  ),
  routes: {
    Routes.HOME : (context) => Home(),
    Routes.SCAN_QR : (context) => ScanQR(),
    Routes.GENERATE_QR : (context) => GenerateQR(),
    Routes.ADD_STORAGE_HEADER_DETAILS : (context) => AddStorageHeader(),
    Routes.ADD_STORAGE_ITEMS : (context) => AddStorageItems(),
    Routes.SET_FULLNESS : (context) => SetFullness(),
  },
));


