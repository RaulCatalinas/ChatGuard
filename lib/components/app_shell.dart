import 'package:flutter/material.dart'
    show
        BottomNavigationBar,
        BottomNavigationBarItem,
        BottomNavigationBarType,
        BuildContext,
        Expanded,
        Icon,
        IconData,
        IconThemeData,
        Icons,
        MediaQuery,
        NavigationRail,
        NavigationRailDestination,
        NavigationRailLabelType,
        Row,
        SafeArea,
        Scaffold,
        StatelessWidget,
        Text,
        TextStyle,
        Theme,
        ValueChanged,
        VerticalDivider,
        Widget;
import 'package:go_router/go_router.dart' show GoRouter, GoRouterHelper;

const double _kDesktopBreakpoint = 840;

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  static const List<_NavDestination> _destinations = [
    _NavDestination(
      path: '/dashboard',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      label: 'Dashboard',
    ),
    _NavDestination(
      path: '/rules',
      icon: Icons.list_alt_outlined,
      selectedIcon: Icons.list_alt,
      label: 'Rules',
    ),
    _NavDestination(
      path: '/members',
      icon: Icons.group_outlined,
      selectedIcon: Icons.group,
      label: 'Members',
    ),
    _NavDestination(
      path: '/sanctions',
      icon: Icons.shield_outlined,
      selectedIcon: Icons.shield,
      label: 'Sanctions',
    ),
    _NavDestination(
      path: '/settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.toString();
    final index = _destinations.indexWhere((d) => location.startsWith(d.path));

    return index < 0 ? 0 : index;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    context.go(_destinations[index].path);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= _kDesktopBreakpoint;
    final currentIndex = _currentIndex(context);

    return isDesktop
        ? _DesktopShell(
            destinations: _destinations,
            currentIndex: currentIndex,
            onDestinationSelected: (index) =>
                _onDestinationSelected(context, index),
            child: child,
          )
        : _MobileShell(
            destinations: _destinations,
            currentIndex: currentIndex,
            onDestinationSelected: (index) =>
                _onDestinationSelected(context, index),
            child: child,
          );
  }
}

// ─── Desktop layout ───────────────────────────────────────────────────────────

class _DesktopShell extends StatelessWidget {
  const _DesktopShell({
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.child,
  });

  final List<_NavDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: currentIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            indicatorColor: colorScheme.primary.withValues(alpha: 0.15),
            selectedIconTheme: IconThemeData(color: colorScheme.primary),
            selectedLabelTextStyle: TextStyle(
              color: colorScheme.primary,
              fontWeight: .w600,
            ),
            destinations: destinations
                .map(
                  (d) => NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon),
                    label: Text(d.label),
                  ),
                )
                .toList(),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: colorScheme.outlineVariant,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// ─── Mobile layout ────────────────────────────────────────────────────────────

class _MobileShell extends StatelessWidget {
  const _MobileShell({
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.child,
  });

  final List<_NavDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onDestinationSelected,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.6),
        items: destinations
            .map(
              (d) => BottomNavigationBarItem(
                icon: Icon(d.icon),
                activeIcon: Icon(d.selectedIcon),
                label: d.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _NavDestination {
  const _NavDestination({
    required this.path,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final String path;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
