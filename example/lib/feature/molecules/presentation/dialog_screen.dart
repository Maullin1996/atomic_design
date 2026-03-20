import 'package:atomic_design/atoms/tokens.dart';
import 'package:atomic_design/molecules/app_dialog.dart';
import 'package:flutter/material.dart';

class DialogScreen extends StatelessWidget {
  const DialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Dialogs'), leading: BackButton()),
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
                        'Simple',
                        style: TextStyle(
                          fontFamily: tokens.typography.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => AppDialog.show(
                        context,
                        title: 'Confirmar acción',
                        subtitle: '¿Estás seguro de continuar?',
                        confirmLabel: 'Sí, continuar',
                        cancelLabel: 'Cancelar',
                        onConfirm: () {},
                      ),
                    ),

                    AppButtons(
                      type: ButtonType.primaryFillButton,
                      title: Text(
                        'formulario',
                        style: TextStyle(
                          fontFamily: tokens.typography.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => AppDialog.show(
                        context,
                        title: 'Editar nombre',
                        content: AppInputText(label: 'Nombre'),
                        confirmLabel: 'Guardar',
                        cancelLabel: 'Cancelar',
                        onConfirm: () {},
                      ),
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
                      onPressed: () => AppDialog.show(
                        context,
                        title: '¿Eliminar Michi?',
                        subtitle: 'Esta acción no se puede deshacer.',
                        confirmLabel: 'Eliminar',
                        cancelLabel: 'Cancelar',
                        isDangerous: true,
                        onConfirm: () {},
                      ),
                    ),

                    AppButtons(
                      type: ButtonType.primaryFillButton,
                      title: Text(
                        'Cargando',
                        style: TextStyle(
                          fontFamily: tokens.typography.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => AppDialog.show(
                        context,
                        title: 'Guardando...',
                        confirmLabel: 'Guardar',
                        isLoading: true,
                      ),
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
