import '../models/device.dart';
import '../services/local_json_service.dart';

class DeviceRepository {
  final LocalJsonService _service = LocalJsonService();
  Future<List<Device>> getDevices() => _service.loadDevices();
}
