import 'package:atomic_design/design_system.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? widthImage;
  final double? heightImage;
  final int? memCacheHeight;
  final int? memCacheWidth;
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
