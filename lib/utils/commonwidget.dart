import 'package:artguider/res/color.dart';
import 'package:flutter/material.dart';

Widget text({String? name, double? size, Color? colr}) {
  return Text(
    name!,
    style: TextStyle(color: colr, fontSize: size, fontWeight: FontWeight.bold),
  );
}

Widget devider() {
  return const Divider(
    thickness: 2,
    endIndent: 20,
    indent: 20,
    color: Colors.white,
  );
}

Widget Iconcontainer(
    {double? heights,
    double? textsize,
    double? widths,
    String? imageurl,
    Color? textcolors,
    String? label,
    double? angle,
    BuildContext? context}) {
  return SizedBox(
    height: MediaQuery.of(context!).size.height / heights!,
    width: MediaQuery.of(context).size.width / widths!,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 25,
          width: MediaQuery.of(context).size.width / 13,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(angle!)),
          child: Padding(
            padding: const EdgeInsets.all(1.7),
            child: Image.asset(
              imageurl!,
              height: 5,
              width: 5,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(
          label ?? 'no value ',
          style: const TextStyle(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

Widget customIcon({
  required Function func,
  required BuildContext context,
  String? imageurl,
  String? label,
}) {
  return InkWell(
    onTap: () {
      func(); // Toggle plus lines
    },
    child: Iconcontainer(
      context: context,
      imageurl: imageurl,
      heights: 6,
      widths: 5,
      angle: 5,
      textcolors: Colors.black,
      label: label,
      textsize: 12,
    ),
  );
}
