import 'package:flutter/material.dart';
import 'package:gaze/core/res/colours.dart';

/// [Widget] Padrão de botões com texto no aplicativo.
/// Nele podemos modificar:
/// [label]> Texto do botão
/// [onPressed]> Passar a funcionalidade de onPressed desejada
/// [buttonColour]> Cor do plano de fundo do botão
/// [textStyle]> Estilo do texto do botão
class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.buttonColour,
    this.labelColour,
    this.textStyle,
  });

  final String label;
  final VoidCallback onPressed;
  final Color? buttonColour;
  final Color? labelColour;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColour ?? Colours.onPrimaryColor,
        foregroundColor: labelColour ?? Colors.white,
        minimumSize: const Size(double.maxFinite, 50),
      ),
      child: Text(
        label,
        style: textStyle ??
            const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
