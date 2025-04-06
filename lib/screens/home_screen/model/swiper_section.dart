import 'dart:async';

import 'package:deal_hub/theme/theme.dart';
import 'package:flutter/material.dart';
import '../../../data/data.dart';

class SwiperSection extends StatefulWidget {
  const SwiperSection({super.key});

  @override
  State<SwiperSection> createState() => _SwiperSectionState();
}

class _SwiperSectionState extends State<SwiperSection> {
  int activeIndex = 0;
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _startAutoPlay();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        final nextPage = activeIndex < sliderImages.length - 1 ? activeIndex + 1 : 0;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.18,
              child: PageView.builder(
                itemCount: sliderImages.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    activeIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildSwiperItem(sliderImages[index]);
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          right: 30,
          child: _buildIndicator(),
        ),
      ],
    );
  }

  Widget _buildSwiperItem(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        sliderImages.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: activeIndex == index ? 20 : 8,
          height: 9,
          decoration: BoxDecoration(
            color: activeIndex == index
                ? AppTheme.primaryColor
                : AppTheme.primaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}