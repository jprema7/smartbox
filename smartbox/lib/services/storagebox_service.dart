import 'package:smartbox/model/storagebox.dart';
import 'package:smartbox/model/item.dart';
class StorageBoxService {

  static StorageBoxService instance() => StorageBoxService();

  List<StorageBox> storageBoxes = [
    StorageBox(id: '1', name: 'Electrical Box', fullness: 50.0, items: [
      Item(id: '1', name: 'Charger', description: 'Phone Charger'),
      Item(id: '2', name: 'Extension'),
    ]),
    StorageBox(id: '2', name: 'Books Box', fullness: 39.0, items: [
      Item(id: '1', name: 'Peter Pan')
    ]),
    StorageBox(id: '3', name: 'Makeup Box', fullness: 100.0,),
    StorageBox(id: '4', name: 'Confidential Document Box', fullness: 2.0,),
    StorageBox(id: '5', name: 'Photo Box', fullness: 88.0,),
    StorageBox(id: '6', name: 'Crafts & Supplies Box', fullness: 78.6,),
  ];

  Future<List<StorageBox>> getStorageBoxes() {
    return Future.value(storageBoxes);
  }

  StorageBox createStorageBox(StorageBox storageBox) {
    storageBoxes.add(storageBox);
    // Save smart box
    return storageBox;
  }

  StorageBox updateStorageBox(StorageBox storageBox) {
    storageBoxes.remove(storageBox);
    storageBoxes.add(storageBox);
    return storageBox;
  }
}