import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/device.dart';

class LocalJsonService {
  Future<List<Device>> loadDevices() async {
    final indexJson = await rootBundle.loadString('assets/devices_index.json');
    final List<dynamic> index = json.decode(indexJson);

    final devices = <Device>[];
    for (final item in index) {
      final folder = item['folder'] as String;
      final infoJson =
          await rootBundle.loadString('assets/devices/$folder/info.json');
      devices.add(Device.fromJson(json.decode(infoJson) as Map<String, dynamic>));
    }
    return devices;
  }
}
