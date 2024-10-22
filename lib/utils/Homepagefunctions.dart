import 'package:artguider/res/color.dart';
import 'package:artguider/viewmodel/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAlertDialog(BuildContext context) {
  final countset = Provider.of<CountSeter>(context, listen: false);
  double cumnslidervalue = countset.coumncount;
  double rowslidervalue = countset.rowcount;
  final numberset = Provider.of<NumberSet>(context, listen: false);

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: boxcolor,
        title: const Text(
          'Set column & Row count:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Total Column :', style: TextStyle(fontSize: 18)),
              Slider(
                value: cumnslidervalue,
                min: 3,
                max: 30,
                divisions: 30,
                label: cumnslidervalue.round().toString(),
                onChanged: (double newValue) {
                  cumnslidervalue = newValue;
                  (dialogContext as Element).markNeedsBuild();
                },
              ),
              const Text('Total Row :', style: TextStyle(fontSize: 18)),
              Slider(
                value: rowslidervalue,
                min: 3,
                max: 30,
                divisions: 30,
                label: rowslidervalue.round().toString(),
                onChanged: (double newValue) {
                  rowslidervalue = newValue;
                  (dialogContext as Element).markNeedsBuild();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Numbers:', style: TextStyle(fontSize: 22)),
                  Switch(
                    activeColor: Colors.green, // Color when active
                    inactiveThumbColor: Colors.red, // Color when inactive
                    value: numberset.isletterlineActive,
                    onChanged: (bool value) {
                      numberset.toggleletterline(); // Toggle the switch state
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              countset.setCoumncount(cumnslidervalue);
              countset.setRowcount(rowslidervalue); // Update the parent state
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Set'),
          ),
        ],
      );
    },
  );
}
