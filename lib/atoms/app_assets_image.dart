import 'package:flutter/widgets.dart';

/// A local asset image widget with a constrained size and a fallback widget.
///
/// Wraps [Image.asset] with a [ConstrainedBox] (default 150 × 150 px) and
/// shows [errorWidget] when the asset cannot be decoded.
///
/// ```dart
/// AppAssetsImage(
///   path: 'assets/images/empty_icon.png',
///   widthImage: 120,
///   heightImage: 120,
///   errorWidget: Icon(AppIcons.brokenImage),
/// )
/// ```
///
/// Pass [cacheWidth] / [cacheHeight] to limit the decoded image size in memory
/// when the display size is smaller than the source.
///
/// See also:
/// - [AppNetworkImage], for images loaded from the network.
class AppAssetsImage extends StatelessWidget {
  /// Path to the asset (e.g. `'assets/images/logo.png'`). When `null` an
  /// empty string is used, which will trigger [errorWidget].
  final String? path;

  /// Maximum display width in logical pixels. Defaults to `150`.
  final double? widthImage;

  /// Maximum display height in logical pixels. Defaults to `150`.
  final double? heightImage;

  /// Target height for the in-memory cache.
  final int? cacheHeight;

  /// Target width for the in-memory cache.
  final int? cacheWidth;

  final BoxFit? fit;

  /// Widget shown when the asset fails to load.
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
