import 'package:flutter_openui/ui/pages/home.dart';
import 'package:get/get.dart';

class Routes {
  static String homePage = '/';
}

final List<GetPage> pages = [
  GetPage(
    name: Routes.homePage,
    page: () => const HomePage(),
  ),
];