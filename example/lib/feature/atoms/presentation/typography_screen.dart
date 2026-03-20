import 'package:atomic_design/design_system.dart';
import 'package:atomic_design_example/feature/atoms/domain/typography_item.dart';
import 'package:flutter/material.dart';

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);

    final typographyItems = [
      TypographyItem(size: tokens.typography.h1, label: 'H1 · 36px'),
      TypographyItem(size: tokens.typography.h2, label: 'H2 · 32px'),
      TypographyItem(size: tokens.typography.h3, label: 'H3 · 28px'),
      TypographyItem(size: tokens.typography.h4, label: 'H4 · 22px'),
      TypographyItem(size: tokens.typography.h5, label: 'H5 · 16px'),
      TypographyItem(size: tokens.typography.h6, label: 'H5 · 12px'),
      TypographyItem(size: tokens.typography.body, label: 'Body · 18px'),
    ];
    final List<TypographyFamily> families = [
      TypographyFamily(
        title: 'Inter Family',
        fontFamily: tokens.typography.fontFamily,
        items: typographyItems,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Typography'), leading: BackButton()),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.of(context).surfaceLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.of(context).border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    families[0].title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: tokens.spacing.medium),
                  ...families[0].items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.label,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.of(context).textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'The quick brown fox jumps over the lazy dog',
                                style: TextStyle(
                                  fontFamily: families[0].fontFamily,
                                  fontSize: item.size,
                                  color: AppColors.of(context).textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
