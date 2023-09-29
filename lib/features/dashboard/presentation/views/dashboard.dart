import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaze/core/providers/user_provider.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/features/auth/data/models/user_entity.dart';
import 'package:gaze/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:gaze/features/dashboard/presentation/utils/dashboard_utils.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserEntity>(
      stream: DashboardUtils.userDataStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          context.read<UserProvider>().user = snapshot.data;
        }
        return Consumer<DashboardController>(
          builder: (_, controller, __) {
            return Scaffold(
              body: IndexedStack(
                index: controller.currentIndex,
                children: controller.screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.currentIndex,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Colours.onDefaultColor,
                elevation: 8,
                onTap: controller.changeIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 0
                          ? IconlyBold.home
                          : IconlyLight.home,
                      color: controller.currentIndex == 0
                          ? Colours.secondaryColor
                          : Colours.secondaryColor,
                    ),
                    label: 'Home',
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 1
                          ? IconlyBold.search
                          : IconlyLight.search,
                      color: controller.currentIndex == 1
                          ? Colours.secondaryColor
                          : Colours.secondaryColor,
                    ),
                    label: 'Procurar',
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 2
                          ? IconlyBold.profile
                          : IconlyLight.profile,
                      color: controller.currentIndex == 2
                          ? Colours.secondaryColor
                          : Colours.secondaryColor,
                    ),
                    label: 'Perfil',
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
