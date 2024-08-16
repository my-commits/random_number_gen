import 'dart:math';
import 'package:flutter/foundation.dart';

class RandomLogic with ChangeNotifier, DiagnosticableTreeMixin {
  // final String _errorMessage = "Неверный формат числа";
  // final String _pressGenText = 'Нажмите кнопку "СГЕНЕРИРОВАТЬ".';
  // final String _errorReturn = "Сначала введите числа";

  int _start = 1;
  bool _startError = false;
  int _end = 100;
  bool _endError = false;
  bool _internalError = false;
  int _result = 0;

  String get start => _start.toString();
  bool get startError => _startError;
  String get end => _end.toString();
  bool get endError => _endError;
  String get result => _result.toString();

  bool get errorStatus => _internalError;

  set start(String value) {
    int? intValue = int.tryParse(value);
    if (intValue != null) {
      _start = intValue;
      _internalError = false;
      _startError = false;
    } else {
      _internalError = true;
      _startError = true;
    }
    notifyListeners();
  }

  set end(String value) {
    int? intValue = int.tryParse(value);
    if (intValue != null) {
      _end = intValue;
      _internalError = false;
      _endError = false;
    } else {
      _internalError = true;
      _endError = true;
    }
    notifyListeners();
  }

  void generate() {
    if (!_internalError) {
      _result = Random().nextInt((_end - _start) + 1) + _start;
    }
    notifyListeners();
  }
}
