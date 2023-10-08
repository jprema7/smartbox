import 'package:flutter/material.dart';
import 'package:smartbox/util/constants.dart';
import 'package:smartbox/model/storagebox.dart';
import 'package:smartbox/service/storagebox_service.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
class SetFullness extends StatefulWidget {
  const SetFullness({super.key});

  @override
  State<SetFullness> createState() => _SetFullnessState();
}

class _SetFullnessState extends State<SetFullness> {
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    StorageBox storageBox = arguments['storage_box_record'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Set Storage Fullness'),
      ),
      body: Column(
        children: [
          Expanded(flex: 5, child:
            Container(child:
              Center(child:
                SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                      infoProperties: InfoProperties(
                        mainLabelStyle: const TextStyle(
                            color: Colors.white,
                            wordSpacing: -3
                        ),
                      ),
                      size: 300,
                      customWidths: CustomSliderWidths(progressBarWidth: 5, trackWidth: 1),
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
                  onChange: (double value) {
                    setState(() {
                      storageBox.fullness = value;
                    });
                  },
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
                  VerticalDivider(thickness: 1.0),
                  Expanded(flex: 1, child: MaterialButton(
                    child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 20.0,
                        )
                    ),
                    onPressed: () {
                      StorageBoxService.instant().createStorageBox(storageBox);
                      Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
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
