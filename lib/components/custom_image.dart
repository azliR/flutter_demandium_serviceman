import 'package:cached_network_image/cached_network_image.dart';
import '../core/core_export.dart';

class CustomImage extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const CustomImage({super.key, @required this.image, this.height, this.width, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image!, height: height, width: width, fit: BoxFit.cover,
      placeholder: (context, url) => Image.asset(Images.placeholder, height: height, width: width, fit: BoxFit.cover),
      errorWidget: (context, url, error) => Image.asset(Images.placeholder, height: height, width: width, fit: BoxFit.cover),
    );
  }
}
