import 'package:flutter/widgets.dart';

class AppAssetsImage extends StatelessWidget {
  final String? path;
  final double? widthImage;
  final double? heightImage;
  final int? cacheHeight;
  final int? cacheWidth;
  final BoxFit? fit;
  final Widget errorWidget;
  final Animation<double>? opacity;

  const AppAssetsImage({
    super.key,
    this.path,
    this.widthImage,
    this.heightImage,
    this.cacheHeight,
    this.cacheWidth,
    this.fit,
    required this.errorWidget,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: heightImage ?? 150,
        maxWidth: widthImage ?? 150,
      ),
      child: Image.asset(
        path ?? '',
        cacheHeight: cacheHeight,
        cacheWidth: cacheWidth,
        fit: fit,
        errorBuilder: (_, _, _) => errorWidget,
        opacity: opacity,
      ),
    );
  }
}
