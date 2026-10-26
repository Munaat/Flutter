import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';
import '../widgets/text_field.dart';
import 'home_page.dart';
import 'register_page.dart';

// Локальный main() для автономного запуска экрана (ПКМ → Run 'login_page.dart').
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}

/// Экран авторизации.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Вход выполнен успешно')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => GpuInfoPage(email: _emailController.text.trim()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                const Text(
                  'Добро пожаловать!\nВойдите в свой аккаунт\nИли создайте новый',
                  style: TextStyle(fontSize: 20, height: 1.3),
                ),
                const SizedBox(height: 48),
                CustomTextFormField(
                  inputType: InputFieldType.email,
                  hintText: 'Email',
                  prefixIcon: Icons.mail_outline,
                  controller: _emailController,
                ),
                const SizedBox(height: 14),
                CustomTextFormField(
                  inputType: InputFieldType.password,
                  hintText: 'Пароль',
                  prefixIcon: Icons.security,
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  onDone: _submit,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Восстановление пароля пока недоступно'),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    child: const Text(
                      'Забыли пароль?',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Center(child: PrimaryButton(text: 'Войти', onPressed: _submit)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAuthLink(
        question: 'Нет аккаунта?',
        action: 'Зарегистрируйтесь',
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const RegisterPage()),
        ),
      ),
    );
  }
}
