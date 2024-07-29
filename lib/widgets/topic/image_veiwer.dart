import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/widgets/empty_widget.dart';

class ImageVeiwer extends StatelessWidget {
  final String? imageUrl;
  const ImageVeiwer(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null ? Image.network(imageUrl!) : const EmptyWidget();
  }
}
