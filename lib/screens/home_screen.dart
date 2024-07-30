import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

class Tag {
  final String icon;
  final String text;

  Tag({required this.icon, required this.text});
}

class HomeItem {
  final Color color;
  final int index;
  final String name;
  final String price;

  HomeItem({
    required this.color,
    required this.index,
    required this.price,
    required this.name,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController(viewportFraction: 1);
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Tag> tags = [
      Tag(icon: "assets/icons/dashboard.svg", text: "All"),
      Tag(icon: "assets/icons/shoe.svg", text: "Footwear"),
      Tag(icon: "assets/icons/watch.svg", text: "Watches"),
      Tag(icon: "assets/icons/tshirt.svg", text: "Shirts"),
      Tag(icon: "assets/icons/wallet.svg", text: "Wallets"),
    ];
    List<HomeItem> items = [
      HomeItem(color: Color(0xffE7EFC4), index: 0, name: "Nike Shoes", price: "\$12"),
      HomeItem(color: Color(0xffF5DADA), index: 1, name: "Chair", price: "\$10"),
      HomeItem(color: Color(0xffC5E7EF), index: 2, name: "Watch", price: "\$25"),
      HomeItem(color: Color(0xffF1D7F4), index: 3, name: "S24 Plus", price: "\$1200"),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Center(
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).primaryColorLight,
            child: SvgPicture.asset(
              width: 30,
              "assets/icons/dashboard.svg",
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        title: Text("Home"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  child: SvgPicture.asset(
                    width: 30,
                    "assets/icons/bag.svg",
                    color: Theme.of(context).highlightColor,
                  ),
                ),
                SizedBox(width: 5),
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  child: Image.asset(
                    "assets/images/user.png",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).primaryColorLight,
                        filled: true,
                        hintText: "Search ...",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        suffixIcon: Transform.scale(
                          scale: 0.8,
                          child: SvgPicture.asset(
                            "assets/icons/search.svg",
                            width: 10,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Transform.scale(
                    scale: 0.8,
                    child: Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      label: SvgPicture.asset(
                        "assets/icons/setting.svg",
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  )
                ],
              ),
            ),
            AppSizing.k10Spacer(context),
            Container(
              height: 200,
              child: PageView.builder(
                clipBehavior: Clip.hardEdge,
                itemCount: 3,
                controller: controller,
                itemBuilder: (c, i) {
                  return Container(
                    // height: 200,
                    // alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.blue],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            width: 120,
                            height: 120,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Get the special discount",
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Theme.of(context).primaryColorLight,
                                      ),
                                ),
                                Text(
                                  "50% \nOFF",
                                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColorLight,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Image.asset("assets/images/carousel_image.png"),
                      ],
                    ),
                  );
                },
              ),
            ),
            AppSizing.k10Spacer(context),
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: tags.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, i) {
                  return GestureDetector(
                    onTap: () {
                      setState(() => activeIndex = i);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Chip(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        backgroundColor: Theme.of(context).primaryColorLight,
                        side: BorderSide.none,
                        label: Row(
                          children: [
                            SvgPicture.asset(
                              tags[i].icon,
                              width: 20,
                              color: activeIndex == i ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark,
                            ),
                            SizedBox(width: 5),
                            Text(
                              tags[i].text,
                              style: TextStyle(
                                color: activeIndex == i ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    "View All",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            AppSizing.k10Spacer(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: items.map((item) {
                  return StaggeredGridTile.count(
                    crossAxisCellCount: item.index % 2 == 0 ? 2 : 2,
                    mainAxisCellCount: item.index % 2 == 0 ? 2.5 : 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: item.color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/images/home_image_${item.index}.png",
                              height: item.index % 2 == 0 ? 150 : 100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  item.price,
                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
