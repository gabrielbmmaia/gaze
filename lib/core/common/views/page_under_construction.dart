import 'package:flutter/material.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:lottie/lottie.dart';

/// Essa classe pode ser um placeholder para páginas que ainda estão em
/// construção ou quando houver erros de navegação o usuário será redirecionado
/// para essa página em vez do aplicativo quebrar.
/// A página contem:
/// [AppBar] para o usuário conseguir voltar para página anterior.
/// Em seu body tem um display de um [Lottie]
/// asset/lottie/page_under_construction.json
///
class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.onPrimaryColor,
        title: const Text(
          'Em construção',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colours.primaryColor,
      body:
      // SafeArea(
      //   child: Center(
      //     child: Lottie.asset('asset/lottie/page_under_construction.json'),
      //   ),
      // ),

      Center(child: Text('Gaze', style: TextStyle(fontFamily: Fonts.satisfy, fontSize: 80, color: Colours.secondaryColor),))
    );
  }
}
