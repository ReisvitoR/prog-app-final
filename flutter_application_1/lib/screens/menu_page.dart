import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';
import 'contact_page.dart';
import 'settings_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  Future<void> _signOut(BuildContext context) async {
    final response = await Supabase.instance.client.auth.signOut();
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.error!.message)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => _signOut(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/ifpi_logo.png'), // Verifique o caminho aqui
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: <Widget>[
                  Container(
                    color: Colors.green,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ContactPage()),
                        );
                      },
                      child: const Text(
                        'Contato',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    child: TextButton(
                      onPressed: () {
                        // Adicione a lógica de navegação para Mapa aqui
                      },
                      child: const Text(
                        'Mapa',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsPage()),
                        );
                      },
                      child: const Text(
                        'Configurações',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}