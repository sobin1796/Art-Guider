import 'dart:io';

import 'package:artguider/res/color.dart';
import 'package:artguider/utils/commonwidget.dart';
import 'package:artguider/view/homepage/gridpage/gridpainter.dart';
import 'package:artguider/viewmodel/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridPage extends StatefulWidget {
  const GridPage({super.key});

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CountSeter>(context);
    final crossProvider = Provider.of<Crossset>(context);
    final numberset = Provider.of<NumberSet>(context, listen: false);
    final widthset = Provider.of<CountSeter>(context, listen: false);
    final colorset = Provider.of<CountSeter>(context, listen: false);
    final uploadimage = Provider.of<Uploadimage>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: boxcolor,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Iconcontainer(
                  context: context,
                  imageurl: 'assets/grid.png',
                  heights: 6,
                  widths: 5,
                  angle: 5,
                  textcolors: Colors.black,
                  label: 'Grid',
                  textsize: 12,
                ),
              ),
              const SizedBox(width: 8), // Using a constant for spacing
              InkWell(
                onTap: () {
                  crossProvider.toggleCrossline(); // Toggle plus lines
                },
                child: Iconcontainer(
                  context: context,
                  imageurl: 'assets/gridImage/Grid.png',
                  heights: 6,
                  widths: 5,
                  angle: 5,
                  textcolors: Colors.black,
                  label: 'Cross',
                  textsize: 12,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  linessetting(context);
                },
                child: Iconcontainer(
                  context: context,
                  imageurl: 'assets/gridImage/menu.png',
                  heights: 6,
                  widths: 5,
                  angle: 5,
                  textcolors: Colors.black,
                  label: 'Lines & Color',
                  textsize: 12,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {},
                child: Iconcontainer(
                  context: context,
                  imageurl: 'assets/gridImage/download.png',
                  heights: 6,
                  widths: 5,
                  angle: 5,
                  textcolors: Colors.black,
                  label: 'Save',
                  textsize: 12,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: backgroundColor,
        child: Center(
          child: InteractiveViewer(
            panEnabled: true,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final imageWidth = uploadimage.image != null
                    ? File(uploadimage.image!.path).lengthSync().toDouble()
                    : constraints.maxWidth;
                final imageHeight = uploadimage.image != null
                    ? File(uploadimage.image!.path).lengthSync().toDouble()
                    : constraints.maxWidth;

                final aspectRatio = imageWidth / imageHeight;

                return Stack(
                  children: [
                    if (uploadimage.image == null)
                      Align(
                        alignment: Alignment.center,
                        child: Card(
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  uploadimage.upload();
                                },
                                child: text(name: ' gallery'),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: text(name: 'Camera')),
                            ],
                          ),
                        ),
                      ),
                    if (uploadimage.image != null)
                      Align(
                        alignment: Alignment.center,
                        child: Image.file(
                          File(uploadimage.image!.path),
                          width: imageWidth,
                          height: imageHeight,
                          fit: BoxFit.contain,
                        ),
                      ),
                    if (uploadimage.image != null)
                      Align(
                        alignment: Alignment.center,
                        child: CustomPaint(
                            size: Size(
                                imageWidth,
                                imageWidth /
                                    aspectRatio), // Maintain aspect ratio
                            painter: GridPainter(
                              provider.coumncount,
                              provider.rowcount,
                              crossProvider.isCrosslineActive,
                              numberset.isletterlineActive,
                              widthset.lineswidth,
                              colorset.setcolor,
                            )),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          splashColor: boxcolor,
                          backgroundColor: titleColor,
                          onPressed: () {
                            uploadimage.upload();
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
