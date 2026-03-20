import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

// Página demostrativa
class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  final _items = const [
    BottomNavItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Inicio',
    ),
    BottomNavItem(
      icon: Icons.explore_outlined,
      selectedIcon: Icons.explore,
      label: 'Explorar',
    ),
    BottomNavItem(
      icon: Icons.favorite_outline,
      selectedIcon: Icons.favorite,
      label: 'Favoritos',
    ),
    BottomNavItem(
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      label: 'Perfil',
    ),
  ];

  final _screens = const [
    Center(child: Text('Inicio')),
    Center(child: Text('Explorar')),
    Center(child: Text('Favoritos')),
    Center(child: Text('Perfil')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_items[_selectedIndex].label),
        leading: BackButton(),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: KeyedSubtree(
          key: ValueKey(_selectedIndex),
          child: _screens[_selectedIndex],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        items: _items,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
