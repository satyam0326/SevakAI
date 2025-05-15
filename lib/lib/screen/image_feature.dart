import 'dart:io';
import 'package:ai_chatbot/widget/custom_btn.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controller/image_controller.dart';
import '../../helper/global.dart';
import '../../widget/custom_loading.dart';

class ImageFeature extends StatelessWidget {
  ImageFeature({super.key});
  final _c = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagine with Sevak'),
        actions: [
          Obx(() {
            if (_c.status.value == Status.complete) {
              return IconButton(
                onPressed: () {
                  // Share functionality if needed
                },
                icon: const Icon(Icons.share),
              );
            }
            return const SizedBox();
          }),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: mq.height * .02,
          horizontal: mq.width * .04,
        ),
        children: [
          TextFormField(
            controller: _c.textC,
            textAlign: TextAlign.center,
            minLines: 2,
            maxLines: null,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            decoration: const InputDecoration(
              hintText:
                  'Imagine something wonderful & innovative\nType here & I will create for you 😃',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // AI Image view
          SizedBox(height: mq.height * .5, child: Obx(() => _buildImageView())),

          // Thumbnail list
          Obx(() {
            if (_c.imageList.isEmpty) return const SizedBox();
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(bottom: mq.height * .03),
              child: Row(
                children:
                    _c.imageList.map((img) {
                      return GestureDetector(
                        onTap: () => _c.url.value = img,
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: img,
                              height: 100,
                              errorWidget: (_, __, ___) => const SizedBox(),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            );
          }),

          CustomBtn(onTap: _c.searchAiImage, text: 'Create'),
        ],
      ),
    );
  }

  Widget _buildImageView() {
    final status = _c.status.value;
    if (status == Status.loading) return const CustomLoading();
    if (status == Status.none) {
      return Lottie.asset('assets/aigenerator.json', height: mq.height * .3);
    }

    final imageUrl = _c.url.value;
    if (imageUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (_, __) => const CustomLoading(),
        errorWidget: (_, __, ___) => const Icon(Icons.error),
      );
    } else {
      return Image.file(File(imageUrl), fit: BoxFit.cover);
    }
  }
}
