import 'package:smartbox/model/storagebox.dart';

class StorageBoxController {

  static late StorageBox _storageBox;

  static StorageBox initStorageBox(String storageBoxID){
    _storageBox = StorageBox(id: storageBoxID);
    return _storageBox;
  }

  static StorageBox setStorageBox(StorageBox storageBox) {
    _storageBox = storageBox;
    return storageBox;
  }

  static StorageBox getStorageBox() {
    return _storageBox;
  }

}