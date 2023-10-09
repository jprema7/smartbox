import 'package:flutter/material.dart';
import 'package:smartbox/model/item.dart';
import 'package:smartbox/util/constants.dart';
import 'package:smartbox/model/storagebox.dart';
import 'package:smartbox/service/storagebox_service.dart';
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
                      var isFormValid = _formKey.currentState!.validate();
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

class ItemWidget extends StatefulWidget {
  final Item item;

  final Function onDelete;
  final Function onNameChange;
  final Function onDescriptionChange;

  const ItemWidget({super.key, required this.item, required this.onDelete, required this.onNameChange, required this.onDescriptionChange});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 175,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Focus(
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        initialValue: widget.item.name,
                        decoration: InputDecoration(
                          labelText: 'Item Name'
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please specify item an name";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            widget.onNameChange(value);
                          });
                        },
                      ),
                      TextFormField(
                        autofocus: true,
                        initialValue: widget.item.description,
                        decoration: InputDecoration(
                            labelText: 'Description'
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.onDescriptionChange(value);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 80.0),
              Expanded(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    iconColor: Colors.red[900],
                  ),
                  child: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      widget.onDelete(widget.item);
                    });
                  },
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
