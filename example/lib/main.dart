import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid_helper/uuid_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _uuid = 'Unknown';

  @override
  void initState() {
    super.initState();
    initUuid();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initUuid() async {
    String uuid;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      uuid = await UUIDHelper.getUniqueId();
    } on PlatformException {
      uuid = 'Failed to get UUID.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _uuid = uuid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('UUID: $_uuid\n'),
        ),
      ),
    );
  }
}
