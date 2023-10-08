import 'package:flutter/material.dart';
import 'package:smartbox/model/storagebox.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class BoxCard extends StatefulWidget {
  final StorageBox? storageBox;
  final Function? onTap;
  BoxCard({required this.storageBox, required this.onTap, super.key});
  @override
  State<BoxCard> createState() => _BoxCardState();
}

class _BoxCardState extends State<BoxCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => widget.onTap,
        leading: SleekCircularSlider(
          appearance: CircularSliderAppearance(
              infoProperties: InfoProperties(
                mainLabelStyle: const TextStyle(
                    color: Colors.white,
                    wordSpacing: -3
                ),
              ),
              size: 50,
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
          initialValue: widget.storageBox!.fullness,
        ),
        title: Text(widget.storageBox!.name),
      ),
    );
  }
}
