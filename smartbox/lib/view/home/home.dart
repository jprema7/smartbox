import 'package:flutter/material.dart';
import 'package:smartbox/model/storagebox.dart';
import 'package:smartbox/service/storagebox_service.dart';
import 'package:smartbox/view/home/box_card.dart';
import 'package:smartbox/util/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<StorageBox> storageBoxes = [];

  void loadData() async {
    await StorageBoxService.instant()
        .getStorageBoxes()
        .then((value) {
            setState(() {
                storageBoxes = value;
            });
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppConstants.appBarTitle),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: storageBoxes.length,
                itemBuilder: (context, index) {
                  return BoxCard(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.VIEW_STORAGE_BOX_RECORD, arguments: {'storage_box_record': storageBoxes[index]});
                      },
                      storageBox: storageBoxes[index]);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.GENERATE_QR);
                        },
                        child: const Text(
                          'Generate QR',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        )),
                  ),
                  VerticalDivider(
                    thickness: 1.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.SCAN_QR);
                      },
                      child: const Text(
                        'Scan QR',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
