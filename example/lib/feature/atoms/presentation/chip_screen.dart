import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class ChipScreen extends StatefulWidget {
  const ChipScreen({super.key});

  @override
  State<ChipScreen> createState() => _ChipScreenState();
}

class _ChipScreenState extends State<ChipScreen> {
  final _tags = ['Flutter', 'Dart', 'Firebase', 'Figma'];

  final _filters = {
    'In stock': false,
    'On sale': true,
    'New arrivals': false,
    'Favorites': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chips'), leading: const BackButton()),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'AppChip — Display',
            children: [
              _PreviewRow(
                label: 'Simple',
                child: Wrap(
                  spacing: 8,
                  children: const [
                    AppChip(label: 'Flutter'),
                    AppChip(label: 'Dart'),
                    AppChip(label: 'Firebase'),
                  ],
                ),
              ),
              _PreviewRow(
                label: 'With delete',
                child: Wrap(
                  spacing: 8,
                  children: _tags
                      .map(
                        (t) => AppChip(
                          label: t,
                          onDeleted: () =>
                              setState(() => _tags.remove(t)),
                        ),
                      )
                      .toList(),
                ),
              ),
              _PreviewRow(
                label: 'With avatar',
                child: Wrap(
                  spacing: 8,
                  children: const [
                    AppChip(
                      label: 'Jane',
                      avatar: CircleAvatar(
                        radius: 12,
                        child: Text('J', style: TextStyle(fontSize: 10)),
                      ),
                    ),
                    AppChip(
                      label: 'Carlos',
                      avatar: CircleAvatar(
                        radius: 12,
                        child: Text('C', style: TextStyle(fontSize: 10)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'AppFilterChip — Selectable',
            children: [
              _PreviewRow(
                label: 'Toggle filters',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _filters.entries
                      .map(
                        (e) => AppFilterChip(
                          label: e.key,
                          selected: e.value,
                          onSelected: (v) =>
                              setState(() => _filters[e.key] = v),
                        ),
                      )
                      .toList(),
                ),
              ),
              _PreviewRow(
                label: 'With avatar',
                child: Wrap(
                  spacing: 8,
                  children: [
                    AppFilterChip(
                      label: 'Favorites',
                      selected: true,
                      avatar: const Icon(Icons.favorite_border, size: 16),
                      onSelected: (_) {},
                    ),
                    AppFilterChip(
                      label: 'Bookmarks',
                      selected: false,
                      avatar: const Icon(Icons.bookmark_border, size: 16),
                      onSelected: (_) {},
                    ),
                  ],
                ),
              ),
              _PreviewRow(
                label: 'Disabled',
                child: const Wrap(
                  spacing: 8,
                  children: [
                    AppFilterChip(
                      label: 'Selected',
                      selected: true,
                      onSelected: null,
                    ),
                    AppFilterChip(
                      label: 'Unselected',
                      selected: false,
                      onSelected: null,
                    ),
                  ],
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
