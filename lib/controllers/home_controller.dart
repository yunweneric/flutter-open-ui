import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt _currentBottomNavbarTabIndex = 0.obs;
  RxInt get currentBottomNavbarTabIndex => _currentBottomNavbarTabIndex;

  TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  void setCurrentBottomNavbarTabIndex(int index) {
    _currentBottomNavbarTabIndex.value = index;
  }

  void clearSearchInput(){
    _searchController.clear();
    update();
  }
}