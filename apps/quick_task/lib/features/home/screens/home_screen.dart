import 'package:flutter/material.dart';
import 'package:quick_task/generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          QuickTaskL10n.current.home,
        ),
      ),
    );
  }
}
