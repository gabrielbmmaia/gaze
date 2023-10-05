import 'package:flutter/material.dart';
import 'package:gaze/core/res/colours.dart';

class ListError extends StatelessWidget {
  const ListError({
    required this.errorMessage,
    required this.onPressed,
    super.key,
  });

  final String errorMessage;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off,
              color: Colours.neutralTextColour,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Text(
                errorMessage,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colours.onDefaultColor),
              ),
              child: const Text(
                'Tentar novamente',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
