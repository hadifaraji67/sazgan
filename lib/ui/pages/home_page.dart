import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/device.dart';
import '../../data/repositories/device_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Device>> _devicesFuture;

  @override
  void initState() {
    super.initState();
    _devicesFuture = DeviceRepository().getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ویکی سازگان'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: FutureBuilder<List<Device>>(
        future: _devicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text('خطا: ${snapshot.error}'),
              ),
            );
          }
          final devices = snapshot.data ?? [];
          if (devices.isEmpty) {
            return const Center(child: Text('دستگاهی یافت نشد'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final device = devices[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: const Icon(Icons.medical_services_outlined),
                  ),
                  title: Text(
                    device.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('مدل: ${device.model}'),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => context.push('/device/${device.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
