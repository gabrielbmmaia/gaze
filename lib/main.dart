import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/material.dart';
import 'package:gaze/core/providers/user_provider.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:gaze/core/res/string.dart';
import 'package:gaze/core/services/generate_route.dart';
import 'package:gaze/core/services/injection_container.dart';
import 'package:gaze/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:gaze/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  fui.FirebaseUIAuth.configureProviders([fui.EmailAuthProvider()]);
  await init();
  await initializeDateFormatting('pt_BR');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringRes.appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colours.secondaryColor,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            elevation: 10,
            titleTextStyle: TextStyle(color: Colors.white, fontFamily: Fonts.poppins, fontSize: 24),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          fontFamily: Fonts.poppins,
        ),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
