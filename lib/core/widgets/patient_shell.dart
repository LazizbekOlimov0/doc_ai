import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../gen/strings.g.dart';

class PatientShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const PatientShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(top: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.15))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Tab(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: t.nav.home,
              isSelected: navigationShell.currentIndex == 0,
              onTap: () => navigationShell.goBranch(0, initialLocation: false),
            ),
            _Tab(
              icon: Icons.analytics_outlined,
              activeIcon: Icons.analytics,
              label: t.nav.analysis,
              isSelected: navigationShell.currentIndex == 1,
              onTap: () => navigationShell.goBranch(1, initialLocation: false),
            ),
            GestureDetector(
              onTap: () => context.push(RouteNames.patientAiChat),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: colorScheme.primary.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 26),
              ),
            ),
            _Tab(
              icon: Icons.chat_outlined,
              activeIcon: Icons.chat,
              label: t.nav.doctor,
              isSelected: navigationShell.currentIndex == 3,
              onTap: () => navigationShell.goBranch(3, initialLocation: false),
            ),
            _Tab(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: t.nav.profile,
              isSelected: navigationShell.currentIndex == 4,
              onTap: () => navigationShell.goBranch(4, initialLocation: false),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _Tab({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 6),
            Icon(isSelected ? activeIcon : icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
