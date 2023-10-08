import 'package:flutter/material.dart';
import 'package:smartbox/util/constants.dart';
import 'package:smartbox/model/storagebox.dart';
import 'package:smartbox/view/checkbox_form_field.dart';
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
            child: Center(child: StorageBoxHeaderForm(storageBoxId))
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

class StorageBoxHeaderForm extends StatefulWidget {
  final String storageBoxID;

  const StorageBoxHeaderForm(this.storageBoxID, {super.key});

  @override
  State<StorageBoxHeaderForm> createState() => _StorageBoxHeaderFormState();
}

class _StorageBoxHeaderFormState extends State<StorageBoxHeaderForm> {

  final _formKey = GlobalKey<FormState>();
  final StorageBox storageBox = StorageBox();

  @override
  Widget build(BuildContext context) {
    storageBox.id = widget.storageBoxID;

    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: _form_column_widgets(storageBox),
        ),
      ),
    );
  }

  List<Widget> _form_column_widgets(StorageBox storageBox) {
    return <Widget> [
          TextField(
            controller: TextEditingController(text: storageBox.id),
            enabled: false,
            decoration: InputDecoration(
                labelText: 'ID',
            ),
          ),
          TextField(
            controller: TextEditingController(text: storageBox.name),
            decoration: InputDecoration(
              labelText: 'Name',
            ),
          ),
          InputDecorator(decoration: InputDecoration(labelText: 'Flammable'),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Checkbox(value: storageBox.flammable,
                      onChanged: (newValue) {
                        setState(() {
                          storageBox.flammable = newValue ?? storageBox.flammable;
                        });
                      }
                  ))
          ),
          InputDecorator(decoration: InputDecoration(labelText: 'Hazardous'),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Checkbox(value: storageBox.hazardous,
                      onChanged: (newValue) {
                        setState(() {
                          storageBox.hazardous = newValue ?? storageBox.hazardous;
                        });
                      }
                  ))
          ),
          InputDecorator(decoration: InputDecoration(labelText: 'Fragile'),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Checkbox(value: storageBox.fragile,
                      onChanged: (newValue) {
                        setState(() {
                            storageBox.fragile = newValue ?? storageBox.fragile;
                        });
                      }
                  ))
          ),
          // TextFormField(
          //   decoration: const InputDecoration(
          //     labelText: 'ID',
          //   ),
          //   // The validator receives the text that the user has entered.
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter some text';
          //     }
          //     return null;
          //   },
          //   initialValue: widget.storageBoxID,
          //   enabled: false,
          // ),
          // TextFormField(
          //   decoration: const InputDecoration(
          //     hintText: 'What is the name of the storage box?',
          //     labelText: 'Name',
          //   ),
          //   // The validator receives the text that the user has entered.
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Name required*';
          //     } else {
          //       return null;
          //     }
          //   },
          //   onChanged: (value) => storageBox.name = value,
          // ),


          // CheckboxFormField(
          //   initialValue: storageBox.flammable,
          //   onChanged: (value) => storageBox.flammable = value,
          // ),
          // CheckboxFormField(
          //   title: Text('Hazardous'),
          //   initialValue: storageBox.hazardous,
          //   onChanged: (value) => storageBox.hazardous = value,
          // ),
          // CheckboxFormField(
          //   title: Text('Fragile'),
          //   initialValue: storageBox.fragile,
          //   onChanged: (value) => storageBox.fragile = value,
          // ),
        ];
  }
}

