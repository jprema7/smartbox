import 'package:flutter/material.dart';
import 'package:smartbox/util/constants.dart';
import 'package:smartbox/model/storagebox.dart';
import 'package:smartbox/services/storagebox_service.dart';
class AddStorageItems extends StatefulWidget {
  const AddStorageItems({super.key});

  @override
  State<AddStorageItems> createState() => _AddStorageItemsState();
}

class _AddStorageItemsState extends State<AddStorageItems> {
  @override
  Widget build(BuildContext context) {

    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    StorageBox storageBox = arguments['storage_box_record'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Items'),
      ),
      body: Column(
        children: [
          Expanded(flex: 5, child:
            Container(child:
              Center(child: Text('Add Items'))
            )
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(flex: 1, child: MaterialButton(
                    child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20.0,
                        )
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                              title: Center(child: const Text('Confirmation')),
                              content: const Text('Are you sure to want to cancel?'),
                              actions: [
                                // The "Yes" button
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(context, Routes.HOME);
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      // Close the dialog
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No'))
                              ],
                            );
                          });
                    },
                  )),
                  VerticalDivider(thickness: 1.0,),
                  Expanded(flex: 1, child: MaterialButton(
                    child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 20.0,
                        )
                    ),
                    onPressed: () {
                      StorageBoxService.instance().createStorageBox(storageBox);
                      Navigator.pushReplacementNamed(context, Routes.HOME);
                    },
                  ))
                ],
              )
          )
        ]
      ),
    );
  }
}
