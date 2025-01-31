import 'package:flutter/material.dart';
import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _notifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SwitchListTile(
              title: const Text('Modo Escuro'),
              value: _darkMode,
              onChanged: (bool value) {
                setState(() {
                  _darkMode = value;
                });
                if (_darkMode) {
                  MyApp.of(context).setThemeMode(ThemeMode.dark);
                } else {
                  MyApp.of(context).setThemeMode(ThemeMode.light);
                }
              },
            ),
            SwitchListTile(
              title: const Text('Ativar Notificações'),
              value: _notifications,
              onChanged: (bool value) {
                setState(() {
                  _notifications = value;
                });
                // Adicione a lógica para ativar notificações aqui
              },
            ),
          ],
        ),
      ),
    );
  }
}