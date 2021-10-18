import 'package:carousel_slider/carousel_options.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pico_sulteng_flutter/app/core/utils/helper.dart';
import 'package:pico_sulteng_flutter/app/data/models/infographic.dart';
import 'package:pico_sulteng_flutter/app/global_widgets/carousel_with_indicator.dart';
import 'package:pico_sulteng_flutter/app/global_widgets/image_placeholder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/detail_infographic_controller.dart';

class DetailInfographicView extends GetView<DetailInfographicController> {
  final Infographic infographic = Get.arguments['infographic'] as Infographic;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              expandedHeight: 400,
              flexibleSpace: CarouselWithIndicator(
                items: infographic.images
                    .map(
                      (image) => ExtendedImage.network(
                        image as String,
                        clearMemoryCacheWhenDispose: true,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        loadStateChanged: (ExtendedImageState state) {
                          switch (state.extendedImageLoadState) {
                            case LoadState.loading:
                              return const ImagePlaceholder(
                                label: 'Loading',
                                child: SizedBox(
                                  width: 50.0,
                                  child: SpinKitFadingCircle(
                                      color: Colors.blueAccent),
                                ),
                              );
                            case LoadState.failed:
                              return InkWell(
                                onTap: () {
                                  state.reLoadImage();
                                },
                                child: const ImagePlaceholder(
                                  label: 'Error',
                                  child: Icon(
                                    Icons.image_not_supported_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            case LoadState.completed:
                              break;
                          }
                        },
                      ),
                    )
                    .toList(),
                currentIndex: controller.activeCarousel.value,
                controller: controller.carouselController,
                options: CarouselOptions(
                  onPageChanged: controller.onPageChanged,
                  autoPlay: true,
                  height: 350,
                  viewportFraction: 1.0,
                ),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateWithDayFormat(
                        infographic.publishedAt,
                        format: 'EEEE, dd MMMM yyyy HH:mm',
                        includeTimeZone: true,
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: Text(
                        infographic.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 26.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text(
                          'LIHAT SUMBER',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          launch(infographic.link);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
