import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class InputTextScreen extends StatelessWidget {
  const InputTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('Input Text'), leading: BackButton()),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [_InputSection()],
        ),
      ),
    );
  }
}

class _InputSection extends StatelessWidget {
  const _InputSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.of(context).border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Text Input', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          const AppInputText(
            label: 'Default',
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          const SizedBox(height: 16),
          const AppInputText(
            label: 'Disabled',
            onChange: null,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          const SizedBox(height: 16),
          AppInputText(
            label: 'Password',
            obscureText: true,
            suffixIcon: Icon(AppIcons.obscurePassword),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ],
      ),
    );
  }
}
