import 'package:flutter/material.dart';

import '../../characters/presentation/presentation.dart';
import 'rm_app_theme.dart';

final class RmPortalRemotoApp extends StatelessWidget {
  const RmPortalRemotoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fase 2 | Portal Remoto',
      theme: RmAppTheme.light,
      home: const RmCharacterListPage(),
    );
  }
}
