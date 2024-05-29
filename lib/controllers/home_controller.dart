import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt _currentBottomNavbarTabIndex = 0.obs;
  RxInt get currentBottomNavbarTabIndex => _currentBottomNavbarTabIndex;

  TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  RxInt _dropDownValue = DateTime.now().month.obs;
  RxInt get dropDownValue => _dropDownValue;


  void setCurrentBottomNavbarTabIndex(int index) {
    _currentBottomNavbarTabIndex.value = index;
  }

  void clearSearchInput(){
    _searchController.clear();
    update();
  }

  void setDropDownValue(int newValue){
    _dropDownValue.value = newValue;
  }
}