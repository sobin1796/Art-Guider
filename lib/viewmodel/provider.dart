import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// haha yo chai naviagation ko lagi ho hai

class BarnaviProvider with ChangeNotifier {
  int seectedIndex = 1;
  int get value => seectedIndex;
  void setValue(int value) {
    seectedIndex = value;
    notifyListeners();
  }
}

//toggle set for cross lines
class Crossset with ChangeNotifier {
  bool _crosslineActive = true;

  bool get isCrosslineActive => _crosslineActive;

  void toggleCrossline() {
    _crosslineActive = !_crosslineActive;
    notifyListeners();
  }
}

//toggle for Number Set
class NumberSet with ChangeNotifier {
  bool _letterActive = true;

  bool get isletterlineActive => _letterActive;

  void toggleletterline() {
    _letterActive = !_letterActive;
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}

class CountSeter with ChangeNotifier {
  //color set for Number Row And Column
  double _sliderValue = 5;
  double _rowslider = 5;
  double get rowcount => _rowslider;
  double get coumncount => _sliderValue;
  void setCoumncount(double value) {
    _sliderValue = value;
    notifyListeners();
  }

  void setRowcount(double rvalue) {
    _rowslider = rvalue;
    notifyListeners();
  }

  double _lineswidth = 2;

  double get lineswidth => _lineswidth;

  void lineswidthset(double value) {
    _lineswidth = value;
    notifyListeners();
  }

  //color set for all values
  Color _setColor = const Color.fromARGB(255, 0, 0, 0);
  Color get setcolor => _setColor;

  void colorsset() {
    _setColor = Colors.white;

    notifyListeners();
  }

  void colorssset() {
    _setColor = const Color.fromARGB(255, 0, 0, 0);

    notifyListeners();
  }
}

class imageset with ChangeNotifier {
  bool _letterActive = true;

  bool get isletterlineActive => _letterActive;

  void toggleletterline() {
    _letterActive = !_letterActive;
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}

class Uploadimage with ChangeNotifier {
  XFile? image;
  XFile? get isletterlineActive => image;

  void upload() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    image = null;
  }
}
