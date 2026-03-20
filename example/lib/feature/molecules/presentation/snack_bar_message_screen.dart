import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class SnackBarMessageScreen extends StatelessWidget {
  const SnackBarMessageScreen({super.key});

  void showSnack(BuildContext context, SnackBarType type) {
    AppSnackBar.show(
      context,
      type: type,
      message: 'Este es un mensaje de ejemplo del snackbar',
      actionLabel: 'UNDO',
      onAction: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Snackbar Component')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(tokens.spacing.medium),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(tokens.spacing.medium),
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceLow,
              borderRadius: BorderRadius.circular(tokens.radius.medium),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Variants',
                  style: Theme.of(context).textTheme.displaySmall,
                ),

                SizedBox(height: tokens.spacing.medium),

                Wrap(
                  spacing: tokens.spacing.small,
                  runSpacing: tokens.spacing.small,
                  children: [
                    AppButtons(
                      type: ButtonType.primaryFillButton,
                      title: Text(
                        'Success',
                        style: TextStyle(
                          fontFamily: tokens.typography.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => showSnack(context, SnackBarType.success),
                    ),

                    AppButtons(
                      type: ButtonType.primaryFillButton,
                      title: Text(
                        'Info',
                        style: TextStyle(
                          fontFamily: tokens.typography.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => showSnack(context, SnackBarType.info),
                    ),

                    AppButtons(
                      type: ButtonType.primaryFillButton,
                      title: Text(
                        'Warning',
                        style: TextStyle(
                          fontFamily: tokens.typography.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => showSnack(context, SnackBarType.warning),
                    ),

                    AppButtons(
                      type: ButtonType.primaryFillButton,
                      title: Text(
                        'Error',
                        style: TextStyle(
                          fontFamily: tokens.typography.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => showSnack(context, SnackBarType.error),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
