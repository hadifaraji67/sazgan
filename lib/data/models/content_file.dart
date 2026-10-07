class ContentFile {
  final String type;
  final String title;
  final String path;

  ContentFile({required this.type, required this.title, required this.path});

  factory ContentFile.fromJson(Map<String, dynamic> json) {
    return ContentFile(
      type: json['type'] as String,
      title: json['title'] as String,
      path: json['path'] as String,
    );
  }

  bool get isPdf => type == 'quick_guide' || type == 'manual' || type == 'pdf';
  bool get isVideo => type == 'video';
}
