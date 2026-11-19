import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const _verdeOscuro = Color(0xFF2D5A3D);
  static const _verdeClaro = Color(0xFFC8E6C9);
  static const _crema = Color(0xFFF7F3E6);

  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _verPass = false;
  bool _cargando = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _correoCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _registrar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _cargando = true);

    final res = await AuthService.registrar(
      nombreUsuario: _nombreCtrl.text.trim(),
      correo: _correoCtrl.text.trim(),
      password: _passCtrl.text,
    );

    if (!mounted) return;
    setState(() => _cargando = false);

    final exito = res['exito'] == true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(exito ? res['mensaje'] : res['error'])),
    );

    if (exito) Navigator.pop(context); // regresa al login
  }

  InputDecoration _decoracion(String etiqueta, {Widget? sufijo}) {
    final borde = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: _verdeClaro),
    );
    return InputDecoration(
      labelText: etiqueta,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: sufijo,
      enabledBorder: borde,
      border: borde,
      focusedBorder: borde.copyWith(
        borderSide: const BorderSide(color: _verdeOscuro, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _crema,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: _verdeOscuro,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Crea tu cuenta',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: _verdeOscuro),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Regístrate para empezar a aprender náhuatl',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nombreCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: _decoracion('Nombre de usuario'),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Escribe tu nombre de usuario'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _correoCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: _decoracion('Correo electrónico'),
                  validator: (v) {
                    final t = v?.trim() ?? '';
                    if (t.isEmpty) return 'Escribe tu correo';
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(t)) {
                      return 'Escribe un correo válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passCtrl,
                  obscureText: !_verPass,
                  textInputAction: TextInputAction.next,
                  decoration: _decoracion(
                    'Contraseña',
                    sufijo: TextButton(
                      onPressed: () => setState(() => _verPass = !_verPass),
                      child: Text(_verPass ? 'Ocultar' : 'Ver'),
                    ),
                  ),
                  validator: (v) => (v == null || v.length < 3)
                      ? 'La contraseña debe tener al menos 3 caracteres'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmCtrl,
                  obscureText: !_verPass,
                  decoration: _decoracion('Confirmar contraseña'),
                  validator: (v) =>
                      v != _passCtrl.text ? 'Las contraseñas no coinciden' : null,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _cargando ? null : _registrar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _verdeOscuro,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _cargando
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Crear cuenta',
                            style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('¿Ya tienes cuenta? Inicia sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}