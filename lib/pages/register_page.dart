import 'package:flutter/material.dart';

import '../user_session.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/text_field.dart';

// Локальный main() для автономного запуска экрана (ПКМ → Run 'register_page.dart').
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RegisterPage(),
  ));
}

/// Экран регистрации.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      UserSession.name = _nameController.text.trim();
      UserSession.email = _emailController.text.trim();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Регистрация прошла успешно. Войдите в аккаунт')),
      );
      // Возврат на экран входа с email нового пользователя.
      Navigator.pop(context, UserSession.email);
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
                const SizedBox(height: 48),
                const Text(
                  'Регистрация',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                CustomTextFormField(
                  inputType: InputFieldType.name,
                  hintText: 'ФИО',
                  prefixIcon: Icons.person_outline,
                  controller: _nameController,
                ),
                const SizedBox(height: 14),
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
                ),
                const SizedBox(height: 14),
                CustomTextFormField(
                  inputType: InputFieldType.confirmPassword,
                  hintText: 'Повторите пароль',
                  prefixIcon: Icons.security,
                  controller: _confirmController,
                  passwordController: _passwordController,
                  textInputAction: TextInputAction.done,
                  onDone: _submit,
                ),
                const SizedBox(height: 36),
                Center(
                  child: PrimaryButton(
                    text: 'Зарегистрироваться',
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAuthLink(
        question: 'Уже есть аккаунт?',
        action: 'Войдите',
        onTap: () => Navigator.maybePop(context), // возврат на экран входа
      ),
    );
  }
}
