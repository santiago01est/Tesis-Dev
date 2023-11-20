import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imagePaths;

  const ImageCarousel({Key? key, required this.imagePaths}) : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: _carouselController,
      itemCount: widget.imagePaths.length,
      options: CarouselOptions(
        // si la pantalla es de movil la altura se reduce
        height: MediaQuery.of(context).size.height * 0.3,
        aspectRatio: 16 / 9,
        viewportFraction: 0.3,
        initialPage: _currentIndex,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final imagePath = widget.imagePaths[index];
        final isCenter = index == _currentIndex;

        // Ajusta el tamaño y opacidad según la posición en el carrusel
        final scaleFactor = isCenter ? 1.0 : 0.8;
        final opacity = isCenter ? 1.0 : 0.5;

        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scaleFactor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
