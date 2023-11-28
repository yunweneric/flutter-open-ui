import 'package:flutter/material.dart';
import 'package:flutter_openui/controllers/home_controller.dart';
import 'package:flutter_openui/ui/components/helper.dart';
import 'package:flutter_openui/ui/pages/calendar_screen.dart';
import 'package:get/get.dart';
import 'package:iconoir_flutter/regular/app_notification.dart';
import 'package:iconoir_flutter/regular/settings.dart';
import 'package:iconoir_flutter/regular/view_grid.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:table_calendar/table_calendar.dart';

import 'home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

    final List<Widget> tabPages = [
      const HomeScreen(),
      const Center(
          child: Icon(
            LucideIcons.pieChart,
            size: 50.0,
          )),
      Obx(() {
        return CalendarScreen(focusedDate: DateTime
            .now()
            .month == controller.dropDownValue.value + 1
            ? DateTime.now()
            : DateTime(DateTime
            .now()
            .year, controller.dropDownValue.value + 1, 1));
      }),
      const Center(
          child: Settings(
            width: 50,
            height: 50,
          )),
    ];

    final List<BottomNavigationBarItem> bottomNavBarItems = [
      BottomNavigationBarItem(
        icon: ViewGrid(color: Constant.unselectedColor),
        activeIcon: ViewGrid(color: Constant.dark),
        label: 'Home',
        tooltip: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          LucideIcons.pieChart,
        ),
        label: 'Stats',
        tooltip: 'Statistics',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          LucideIcons.calendarDays,
        ),
        label: 'Calendar',
        tooltip: 'Calendar',
      ),
      BottomNavigationBarItem(
        icon: Settings(color: Constant.unselectedColor),
        activeIcon: Settings(color: Constant.dark),
        label: 'Settings',
        tooltip: 'Settings',
      ),
    ];

    assert(tabPages.length == bottomNavBarItems.length);

    final bottomNavigationBar = Obx(() {
      return BottomNavigationBar(
        items: bottomNavBarItems,
        currentIndex: controller.currentBottomNavbarTabIndex.value,
        onTap: (int index) => controller.setCurrentBottomNavbarTabIndex(index),
      );
    });

    final List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return GestureDetector(
      onTap: () =>
          FocusScope
              .of(context)
              .focusedChild
              ?.unfocus(),
      child: Obx(() {
        return Scaffold(
          backgroundColor: controller.currentBottomNavbarTabIndex.value == 2 ? Theme.of(context).appBarTheme.backgroundColor : Constant.backgroundColor,
          appBar: controller.currentBottomNavbarTabIndex.value == 2
              ? AppBar(
            title: DropdownButton<String>(
              items: months.map((String month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              value: months[controller.dropDownValue.value],
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: Constant.dark,
              ),
              icon: const Icon(LucideIcons.chevronDown),
              menuMaxHeight: 250,
              borderRadius: BorderRadius.circular(20.0),
              elevation: 4,
              onChanged: (String? newValue) {
                controller.setDropDownValue(months.indexOf(newValue!));
              },
              underline: Container(
                height: 0,
                color: Colors.transparent,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child:
              // SizedBox()
              TableCalendar(
                firstDay: DateTime(DateTime
                    .now()
                    .year, controller.dropDownValue.value + 1, 1),
                lastDay: DateTime(DateTime
                    .now()
                    .year, controller.dropDownValue.value + 1 + 1, 0),
                focusedDay: DateTime
                    .now()
                    .month == controller.dropDownValue.value + 1 ? DateTime
                    .now() : DateTime(DateTime
                    .now()
                    .year, controller.dropDownValue.value + 1, 1),
                currentDay: DateTime.now(),
                availableGestures: AvailableGestures.horizontalSwipe,
                calendarFormat: CalendarFormat.week,
                headerVisible: false,
                calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    selectedDecoration: BoxDecoration(
                        color: Constant.deepPurple, shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                        color: Constant.purple, shape: BoxShape.circle)
                ),
              ),
            ),
          )
              : AppBar(
            backgroundColor: Constant.backgroundColor,
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundImage: AssetImage(ImagePath.logo_jf),
              ),
              title: Text('Joel Fah',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Constant.dark)),
              subtitle: const Text('39 tasks today'),
            ),
            actions: [
              IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                onPressed: () {},
                icon: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Constant.borderColor, width: 2.0),
                      color: Constant.foregroundColor),
                  child: AppNotification(
                    color: Constant.dark,
                  ),
                ),
              )
            ],
          ),
          body: SizedBox(
            child: tabPages[controller.currentBottomNavbarTabIndex.value],
          ),
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(LucideIcons.plus),
          ),
        );
      }),
    );
  }
}
