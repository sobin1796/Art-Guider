import 'package:artguider/res/color.dart';
import 'package:artguider/utils/commonwidget.dart';
import 'package:artguider/view/homepage/gridpage/gridpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Start Your Art Journey ',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: SizedBox(
                  height: 350,
                  width: 350,
                  child: Lottie.asset('assets/themeimage.json'),
                ),
              ),
              devider(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: text(name: 'Tools :', size: 24, colr: titleColor)),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4.8,
                    width: MediaQuery.of(context).size.width / 2.4,
                    decoration: BoxDecoration(
                        color: boxcolor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const GridPage()));
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height / 11,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Image.asset('assets/grid.png')),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        text(name: 'Grid', colr: titleColor, size: 16),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4.8,
                    width: MediaQuery.of(context).size.width / 2.4,
                    decoration: BoxDecoration(
                        color: boxcolor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height / 11,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset('assets/pencil.png')),
                        const SizedBox(
                          height: 10,
                        ),
                        text(name: 'Sketch', colr: titleColor, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
