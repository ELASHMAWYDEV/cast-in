import 'dart:developer';

import 'package:flutter/foundation.dart';

void appDebugger(message, {Object? error}) {
  if (kDebugMode) {
    if (error != null) {
      log(message, error: error);
    } else {
      log(message.toString());
    }
  }
}
