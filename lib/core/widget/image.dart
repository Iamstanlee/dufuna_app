import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class HostedImage extends StatelessWidget {
  const HostedImage(this.url,
      {Key? key, this.height, this.width, this.fit = BoxFit.cover})
      : super(key: key);
  final String url;
  final BoxFit fit;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    String secureUrl = url;
    if (secureUrl.contains("http://")) {
      secureUrl = secureUrl.replaceAll("http://", "https://");
    }
    return CachedNetworkImage(
      imageUrl: secureUrl,
      fit: fit,
      height: height,
      width: width,
      progressIndicatorBuilder: (_, s, i) =>
          CupertinoActivityIndicator.partiallyRevealed(
        radius: 13,
        progress: i.progress ?? 1,
      ),
      fadeInDuration: const Duration(milliseconds: 500),
    );
  }
}
