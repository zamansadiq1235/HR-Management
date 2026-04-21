import 'package:get/get.dart';

class NavBarController extends GetxController {

  RxInt selectedIndex = 0.obs;

  void changeTab(int index){
    selectedIndex.value = index;
  }

}