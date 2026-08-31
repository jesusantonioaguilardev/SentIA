import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import 'router.dart';

class SentiaApp extends StatelessWidget {
  const SentiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Sentia',
        debugShowCheckedModeBanner: false,
        theme: SentiaTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
