import 'package:flutter/material.dart';

/// Тип поля ввода: от него зависят валидация, клавиатура и скрытие текста.
enum InputFieldType { name, email, password, confirmPassword }

/// Кастомный TextFormField с валидацией, иконкой слева
/// и кнопкой показа/скрытия пароля справа.
class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;

  /// Контроллер поля «Пароль» — нужен полю «Повторите пароль» для сравнения.
  final TextEditingController? passwordController;

  /// Кнопка клавиатуры: next — переход к следующему полю, done — отправка.
  final TextInputAction textInputAction;

  /// Вызывается при нажатии done на последнем поле (например, отправка формы).
  final VoidCallback? onDone;

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.passwordController,
    this.textInputAction = TextInputAction.next,
    this.onDone,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _hidePassword = true;

  // Полное имя: только буквы (латиница и кириллица) и пробелы.
  static final RegExp _nameReg = RegExp(r'^[A-Za-zА-Яа-яЁё\s]+$');

  // Email: текст до @, текст после @, в домене есть точка.
  static final RegExp _emailReg =
      RegExp(r'^[\w.+-]+@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}$');

  // Пароль: не менее 6 символов, есть буква, цифра и символ из + _ -.
  static final RegExp _passwordReg =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[+_\-])[A-Za-z\d+_\-]{6,}$');

  bool get _isPassword =>
      widget.inputType == InputFieldType.password ||
      widget.inputType == InputFieldType.confirmPassword;

  String? _validator(String? value) {
    // Поле не может быть пустым и неопределённым.
    if (value == null || value.trim().isEmpty) {
      return 'Поле не может быть пустым';
    }

    switch (widget.inputType) {
      case InputFieldType.name:
        if (!_nameReg.hasMatch(value.trim())) {
          return 'Имя должно содержать только буквы и пробелы';
        }
        return null;

      case InputFieldType.email:
        if (!_emailReg.hasMatch(value.trim())) {
          return 'Введите корректный email (например, example@mail.ru)';
        }
        return null;

      case InputFieldType.password:
        if (value.length < 6) {
          return 'Пароль должен быть не менее 6 символов';
        }
        if (!_passwordReg.hasMatch(value)) {
          return 'Пароль должен содержать латинские буквы, цифры\n'
              'и хотя бы один символ: + _ -';
        }
        return null;

      case InputFieldType.confirmPassword:
        if (widget.passwordController != null &&
            value != widget.passwordController!.text) {
          return 'Пароли не совпадают';
        }
        return null;
    }
  }

  // Переход фокуса к следующему доступному полю или завершение ввода.
  // Задан через onEditingComplete: он заменяет встроенную обработку кнопки
  // клавиатуры, поэтому фокус переходит ровно на одно поле.
  void _onEditingComplete() {
    if (widget.textInputAction == TextInputAction.next) {
      FocusScope.of(context).nextFocus();
    } else {
      FocusScope.of(context).unfocus();
      widget.onDone?.call();
    }
  }

  OutlineInputBorder _border(Color color, [double width = 1.5]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isPassword && _hidePassword,
      obscuringCharacter: '•',
      keyboardType: widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : _isPassword
              ? TextInputType.visiblePassword
              : TextInputType.name,
      textInputAction: widget.textInputAction,
      onEditingComplete: _onEditingComplete,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(color: Colors.black, fontSize: 15),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        errorMaxLines: 3,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        prefixIcon: Icon(widget.prefixIcon, color: Colors.black),
        // ExcludeFocus — чтобы nextFocus() не переводил фокус на кнопку «глаз».
        suffixIcon: _isPassword
            ? ExcludeFocus(
                child: IconButton(
                  icon: Icon(
                    _hidePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey.shade700,
                  ),
                  onPressed: () =>
                      setState(() => _hidePassword = !_hidePassword),
                ),
              )
            : null,
        border: _border(Colors.black),
        enabledBorder: _border(Colors.black),
        focusedBorder: _border(Colors.black, 2.5),
        errorBorder: _border(Colors.red),
        focusedErrorBorder: _border(Colors.red, 2.5),
      ),
      validator: _validator,
    );
  }
}
