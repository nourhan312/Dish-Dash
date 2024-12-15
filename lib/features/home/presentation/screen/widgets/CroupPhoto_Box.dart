import 'package:carousel_slider/carousel_slider.dart';
import 'package:dish_dash/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class GroupPhotoBox extends StatelessWidget {
  GroupPhotoBox({
    Key? key,
    required this.BoxTitle,
  }) : super(key: key);

  List<String> UrlImageGroup = [
    'assets/chef1.jpg',
    'assets/chef2.jpg',
    'assets/chef3.jpeg',
    'assets/chef4.jpg',
    'assets/chef5.jpg',
    'assets/chef6.jpg',
    'assets/chef7.jpg',
    'assets/chef8.jpg',
    'assets/chef9.webp',
  ];

  final String BoxTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                BoxTitle,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        CarouselSlider.builder(
            itemCount: UrlImageGroup.length,
            options: CarouselOptions(
              height: 400,
              autoPlay: true,
              reverse: true,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              autoPlayInterval: const Duration(seconds: 2),
            ),
            itemBuilder: (context, index, realindex) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 7,
                        color: Color.fromARGB(141, 0, 0, 0),
                      )
                    ],
                    color: AppColor.mainBrown,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage(
                            UrlImageGroup[index],
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
