import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/content_file.dart';
import '../../data/models/device.dart';
import '../../data/repositories/device_repository.dart';

class DeviceDetailPage extends StatefulWidget {
  final String deviceId;
  const DeviceDetailPage({super.key, required this.deviceId});

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  late Future<List<Device>> _future;

  @override
  void initState() {
    super.initState();
    _future = DeviceRepository().getDevices();
  }

  IconData _iconFor(ContentFile file) {
    switch (file.type) {
      case 'video':
        return Icons.play_circle_outline;
      case 'quick_guide':
        return Icons.flash_on;
      case 'manual':
        return Icons.menu_book;
      default:
        return Icons.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جزئیات دستگاه'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: FutureBuilder<List<Device>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('خطا: ${snapshot.error}'));
          }
          final devices = snapshot.data ?? [];
          Device? device;
          try {
            device = devices.firstWhere((d) => d.id == widget.deviceId);
          } catch (_) {
            device = null;
          }
          if (device == null) {
            return const Center(child: Text('دستگاه یافت نشد'));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('مدل: ${device.model}'),
                      if (device.description.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(device.description),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'محتوای موجود',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...device.files.map(
                (file) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(_iconFor(file)),
                    title: Text(file.title),
                    trailing: const Icon(Icons.chevron_left),
                    onTap: () {
                      if (file.isVideo) {
                        context.push('/video', extra: file.path);
                      } else {
                        context.push('/pdf', extra: file.path);
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
