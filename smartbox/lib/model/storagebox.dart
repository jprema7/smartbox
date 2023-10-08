import 'dart:ui';

import 'package:smartbox/model/item.dart';

class StorageBox {
  String id;
  String name;
  double fullness;

  bool flammable;

  bool hazardous;

  bool fragile;

  int qrCodeColor; // TODO: Capture QR Code Color in GENERATE QR UI

  List<Item> items;

  // TODO: Add storage area attribute

  StorageBox(
      {
        required this.id,
        this.name = '',
        List<Item>? items,
        this.fullness = 0,
        this.flammable = false,
        this.hazardous = false,
        this.fragile = false,
        this.qrCodeColor = 000000
      }) : items = items ?? [];

  @override
  String toString() {
    return 'StorageBox[id=$id, name=$name, items=$items, '
        'fullness=$fullness, flammable=$flammable, hazardous=$hazardous, fragile=$fragile, qrCodeColor=$qrCodeColor]';
  }
}