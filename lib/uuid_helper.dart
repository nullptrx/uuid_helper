import 'dart:async';

import 'package:flutter/services.dart';

class UUIDHelper {
  UUIDHelper._();

  static const kChannelName = 'nullptrx.github.io/uuid_helper';

  static const MethodChannel _channel = const MethodChannel(kChannelName);

  /// Get uuid
  static Future<String> getUniqueId() async {
    final String version = await _channel.invokeMethod('getUniqueId');
    return version;
  }
}
