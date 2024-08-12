import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openui/screens/home_screen.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  final Subscription sub;
  const DetailScreen({super.key, required this.index, required this.sub});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (pop) {},
      canPop: false,
      child: Scaffold(
        body: Container(
          alignment: Alignment.bottomCenter,
          child: Hero(
            tag: widget.index,
            child: Container(
              height: AppSizing.height(context) * 0.95,
              width: AppSizing.width(context),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                // color: widget.sub.color.withOpacity(0.2),
                color: widget.sub.color,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Container(
                        height: 5,
                        width: AppSizing.width(context) * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: SvgPicture.asset(
                        "assets/images/logo_${widget.index}.svg",
                        color: Colors.white,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      widget.sub.name,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white),
                    ),
                    Text(
                      "\$${widget.sub.amount}",
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            listItem("Name", widget.sub.name),
                            listItem("Cycle", widget.sub.cycle),
                            listItem("Expiry Date", widget.sub.expireDate),
                            listItem("Type", widget.sub.type),
                            listItem("Remind", "${widget.index} before"),
                            listItem("Currency", "USD"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          child: Transform.scale(
                            scale: 0.8,
                            child: SvgPicture.asset(
                              "assets/icons/trash.svg",
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {},
                          label: Text(
                            "Save",
                            style: TextStyle(color: widget.sub.color),
                          ),
                          icon: Transform.scale(
                            scale: 0.7,
                            child: SvgPicture.asset(
                              "assets/icons/save.svg",
                              color: widget.sub.color,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  listItem(String title, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      leading: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
      ),
      trailing: Text(
        value,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
