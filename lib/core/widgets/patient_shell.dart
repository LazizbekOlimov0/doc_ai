import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../gen/strings.g.dart';

class PatientShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const PatientShell({super.key, required this.navigationShell});

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
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: t.nav.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.analytics_outlined),
            selectedIcon: const Icon(Icons.analytics),
            label: t.nav.analysis,
          ),
          NavigationDestination(
            icon: const Icon(Icons.medication_outlined),
            selectedIcon: const Icon(Icons.medication),
            label: t.nav.medications,
          ),
          NavigationDestination(
            icon: const Icon(Icons.chat_outlined),
            selectedIcon: const Icon(Icons.chat),
            label: t.nav.doctor,
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
