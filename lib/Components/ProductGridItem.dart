import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/Color_Constants.dart';
import '../utils/spinkits.dart';

class ProductGridItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTap;

  const ProductGridItem({
    super.key,
    required this.imageUrl,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: title.isNotEmpty ? title : "Therapy item",
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque, // Ensure entire area is tappable
        onTap: () {
          debugPrint("GestureDetector onTap triggered for: $title");
          onTap?.call();
        },
        onTapDown: (_) => debugPrint("Tap down: $title"),
        onTapCancel: () => debugPrint("Tap cancelled: $title"),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: Center(child: spinkits.getSpinningLinespinkit()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    title.isNotEmpty ? title : "Unnamed Therapy",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: "general_sans",
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
