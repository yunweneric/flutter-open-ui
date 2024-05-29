import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:flutter_openui/ui/pages/task_details.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconoir_flutter/regular/edit.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../components/helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const Gap(20.0),
        Padding(
          padding: Constant.listviewPadding,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(color: Constant.foregroundColor, borderRadius: BorderRadius.circular(50.0), boxShadow: [
              BoxShadow(color: const Color(0xFF101828).withOpacity(0.06), offset: const Offset(0, 3), blurRadius: 10.0, spreadRadius: -2),
              BoxShadow(color: const Color(0xFF101828).withOpacity(0.04), offset: const Offset(0, 2), blurRadius: 4.0, spreadRadius: -2),
            ]),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              style: const TextStyle(fontWeight: FontWeight.w600, decoration: TextDecoration.none),
              decoration: InputDecoration(
                prefixIcon: Container(
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Constant.borderColor, width: 2.0), color: Constant.foregroundColor),
                  child: const Icon(LucideIcons.search),
                ),
                suffixIcon: searchController.text.isEmpty
                    ? const SizedBox()
                    : IconButton(
                        tooltip: 'Clear',
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                          });
                        },
                        icon: const Icon(LucideIcons.x),
                      ),
                hintText: 'Search task...',
                hintStyle: TextStyle(color: Constant.textColor, fontWeight: FontWeight.normal),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        const Gap(20.0),
        Padding(
          padding: Constant.listviewPadding,
          child: listHeading(context, heading: 'Categories'),
        ),
        const Gap(20.0),
        IntrinsicHeight(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Gap(16.0),
                CategoryCard(
                  foregroundColor: Constant.purple,
                  iconBgColor: Constant.deepPurple,
                  icon: Edit(
                    color: Constant.foregroundColor,
                  ),
                  title: 'Landing Page Designs',
                  subtitle: '18 Projects',
                  imageList: const [AssetImage(ImagePath.avatar), AssetImage(ImagePath.avatar1), AssetImage(ImagePath.avatar2), AssetImage(ImagePath.avatar3)],
                  progressValue: 0.7,
                  titleColor: Constant.foregroundColor,
                  subtitleColor: const Color(0xFFF2F4F7),
                  progressBgColor: Constant.surfacePurple,
                  progressValueColor: Constant.foregroundColor,
                ),
                const Gap(16.0),
                CategoryCard(
                  icon: Icon(
                    LucideIcons.video,
                    color: Constant.deepRed,
                  ),
                  title: 'Meeting on',
                  subtitle: '13 Projects',
                  imageList: const [AssetImage(ImagePath.avatar), AssetImage(ImagePath.avatar1), AssetImage(ImagePath.avatar2), AssetImage(ImagePath.avatar3)],
                  progressValue: 0.4,
                ),
                const Gap(16.0),
              ],
            ),
          ),
        ),
        const Gap(20.0),
        Padding(
          padding: Constant.listviewPadding,
          child: listHeading(context, heading: 'My Task'),
        ),
        const Gap(20.0),
        TabBar(
          // dividerHeight: 0,
          splashFactory: NoSplash.splashFactory,
          splashBorderRadius: BorderRadius.circular(10.0),
          tabs: const [
            Tab(child: Text('Today')),
            Tab(child: Text('Upcoming')),
            Tab(child: Text('Due Soon')),
            Tab(child: Text('Completed')),
          ],
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Constant.purple.withOpacity(0.1),
          ),
          isScrollable: false,
          unselectedLabelColor: Constant.textColor,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: ContextVariables.height(context) / 2.2,
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: tabController,
            children: List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemCount: tasks.length,
                  separatorBuilder: (context, index) => const Gap(10),
                  itemBuilder: (context, index) {
                    {
                      final TaskCard task = tasks[index];
                      return GestureDetector(
                        onTap: () => Get.to(
                            TaskDetails(
                              task: task,
                            ),
                            duration: const Duration(seconds: 1),
                            transition: Transition.cupertinoDialog),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(color: Constant.foregroundColor, borderRadius: BorderRadius.circular(16.0), boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF101828).withOpacity(0.06),
                              offset: const Offset(0, 3),
                              spreadRadius: -2,
                              blurRadius: 10.0,
                            ),
                            BoxShadow(
                              color: const Color(0xFF101828).withOpacity(0.04),
                              blurRadius: 4.0,
                              spreadRadius: -2,
                              offset: const Offset(0, 2),
                            )
                          ]),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                title: Text(task.title),
                                subtitle: Text(task.subtitle),
                              ),
                              const Gap(10.0),
                              Divider(color: Constant.borderColor),
                              const Gap(10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        LucideIcons.clock4,
                                        color: Constant.borderColor,
                                      ),
                                      const Gap(8.0),
                                      Text(task.dueDate)
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                    decoration: BoxDecoration(
                                      color: task.status == 'On Progress' ? Constant.surfaceGreen : Constant.surfacePurple,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Text(task.status, style: task.status == 'On Progress' ? TextStyle(fontWeight: FontWeight.w600, color: Constant.deepGreen) : const TextStyle()),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, required this.isCompleted});
}

