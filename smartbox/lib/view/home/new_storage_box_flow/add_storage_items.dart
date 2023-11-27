import 'package:flutter/material.dart';
import 'package:smartbox/model/item.dart';
import 'package:smartbox/util/constants.dart';
import 'package:smartbox/model/storagebox.dart';
import 'package:smartbox/view/item/item_widget.dart';
class AddStorageItems extends StatefulWidget {
  const AddStorageItems({super.key});

  @override
  State<AddStorageItems> createState() => _AddStorageItemsState();
}

class _AddStorageItemsState extends State<AddStorageItems> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    StorageBox storageBox = arguments['storage_box_record'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  storageBox.addItem('');
                });
              },
              icon: Icon(Icons.add_box_outlined),
              iconSize: 30.0,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(flex: 5, child:
            Container(child:
            (storageBox.items.isEmpty)?
            Center(child: Text('Add Items')):
              SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: storageBox.items.indexed.map((element) {
                        return ItemWidget(
                            key: ObjectKey(element.$2),
                            item: element.$2,
                            onDelete: (item) {
                              setState(() {
                                storageBox.items.remove(item);
                              });
                            },
                            onNameChange: (value) {
                              element.$2.name = value;
                            },
                            onDescriptionChange: (value) {
                              element.$2.description = value;
                            }
                        );
                      }).toList(growable: true)
                ),
                  ),
              )
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
                                      Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
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
                      var isFormValid = storageBox.items.isEmpty || _formKey.currentState!.validate();
                      if (isFormValid) {
                         Navigator.pushNamed(context, Routes.SET_FULLNESS,  arguments: { 'storage_box_record' : storageBox });
                      }
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