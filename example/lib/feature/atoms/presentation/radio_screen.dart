import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  String _plan = 'free';
  String _notification = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radio'), leading: const BackButton()),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'Single selection — Plan',
            children: [
              AppRadio<String>(
                value: 'free',
                groupValue: _plan,
                label: const Text('Free'),
                onChanged: (v) => setState(() => _plan = v!),
              ),
              AppRadio<String>(
                value: 'pro',
                groupValue: _plan,
                label: const Text('Pro'),
                onChanged: (v) => setState(() => _plan = v!),
              ),
              AppRadio<String>(
                value: 'enterprise',
                groupValue: _plan,
                label: const Text('Enterprise'),
                onChanged: (v) => setState(() => _plan = v!),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Single selection — Notifications',
            children: [
              AppRadio<String>(
                value: 'all',
                groupValue: _notification,
                label: const Text('All notifications'),
                onChanged: (v) => setState(() => _notification = v!),
              ),
              AppRadio<String>(
                value: 'mentions',
                groupValue: _notification,
                label: const Text('Mentions only'),
                onChanged: (v) => setState(() => _notification = v!),
              ),
              AppRadio<String>(
                value: 'none',
                groupValue: _notification,
                label: const Text('None'),
                onChanged: (v) => setState(() => _notification = v!),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Disabled',
            children: [
              AppRadio<String>(
                value: 'selected',
                groupValue: 'selected',
                label: const Text('Selected — disabled'),
                onChanged: null,
              ),
              AppRadio<String>(
                value: 'unselected',
                groupValue: 'selected',
                label: const Text('Unselected — disabled'),
                onChanged: null,
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
