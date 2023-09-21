
import 'package:flutter/material.dart';
import 'package:gaze/core/extensions/context_extension.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      /*
       * Necessário para dizer ao flutter que caso seja um TabNavigator.pop() ele
       * não use o pop() padrão.
       * */
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
          /*
          * Primeiro testamos se é possível dar pop() em um contexto que seja de
          * um TabNavigator, caso contrário é uma navagação do flutter
          * */
          try {
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
        icon: Theme.of(context).platform == TargetPlatform.iOS
            ? const Icon(Icons.arrow_back_ios_new)
            : const Icon(Icons.arrow_back),
      ),
    );
  }
}