import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  Future<void> _addContact() async {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;
    final latitude = _latitudeController.text;
    final longitude = _longitudeController.text;

    final response = await Supabase.instance.client
        .from('contacts')
        .insert({
          'name': name,
          'phone': phone,
          'email': email,
          'latitude': latitude,
          'longitude': longitude,
        })
        .execute();

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.error!.message)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contato adicionado com sucesso!')),
      );
      _fetchContacts();
    }
  }

  Future<void> _updateContact(int id) async {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;
    final latitude = _latitudeController.text;
    final longitude = _longitudeController.text;

    final response = await Supabase.instance.client
        .from('contacts')
        .update({
          'name': name,
          'phone': phone,
          'email': email,
          'latitude': latitude,
          'longitude': longitude,
        })
        .eq('id', id)
        .execute();

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.error!.message)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contato atualizado com sucesso!')),
      );
      _fetchContacts();
    }
  }

  Future<void> _deleteContact(int id) async {
    final response = await Supabase.instance.client
        .from('contacts')
        .delete()
        .eq('id', id)
        .execute();

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.error!.message)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contato excluído com sucesso!')),
      );
      _fetchContacts();
    }
  }

  Future<void> _fetchContacts() async {
    final response = await Supabase.instance.client
        .from('contacts')
        .select()
        .execute();

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.error!.message)),
      );
    } else {
      setState(() {
        _contacts = response.data as List<dynamic>;
      });
    }
  }

  List<dynamic> _contacts = [];

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Telefone',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o telefone';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Por favor, insira um email válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _latitudeController,
                    decoration: const InputDecoration(
                      labelText: 'Latitude',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a latitude';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _longitudeController,
                    decoration: const InputDecoration(
                      labelText: 'Longitude',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a longitude';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addContact();
                      }
                    },
                    child: const Text('Adicionar Contato'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return ListTile(
                    title: Text(contact['name']),
                    subtitle: Text(contact['phone']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _nameController.text = contact['name'];
                            _phoneController.text = contact['phone'];
                            _emailController.text = contact['email'];
                            _latitudeController.text = contact['latitude'];
                            _longitudeController.text = contact['longitude'];
                            _updateContact(contact['id']);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteContact(contact['id']);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }
}