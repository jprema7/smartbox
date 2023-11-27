import 'package:flutter/material.dart';
import 'package:smartbox/util/constants.dart';
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
    StorageBox storageBox = StorageBox(id: storageBoxId);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Storage Details')
      ),
      body: StorageHeaderForm(storageBox)
    );
  }
}

class StorageHeaderForm extends StatefulWidget {
  final StorageBox storageBox;
  const StorageHeaderForm(this.storageBox, {super.key});

  @override
  State<StorageHeaderForm> createState() => _StorageHeaderFormState();
}

class _StorageHeaderFormState extends State<StorageHeaderForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    StorageBox storageBox = widget.storageBox;

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Expanded(
              flex: 5,
              child: Center(child: _buildForm(storageBox))
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: _buildNavigationButtons(context, storageBox),
              )
          )
        ],
      ),
    );
  }

  Widget? _buildForm(StorageBox storageBox) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: <Widget> [
          TextFormField(
            initialValue: storageBox.id,
            enabled: false,
            decoration: InputDecoration(
              labelText: 'ID',
            ),
          ),
          TextFormField(
            initialValue: storageBox.name,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
            onChanged: (value) {
              storageBox.name = value;
            },
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
        ],
      ),
    );
  }
  List<Widget> _buildNavigationButtons(BuildContext context, StorageBox storageBox) {
    return [
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
            Navigator.pushNamed(context, Routes.ADD_STORAGE_ITEMS,
                arguments: {'storage_box_record' : storageBox}
            );
          }
        },
      ))
    ];
  }
}