class TaskCard {
  String title;
  String subtitle;
  String dueDate;
  String status;
  String description;
  List<ImageProvider> members;
  List<Task> tasks;

  TaskCard({
    required this.title,
    required this.subtitle,
    required this.dueDate,
    required this.status,
    required this.description,
    required this.members,
    required this.tasks,
  });
}

List<TaskCard> tasks = [
  TaskCard(
    title: 'NFT Web App Prototype',
    subtitle: 'Your team has used 80% of your available space. Need more?',
    dueDate: '08:30 AM, 22 May 2022',
    status: 'On Progress',
    description: 'Last year was a fantastic year for NFTs, with the market reaching a \$40 billion valuation for the first time. In addition, more than \$10 billion worth of NFTs are now sold every week – with NFT..',
    members: const [AssetImage(ImagePath.logo_jf), AssetImage(ImagePath.avatar1), AssetImage(ImagePath.avatar2), AssetImage(ImagePath.avatar3)],
    tasks: List.generate(
      5,
      (index) => Task(name: 'Lorem ipsum dolor sit amed ... whatever task', isCompleted: [false, true][Random().nextInt([false, true].length)]),
    ),
  ),
  TaskCard(
    title: 'This is another boring task I won\'t do',
    subtitle: 'Since I\'m testing this new app in town, let me break it down',
    dueDate: '08:30 AM, 22 May 2022',
    status: 'Completed',
    description: 'Last year was a fantastic year for NFTs, with the market reaching a \$40 billion valuation for the first time. In addition, more than \$10 billion worth of NFTs are now sold every week – with NFT..',
    members: const [AssetImage(ImagePath.avatar), AssetImage(ImagePath.avatar1), AssetImage(ImagePath.logo_jf), AssetImage(ImagePath.avatar3)],
    tasks: List.generate(
      5,
      (index) => Task(name: 'Lorem ipsum dolor sit amed ... whatever task', isCompleted: [false, true][Random().nextInt([false, true].length)]),
    ),
  ),
  TaskCard(
    title: 'Just an extra task, but who cares',
    subtitle: 'Since I\'m testing this new app in town, let me break it down',
    dueDate: '08:30 AM, 22 May 2022',
    status: 'Extra',
    description: 'Last year was a fantastic year for NFTs, with the market reaching a \$40 billion valuation for the first time. In addition, more than \$10 billion worth of NFTs are now sold every week – with NFT..',
    members: const [AssetImage(ImagePath.avatar), AssetImage(ImagePath.avatar1), AssetImage(ImagePath.avatar2), AssetImage(ImagePath.logo_jf)],
    tasks: List.generate(
      5,
      (index) => Task(name: 'Lorem ipsum dolor sit amed ... whatever task', isCompleted: [false, true][Random().nextInt([false, true].length)]),
    ),
  ),
];

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    this.foregroundColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.imageList,
    this.progressBgColor,
    this.progressValueColor,
    required this.progressValue,
    this.iconBgColor,
    this.titleColor,
    this.subtitleColor,
  });

  final Color? foregroundColor, progressBgColor, progressValueColor, iconBgColor, titleColor, subtitleColor;
  final Widget icon;
  final String title, subtitle;
  final List<ImageProvider> imageList;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ContextVariables.width(context) / 1.4,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      decoration: BoxDecoration(color: foregroundColor ?? Constant.foregroundColor, borderRadius: BorderRadius.circular(24.0), boxShadow: [
        BoxShadow(color: const Color(0xFF101828).withOpacity(0.08), offset: const Offset(0, 2), spreadRadius: -4.0, blurRadius: 16.0),
        BoxShadow(color: const Color(0xFF101828).withOpacity(0.03), offset: const Offset(0, 4), spreadRadius: -2.0, blurRadius: 6.0)
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: iconBgColor ?? Constant.surfaceRed,
            radius: 25,
            child: icon,
          ),
          const Gap(10),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              title,
              style: TextStyle(color: titleColor),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(color: subtitleColor),
            ),
          ),
          const Gap(10),
          FlutterImageStack.providers(
            providers: imageList,
            totalCount: 4,
            itemCount: 4,
            showTotalCount: false,
            // itemRadius: 30,
            itemBorderWidth: 1.5,
            itemBorderColor: Constant.borderColor,
          ),
          const Gap(10),
          LinearProgressIndicator(
            backgroundColor: progressBgColor ?? Constant.surfacePurple,
            borderRadius: BorderRadius.circular(5.0),
            minHeight: 4,
            valueColor: AlwaysStoppedAnimation<Color>(progressValueColor ?? Constant.purple),
            value: progressValue,
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: TextStyle(color: titleColor),
              ),
              Text(
                '${progressValue * 100}%',
                style: TextStyle(color: titleColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
