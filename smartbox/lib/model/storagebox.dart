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
      {this.id = '',
      this.name = '',
      List<Item>? items,
      this.fullness = 0,
      this.flammable = false,
      this.hazardous = false,
      this.fragile = false})
      : items = items ?? [];

  @override
  String toString() {
    return 'StorageBox[id=$id, name=$name, items=$items, '
        'fullness=$fullness, flammable=$flammable, hazardous=$hazardous, fragile=$fragile]';
  }

}
