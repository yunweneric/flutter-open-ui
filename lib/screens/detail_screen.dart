import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';

class TextItem {
  final String title;
  final String description;

  TextItem({required this.title, required this.description});
}

class DetailScreen extends StatefulWidget {
  final int tag;
  const DetailScreen({super.key, required this.tag});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with TickerProviderStateMixin {
  List<TextItem> items = [
    TextItem(
      title: "Cape Town, South Africa",
      description: "Known for its stunning landscapes, Table Mountain, and vibrant cultural scene.",
    ),
    TextItem(
      title: "Marrakech, Morocco",
      description: "A city famous for its historic medinas, palaces, and the bustling Jemaa el-Fnaa square.",
    ),
    TextItem(
      title: "Cairo, Egypt",
      description: "Home to the iconic Pyramids of Giza, the Sphinx, and a rich ancient history.",
    ),
    TextItem(
      title: "Nairobi, Kenya",
      description: "Known for its national parks, wildlife reserves, and as a gateway to safari adventures.",
    ),
    TextItem(
      title: "Lagos, Nigeria",
      description: "A bustling metropolis known for its music, nightlife, and booming economic activity.",
    ),
    TextItem(
      title: "Accra, Ghana",
      description: "Famous for its coastal beauty, historical sites, and vibrant arts and culture scene.",
    ),
    TextItem(
      title: "Addis Ababa, Ethiopia",
      description: "Known for its diverse culture, historical landmarks, and as the political hub of Africa.",
    ),
    TextItem(
      title: "Dakar, Senegal",
      description: "A city known for its rich musical heritage, lively markets, and beautiful beaches.",
    ),
    TextItem(
      title: "Victoria Falls, Zimbabwe",
      description: "Home to one of the largest and most famous waterfalls in the world, offering stunning views and adventure activities.",
    ),
    TextItem(
      title: "Zanzibar, Tanzania",
      description: "An archipelago known for its pristine beaches, spice farms, and rich Swahili culture.",
    ),
    TextItem(
      title: "Kigali, Rwanda",
      description: "Noted for its cleanliness, safety, and as a starting point for gorilla trekking adventures.",
    ),
    TextItem(
      title: "Luanda, Angola",
      description: "A port city known for its colonial architecture, vibrant cultural scene, and dynamic economy.",
    ),
    TextItem(
      title: "Maputo, Mozambique",
      description: "Famous for its Portuguese colonial architecture, vibrant culture, and beautiful coastal areas.",
    ),
    TextItem(
      title: "Tunis, Tunisia",
      description: "Known for its ancient ruins, Mediterranean coastline, and the historic medina of Tunis.",
    ),
    TextItem(
      title: "Windhoek, Namibia",
      description: "The capital city, known for its German colonial heritage, modern architecture, and proximity to stunning landscapes.",
    ),
  ];

  late AnimationController controller;
  late Animation<double> fadeTextAnimation;
  late Animation<double> backBtnAnimation;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    fadeTextAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0,
          0.9,
          curve: Curves.elasticInOut,
        ),
      ),
    );

    backBtnAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.5,
          1,
          curve: Curves.elasticInOut,
        ),
      ),
    );

    Future.delayed(Duration(milliseconds: 100), () => controller.forward());

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.tag,
            child: Image.asset(
              "assets/images/image_${widget.tag}.jpg",
              height: AppSizing.height(context),
              width: AppSizing.width(context),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, value) {
                  return Transform.translate(
                    offset: Offset(0, fadeTextAnimation.value * 300),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30).add(EdgeInsets.only(bottom: 50)),
                      decoration: BoxDecoration(
                        color: AppColors.bgBlack.withOpacity(0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[widget.tag].title,
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: AppColors.textWhite,
                                ),
                          ),
                          Text(
                            items[widget.tag].description,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: AppColors.textWhite,
                                  fontSize: 15,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Positioned(
            top: kToolbarHeight,
            left: 20,
            child: GestureDetector(
              onTap: () async {
                await controller.reverse();
                Navigator.pop(context, true);
              },
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, value) {
                  return Opacity(
                    opacity: backBtnAnimation.value.clamp(0, 1),
                    child: CircleAvatar(
                      child: Icon(Icons.arrow_back),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
