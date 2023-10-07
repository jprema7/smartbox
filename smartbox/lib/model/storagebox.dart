import 'package:smartbox/model/item.dart';

class StorageBox {
  String id;
  String name;
  double fullness;

  bool flammable;

  bool hazardous;

  bool fragile;

  List<Item> items;

  // TODO: Add storage area attribute

  StorageBox(
      {required this.id,
      required this.name,
      List<Item>? items,
      this.fullness = 0,
      this.flammable = false,
      this.hazardous = false,
      this.fragile = false})
      : items = items ?? [];
}
