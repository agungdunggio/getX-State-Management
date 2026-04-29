import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_state_management/features/auth/presentation/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController(text: 'emilys');
  final _passwordController = TextEditingController(text: 'emilyspass');
  final _formKey = GlobalKey<FormState>();

  late final AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Username wajib diisi'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Password wajib diisi'
                    : null,
              ),
              const SizedBox(height: 16),
              Obx(() {
                final isLoading = _authController.isLoading.value;
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onLoginTap,
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Login'),
                  ),
                );
              }),
              const SizedBox(height: 8),
              Obx(() {
                final error = _authController.errorMessage.value;
                if (error == null) {
                  return const SizedBox.shrink();
                }
                return Text(error, style: const TextStyle(color: Colors.red));
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginTap() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _authController.login(
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }
}
