import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punto_venta/presentation/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameC  = TextEditingController();
  final _passC   = TextEditingController();
  bool  _loading = false;
  String? _error;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _usernameC,
                decoration: const InputDecoration(labelText: 'Nombre de usuario'),
                validator: (v) =>
                  v != null && v.isEmpty ? 'Nombre de usuario inválido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passC,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (v) =>
                  v != null && v.length >= 5 ? null : 'Mínimo 5 caracteres',
              ),
              const SizedBox(height: 24),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: _loading ? null : _submit,
                child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });

    final auth = context.read<AuthProvider>();
    final ok   = await auth.login(_usernameC.text, _passC.text);

    setState(() { _loading = false; });
    if (!ok) {
      setState(() { _error = 'Credenciales incorrectas'; });
    }
    // si OK, AuthProvider notifica y rebuild muestra HomeScreen
  }
}
