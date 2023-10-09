import 'package:flutter/material.dart';

/// Esse [Widget] é utilizado para telas onde é necessario [SafeArea],[Center]
/// [backgroundColor] modifica a cor do plano de fundo do widget
class AppBackground extends StatelessWidget {
  const AppBackground({required this.child, super.key, this.backgroundColor});

  final Color? backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: backgroundColor,
      child: SafeArea(child: Center(child: child)),
    );
  }
}
