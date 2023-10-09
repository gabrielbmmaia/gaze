import 'package:flutter/material.dart';
import 'package:gaze/core/extensions/context_extension.dart';

/// [Widget] que substitui o back button quando a tela é uma NestedView.
/// Em seu [onPressed] primeiramente será enviado uma tentativa de context.pop()
/// de uma NestedView e caso não seja será executado um pop() comum.
class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Necessário para dizer ao flutter que caso seja um TabNavigator.pop()
      // ele não use o pop() padrão.
      onWillPop: () async {
        try {
          context.pop();
          return false;
        } catch (_) {
          return true;
        }
      },
      child: IconButton(
        onPressed: () {
          // Primeiro testamos se é possível dar pop() em um contexto que seja
          // de um [TabNavigator], caso contrário é uma navagação do flutter
          try {
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
        icon: Theme.of(context).platform == TargetPlatform.iOS
            ? const Icon(Icons.arrow_back_ios_new, color: Colors.white)
            : const Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }
}
