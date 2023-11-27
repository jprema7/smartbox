import 'package:flutter/material.dart';
import 'package:smartbox/model/storagebox.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smartbox/view/item/item_widget.dart';
class ViewStorageBox extends StatefulWidget {
  const ViewStorageBox({super.key});

  @override
  State<ViewStorageBox> createState() => _ViewStorageBoxState();
}

class _ViewStorageBoxState extends State<ViewStorageBox> {

  @override
  Widget build(BuildContext context) {

    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    StorageBox storageBox = arguments['storage_box_record'];

    Color qrColor = Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(storageBox.name),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(flex: 5, child:
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 1.0, minHeight: 1.0, maxHeight: 50.0, maxWidth: 1.0),
                        child: QrImageView(
                          backgroundColor: Colors.white,
                          data: storageBox.id,
                          version: QrVersions.auto,
                          eyeStyle: QrEyeStyle(color: qrColor, eyeShape: QrEyeShape.square),
                          dataModuleStyle: QrDataModuleStyle(color: qrColor, dataModuleShape: QrDataModuleShape.square),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text('Fullness'),
                          SleekCircularSlider(
                            appearance: CircularSliderAppearance(
                                infoProperties: InfoProperties(
                                  mainLabelStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      wordSpacing: -3
                                  ),
                                ),
                                size: 150,
                                customWidths: CustomSliderWidths(progressBarWidth: 10, trackWidth: 1),
                                customColors: CustomSliderColors(
                                    trackColor: Colors.grey,
                                    progressBarColors: [
                                      Colors.red,
                                      Colors.orange,
                                      Colors.green,
                                    ])),
                            min: 0,
                            max: 100,
                            initialValue: storageBox.fullness,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
            ),
            Divider(height: 50),
            Expanded(flex: 1, child: Text('Items')),
            Expanded(flex: 15, child:
              SingleChildScrollView(
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
                          );
                      }).toList(growable: true)
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
