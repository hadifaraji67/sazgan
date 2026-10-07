import 'content_file.dart';

class Device {
  final String id;
  final String name;
  final String model;
  final String description;
  final List<ContentFile> files;

  Device({
    required this.id,
    required this.name,
    required this.model,
    required this.description,
    required this.files,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] as String,
      name: json['name'] as String,
      model: json['model'] as String? ?? '',
      description: json['description'] as String? ?? '',
      files: (json['files'] as List<dynamic>? ?? [])
          .map((f) => ContentFile.fromJson(f as Map<String, dynamic>))
          .toList(),
    );
  }
}
