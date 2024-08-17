import 'dart:math';
import 'package:flutter/foundation.dart';

class RandomLogic with ChangeNotifier, DiagnosticableTreeMixin {
  int _start = 1;
  bool _startError = false;
  int _end = 10;
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
      if (_start < _end && _start <= 4294967296) {
        _internalError = false;
        _startError = false;
      } else {
        _internalError = true;
        _startError = true;
      }
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
      if (_start < _end && _end <= 4294967296) {
        _internalError = false;
        _endError = false;
      } else {
        _internalError = true;
        _endError = true;
      }
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
