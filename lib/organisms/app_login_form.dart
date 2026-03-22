import 'package:flutter/material.dart';

import '../atoms/tokens.dart';

class AppLoginForm extends StatefulWidget {
  /// Recibe usuario y contraseña ya validados.
  /// La pantalla decide qué hacer con ellos (llamar al repositorio, navegar, etc.)
  final void Function(String user, String password)? onSignIn;
  final VoidCallback? onRegister;
  final VoidCallback? onGitHub;
  final VoidCallback? onGoogle;
  final VoidCallback? onFacebook;
  final bool isLoading;
  final String title;

  const AppLoginForm({
    super.key,
    this.onSignIn,
    this.onRegister,
    this.onGitHub,
    this.onGoogle,
    this.onFacebook,
    this.isLoading = false,
    this.title = 'Login Form',
  });

  @override
  State<AppLoginForm> createState() => _AppLoginFormState();
}

class _AppLoginFormState extends State<AppLoginForm> {
  bool _obscure = true;
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSignIn?.call(
        _userController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final tokens = AppTokens.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Título ────────────────────────────────────────
          Center(
            child: AppText.h4(
              widget.title,
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: tokens.spacing.smallMedium),

          // ── Usuario ───────────────────────────────────────
          AppInputText(
            label: 'User',
            textEditingController: _userController,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(AppIcons.user),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El campo no puede estar vacío';
              }
              if (value.length < 4) return 'Usuario inválido';
              return null;
            },
          ),
          SizedBox(height: tokens.spacing.smallMedium),

          // ── Contraseña ────────────────────────────────────
          AppInputText(
            label: 'Password',
            textEditingController: _passwordController,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            obscureText: _obscure,
            prefixIcon: Icon(AppIcons.obscurePassword),
            suffixIcon: AppButtons(
              type: ButtonType.primaryIconButton,
              icon: _obscure ? AppIcons.showPassword : AppIcons.obscurePassword,
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El campo no puede estar vacío';
              }
              if (value.length < 4) return 'Contraseña muy corta';
              return null;
            },
          ),
          SizedBox(height: tokens.spacing.large),

          // ── Sign In ───────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: AppButtons(
              type: ButtonType.primaryFillButton,
              isLoading: widget.isLoading,
              onPressed: _submit,
              title: AppText.h4('Sign In', color: colors.textInverse),
            ),
          ),
          SizedBox(height: tokens.spacing.large),

          // ── Divider social ────────────────────────────────
          Center(
            child: AppText.h6('or Sign In With', fontWeight: FontWeight.w400),
          ),
          SizedBox(height: tokens.spacing.smallMedium),

          // ── Botones sociales ──────────────────────────────
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.onGitHub != null)
                  AppButtons(
                    type: ButtonType.primaryImageButton,
                    onPressed: widget.onGitHub,
                    assetsIcon: 'assets/icons/github.svg',
                    color: colors.textPrimary,
                  ),
                if (widget.onGoogle != null) ...[
                  SizedBox(width: tokens.spacing.small),
                  AppButtons(
                    type: ButtonType.primaryImageButton,
                    onPressed: widget.onGoogle,
                    assetsIcon: 'assets/icons/facebook.svg',
                  ),
                ],
                if (widget.onFacebook != null) ...[
                  SizedBox(width: tokens.spacing.small),
                  AppButtons(
                    type: ButtonType.primaryImageButton,
                    onPressed: widget.onFacebook,
                    assetsIcon: 'assets/icons/google-circle.svg',
                    color: colors.textPrimary,
                  ),
                ],
              ],
            ),
          ),

          // ── Registro al fondo ─────────────────────────────
          // Align empuja el botón al fondo sin necesitar Spacer
          if (widget.onRegister != null)
            Padding(
              padding: EdgeInsets.only(top: tokens.spacing.smallMedium),
              child: AppButtons(
                type: ButtonType.primaryTextButton,
                title: AppText.h5('Registrarse', color: colors.primary),
                onPressed: widget.onRegister,
              ),
            ),
        ],
      ),
    );
  }
}
