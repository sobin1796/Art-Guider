import 'dart:ui';

import 'package:artguider/res/color.dart';
import 'package:artguider/utils/commonwidget.dart';
import 'package:artguider/viewmodel/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridPainter extends CustomPainter {
  final double columnSliderValue;
  final double rowSliderValue;
  final bool drawPlusLines;
  final bool setnumber;
  final double linewidth;
  final Color setcolor;

  GridPainter(this.columnSliderValue, this.rowSliderValue, this.drawPlusLines,
      this.setnumber, this.linewidth, this.setcolor);

  @override
  void paint(Canvas canvas, Size size) {
    double width = linewidth;
    final paint = Paint()
      ..color = setcolor
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    double rowCount = rowSliderValue;
    double colCount = columnSliderValue;

    final double cellWidth = size.width / colCount;
    final double cellHeight = size.height / rowCount;

    for (int i = 0; i <= colCount; i++) {
      double x = i * cellWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (int i = 0; i <= rowCount; i++) {
      double y = i * cellHeight;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    if (setnumber) {
      final textStyle = TextStyle(
        color: setcolor,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      );

      for (int col = 0; col < colCount; col++) {
        String letter = String.fromCharCode(65 + col);

        double x = col * cellWidth;
        double y = 0;

        final paragraphBuilder = ParagraphBuilder(ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: textStyle.fontSize,
        ))
          ..pushStyle(textStyle.getTextStyle())
          ..addText(letter);

        final paragraph = paragraphBuilder.build()
          ..layout(ParagraphConstraints(width: cellWidth));

        canvas.drawParagraph(paragraph, Offset(x + 2, y + 2));
      }

      for (int row = 1; row <= rowCount; row++) {
        String number = row.toString();

        double x = 0;
        double y = row * cellHeight;

        final paragraphBuilder = ParagraphBuilder(ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: textStyle.fontSize,
        ))
          ..pushStyle(textStyle.getTextStyle())
          ..addText(number);

        final paragraph = paragraphBuilder.build()
          ..layout(ParagraphConstraints(width: cellWidth));

        // Draw in the top-left corner
        canvas.drawParagraph(
            paragraph, Offset(x + 2, y + 2)); // Small offset for padding
      }

      // Fill the remaining cells with combinations
      for (int row = 0; row < rowCount; row++) {
        for (int col = 0; col < colCount; col++) {
          String letter = String.fromCharCode(65 + col);
          String number = row.toString();
          String text = '$letter$number';

          double x = col * cellWidth; // X position for the cell
          double y = row * cellHeight; // Y position for the cell

          final paragraphBuilder = ParagraphBuilder(ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: textStyle.fontSize,
          ))
            ..pushStyle(textStyle.getTextStyle())
            ..addText(text);

          final paragraph = paragraphBuilder.build()
            ..layout(ParagraphConstraints(width: cellWidth));

          // Draw in the top-left corner
          canvas.drawParagraph(
              paragraph, Offset(x + 2, y + 2)); // Small offset for padding
        }
      }
    }

    // Draw plus lines if active
    if (drawPlusLines) {
      paint.color = setcolor; // Change color for visibility
      for (int row = 0; row < rowCount; row++) {
        for (int col = 0; col < colCount; col++) {
          double x = col * cellWidth; // X position for the cell
          double y = row * cellHeight; // Y position for the cell

          // Draw the plus sign
          canvas.drawLine(
              Offset(x, y), Offset(x + cellWidth, y + cellHeight), paint); // \
          canvas.drawLine(
              Offset(x, y + cellHeight), Offset(x + cellWidth, y), paint); // /
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

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

void linessetting(BuildContext context) {
  final colorset = Provider.of<CountSeter>(context, listen: false);
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: boxcolor,
        title: const Text(
          'Lines settings',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Line's Width:", style: TextStyle(fontSize: 18)),
              Consumer<CountSeter>(
                builder: (context, countSet, child) {
                  return Slider(
                    value: countSet.lineswidth,
                    min: 1,
                    max: 5,
                    divisions: 5,
                    label: countSet.lineswidth.round().toString(),
                    onChanged: (double newValue) {
                      countSet.lineswidthset(newValue);
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Color:', style: TextStyle(fontSize: 18)),
                  SizedBox(
                    height: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        colorset.colorsset();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.white,
                      ),
                      child: text(name: '.'),
                    ),
                  ),
                  SizedBox(
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          colorset.colorssset();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.black,
                        ),
                        child: text(name: '.'),
                      )),
                ],
              )
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
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Set'),
          ),
        ],
      );
    },
  );
}
