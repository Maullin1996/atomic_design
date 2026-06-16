import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  bool _withLabel = false;
  bool _withoutLabel = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Switch'), leading: const BackButton()),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'Enabled',
            children: [
              _PreviewRow(
                label: 'With label',
                child: AppSwitch(
                  value: _withLabel,
                  label: const Text('Dark mode'),
                  onChanged: (v) => setState(() => _withLabel = v),
                ),
              ),
              _PreviewRow(
                label: 'Without label',
                child: AppSwitch(
                  value: _withoutLabel,
                  onChanged: (v) => setState(() => _withoutLabel = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Disabled',
            children: [
              _PreviewRow(
                label: 'With label — off',
                child: AppSwitch(
                  value: false,
                  label: const Text('Notifications'),
                  onChanged: null,
                ),
              ),
              _PreviewRow(
                label: 'With label — on',
                child: AppSwitch(
                  value: true,
                  label: const Text('Auto-sync'),
                  onChanged: null,
                ),
              ),
              _PreviewRow(
                label: 'Without label',
                child: const AppSwitch(value: false, onChanged: null),
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
