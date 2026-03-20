import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class BottomSheetScreen extends StatelessWidget {
  const BottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Sheet'), leading: BackButton()),
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
                      onPressed: () => AppBottomSheet.show(
                        context,
                        title: 'Opciones',
                        content: Column(
                          children: [
                            ListTile(title: Text('Editar')),
                            ListTile(title: Text('Eliminar')),
                          ],
                        ),
                      ),
                    ),

                    AppButtons(
                      type: ButtonType.primaryFillButton,
                      title: Text(
                        'Con Botones',
                        style: TextStyle(
                          fontFamily: tokens.typography.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => AppBottomSheet.show(
                        context,
                        title: '¿Confirmar pedido?',
                        subtitle: 'Se realizará el cobro inmediatamente.',
                        confirmLabel: 'Confirmar',
                        cancelLabel: 'Cancelar',
                        onConfirm: () {},
                      ),
                    ),

                    AppButtons(
                      type: ButtonType.primaryFillButton,
                      title: Text(
                        'Destruir',
                        style: TextStyle(
                          fontFamily: tokens.typography.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => AppBottomSheet.show(
                        context,
                        title: '¿Eliminar cuenta?',
                        subtitle: 'Perderás todos tus datos.',
                        confirmLabel: 'Eliminar',
                        cancelLabel: 'Cancelar',
                        isDangerous: true,
                        onConfirm: () {},
                      ),
                    ),

                    AppButtons(
                      type: ButtonType.primaryFillButton,
                      title: Text(
                        'Input',
                        style: TextStyle(
                          fontFamily: tokens.typography.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => AppBottomSheet.show(
                        context,
                        title: 'Agregar comentario',
                        content: AppInputText(label: 'Comentario'),
                        confirmLabel: 'Enviar',
                        cancelLabel: 'Cancelar',
                        onConfirm: () {
                          /* enviar */
                        },
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
