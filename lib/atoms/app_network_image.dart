import 'package:atomic_design/design_system.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A network image widget with built-in caching and a shimmer loading state.
///
/// Uses [CachedNetworkImage] under the hood. While the image loads a shimmer
/// skeleton is shown; on error [errorWidget] is displayed instead.
///
/// The image is constrained to [widthImage] × [heightImage] (default 150 × 150
/// logical pixels).
///
/// ```dart
/// AppNetworkImage(
///   url: user.avatarUrl,
///   widthImage: 48,
///   heightImage: 48,
///   errorWidget: Icon(AppIcons.user),
/// )
/// ```
///
/// Pass [memCacheWidth] / [memCacheHeight] to down-scale the decoded image in
/// memory when the display size is smaller than the source.
///
/// See also:
/// - [AppAssetsImage], for images loaded from the app bundle.
class AppNetworkImage extends StatelessWidget {
  final String url;

  /// Maximum display width in logical pixels. Defaults to `150`.
  final double? widthImage;

  /// Maximum display height in logical pixels. Defaults to `150`.
  final double? heightImage;

  /// Target height for the in-memory cache. Reduces memory usage for large
  /// source images displayed at a small size.
  final int? memCacheHeight;

  /// Target width for the in-memory cache.
  final int? memCacheWidth;

  /// Widget shown when the network request fails.
  final Widget errorWidget;

  final BoxFit? fit;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.widthImage,
    this.heightImage,
    this.memCacheHeight,
    this.memCacheWidth,
    required this.errorWidget,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: heightImage ?? 150,
        maxWidth: widthImage ?? 150,
      ),
      child: CachedNetworkImage(
        imageUrl: url,
        memCacheHeight: memCacheHeight,
        memCacheWidth: memCacheWidth,
        errorWidget: (_, _, _) => errorWidget,
        fit: fit,
        progressIndicatorBuilder: (context, url, progress) =>
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: widthImage,
                height: heightImage,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppTokens.of(context).radius.small,
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
