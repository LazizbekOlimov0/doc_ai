import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../gen/strings.g.dart';

class DoctorShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DoctorShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(index,
              initialLocation: index == navigationShell.currentIndex);
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: t.nav.patients,
          ),
          NavigationDestination(
            icon: const Icon(Icons.receipt_long_outlined),
            selectedIcon: const Icon(Icons.receipt_long),
            label: t.nav.reports,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: t.nav.profile,
          ),
        ],
      ),
    );
  }
}
