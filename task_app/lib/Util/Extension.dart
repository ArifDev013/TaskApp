import 'package:flutter/cupertino.dart';

extension AppContext on BuildContext {
  Size getSize() => MediaQuery.of(this).size;
}

extension StringHelper on String? {
  bool isNullOrEmpty() => this != null || this!.isNotEmpty ? false : true;
}
