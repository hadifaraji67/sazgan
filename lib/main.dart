import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'ui/pages/home_page.dart';
import 'ui/pages/device_detail_page.dart';
import 'ui/pages/pdf_viewer_page.dart';
import 'ui/pages/video_player_page.dart';

void main() {
  runApp(const SazganWikiApp());
}

class SazganWikiApp extends StatelessWidget {
  const SazganWikiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const HomePage(),
        ),
        GoRoute(
          path: '/device/:id',
          builder: (_, state) =>
              DeviceDetailPage(deviceId: state.pathParameters['id']!),
        ),
        GoRoute(
          path: '/pdf',
          builder: (_, state) =>
              PdfViewerPage(assetPath: state.extra as String),
        ),
        GoRoute(
          path: '/video',
          builder: (_, state) =>
              VideoPlayerPage(assetPath: state.extra as String),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'ویکی سازگان',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0066CC)),
        fontFamily: 'Vazirmatn',
      ),
      routerConfig: router,
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
    );
  }
}
