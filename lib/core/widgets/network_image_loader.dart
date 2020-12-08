import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:github/core/widgets/shimmer_effect.dart';
import 'package:github/res/images.dart';
import 'package:github/res/styles.dart';

class NetworkImageLoader extends StatelessWidget {

  final String image;
  final String errorImage;
  final double height;
  final double width;
  final BoxFit fit;
  bool isShimmer = true;

  NetworkImageLoader({
    this.image,
    this.height,
    this.width,
    this.fit,
    this.errorImage,
    this.isShimmer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: fit,
        height: height,
        width: width,
        placeholder: (context, url) => Center(
          child: Container(
              width: width,
              height: height,
              color: AppColor.cardBackground,
              alignment: Alignment.center,
              child: isShimmer ? ShimmerEffect(
                width: height,
                height: width,
              ) : new Image.asset(errorImage == null ? Images.app_logo : errorImage, width: 100.0, height: 100.0,)),
        ),
        errorWidget: (context, url, error) => Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColor.cardBackground,
            alignment: Alignment.center,
            child: new Image.asset(errorImage == null ? Images.app_logo : errorImage, width: 100.0, height: 100.0,)),
        alignment: Alignment.center,
      ),
    );
  }

}