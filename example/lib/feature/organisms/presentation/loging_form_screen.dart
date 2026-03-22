import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class LogingFormScreen extends StatefulWidget {
  const LogingFormScreen({super.key});

  @override
  State<LogingFormScreen> createState() => _LogingFormScreenState();
}

class _LogingFormScreenState extends State<LogingFormScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('Organismos'), leading: BackButton()),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(tokens.spacing.small),
              child: AppCard(
                padding: EdgeInsets.all(tokens.spacing.small),
                child: AppLoginForm(
                  onSignIn: (user, password) {},
                  onRegister: () {},
                  onGitHub: () {},
                  onGoogle: () {},
                  onFacebook: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
