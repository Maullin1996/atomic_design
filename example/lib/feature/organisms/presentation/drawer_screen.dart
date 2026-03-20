import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

// Página demostrativa
class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int _selectedIndex = 0;

  final _labels = ['Inicio', 'Explorar', 'Favoritos', 'Configuración'];
  final _icons = [Icons.home, Icons.explore, Icons.favorite, Icons.settings];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_labels[_selectedIndex]),
        actions: [BackButton()],
      ),
      drawer: AppDrawer(
        userName: 'Michencio López',
        userEmail: 'michi@bello.com',
        avatarUrl:
            'https://img.freepik.com/fotos-premium/gato-traje-negocios-profesional-felino_512668-16753.jpg',
        items: List.generate(
          _labels.length,
          (i) => DrawerItem(
            icon: _icons[i],
            label: _labels[i],
            isSelected: _selectedIndex == i,
            onTap: () => setState(() => _selectedIndex = i),
          ),
        ),
        onLogout: () {
          showDialog(
            context: context,
            builder: (_) => AppDialog(
              title: 'Cerrar sesión',
              subtitle: '¿Estás seguro de que quieres salir?',
              isDangerous: true,
              onConfirm: () => Navigator.of(context).pop(),
              onCancel: () => Navigator.of(context).pop(),
            ),
          );
        },
      ),
      body: Center(
        child: Text(
          _labels[_selectedIndex],
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
