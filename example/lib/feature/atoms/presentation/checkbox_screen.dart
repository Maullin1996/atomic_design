import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class CheckboxScreen extends StatefulWidget {
  const CheckboxScreen({super.key});

  @override
  State<CheckboxScreen> createState() => _CheckboxScreenState();
}

class _CheckboxScreenState extends State<CheckboxScreen> {
  bool _single = false;
  bool? _tristate = false;

  // "Select all" group
  bool _optionA = true;
  bool _optionB = false;
  bool _optionC = true;

  bool? get _selectAll {
    final checked = [_optionA, _optionB, _optionC].where((v) => v).length;
    if (checked == 0) return false;
    if (checked == 3) return true;
    return null; // indeterminate
  }

  void _toggleAll(bool? v) {
    final next = v ?? false;
    setState(() {
      _optionA = next;
      _optionB = next;
      _optionC = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox'),
        leading: const BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'Enabled',
            children: [
              _PreviewRow(
                label: 'With label',
                child: AppCheckbox(
                  value: _single,
                  label: const Text('I accept the terms and conditions'),
                  onChanged: (v) => setState(() => _single = v ?? false),
                ),
              ),
              _PreviewRow(
                label: 'Tristate',
                child: AppCheckbox(
                  value: _tristate,
                  tristate: true,
                  label: const Text('Indeterminate state'),
                  onChanged: (v) => setState(() => _tristate = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Select all pattern',
            children: [
              AppCheckbox(
                value: _selectAll,
                tristate: true,
                label: Text(
                  'Select all',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onChanged: _toggleAll,
              ),
              const Divider(height: 24),
              AppCheckbox(
                value: _optionA,
                label: const Text('Option A'),
                onChanged: (v) => setState(() => _optionA = v ?? false),
              ),
              AppCheckbox(
                value: _optionB,
                label: const Text('Option B'),
                onChanged: (v) => setState(() => _optionB = v ?? false),
              ),
              AppCheckbox(
                value: _optionC,
                label: const Text('Option C'),
                onChanged: (v) => setState(() => _optionC = v ?? false),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Disabled',
            children: [
              _PreviewRow(
                label: 'Unchecked',
                child: const AppCheckbox(
                  value: false,
                  label: Text('Unchecked disabled'),
                  onChanged: null,
                ),
              ),
              _PreviewRow(
                label: 'Checked',
                child: const AppCheckbox(
                  value: true,
                  label: Text('Checked disabled'),
                  onChanged: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

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
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  final String label;
  final Widget child;

  const _PreviewRow({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
