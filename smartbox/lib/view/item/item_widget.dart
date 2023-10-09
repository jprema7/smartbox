import 'package:flutter/material.dart';
import 'package:smartbox/model/item.dart';
class ItemWidget extends StatefulWidget {
  final Item item;

  final Function onDelete;
  final Function? onNameChange;
  final Function? onDescriptionChange;

  const ItemWidget({super.key, required this.item, required this.onDelete, this.onNameChange, this.onDescriptionChange});

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
                        enabled: widget.onNameChange != null,
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
                            _updateNameChange(value);
                          });
                        },
                      ),
                      TextFormField(
                        autofocus: true,
                        enabled: widget.onNameChange != null,
                        initialValue: widget.item.description,
                        decoration: InputDecoration(
                            labelText: 'Description'
                        ),
                        onChanged: (value) {
                          setState(() {
                            _updateDescriptionChange(value);
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

  void _updateNameChange(String value) {
    if (widget.onNameChange != null) {
      widget.onNameChange!(value);
    }
  }

  void _updateDescriptionChange(String value) {
    if (widget.onDescriptionChange != null) {
      widget.onDescriptionChange!(value);
    }
  }
}