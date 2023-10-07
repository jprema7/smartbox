import 'package:flutter/material.dart';
import 'package:smartbox/constants.dart';
import 'package:smartbox/model/storagebox.dart';
class AddStorageHeader extends StatefulWidget {
  const AddStorageHeader({super.key});
  @override
  State<AddStorageHeader> createState() => _AddStorageHeaderState();
}

class _AddStorageHeaderState extends State<AddStorageHeader> {
  @override
  Widget build(BuildContext context) {

    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String storageBoxId = arguments['storage_box_id'];
    StorageBox storageBox = StorageBox(id: storageBoxId, name: '');

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Storage Details')
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
                child: Center(child: Text('Storage Box ID: $storageBoxId')),
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
                      'Next',
                      style: TextStyle(
                        fontSize: 20.0,
                      )
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.ADD_STORAGE_ITEMS,
                        arguments: {'storage_box_record' : storageBox}
                    );
                  },
                ))
              ],
            )
          )
        ],
      ),
    );
  }
}
