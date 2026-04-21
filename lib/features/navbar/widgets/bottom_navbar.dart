import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../controller/navbar_controller.dart';

class BottomNavbar extends StatelessWidget {
  BottomNavbar({super.key});

  final controller = Get.find<NavBarController>();

  final List<Widget> icons = [
    SvgPicture.asset(AppAssets.home),
    SvgPicture.asset(AppAssets.calendar),
    SvgPicture.asset(AppAssets.notetext),
    SvgPicture.asset(AppAssets.receipt),
    SvgPicture.asset(AppAssets.layer1),
  ];
  final List<Widget> activeicons = [
    SvgPicture.asset(AppAssets.homeactive),
    SvgPicture.asset(AppAssets.calendar1),
    SvgPicture.asset(AppAssets.notetext1),
    SvgPicture.asset(AppAssets.receipt1),
    SvgPicture.asset(AppAssets.layer),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff0f0f0f), Color(0xff1b1b1b)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          icons.length,
          (index) => Obx(() {
            final isActive = controller.selectedIndex.value == index;

            return GestureDetector(
              onTap: () => controller.changeTab(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: SizedBox(
                      height: 30,
                      width: 45,
                      child: isActive ? activeicons[index] : icons[index],
                    ),
                  ),
                  const SizedBox(height: 6),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 3,
                    width: isActive ? 20 : 0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // Widget _buildIcon(String asset, bool isActive) {
  //   return SvgPicture.asset(
  //     asset,
  //     colorFilter: ColorFilter.mode(
  //       isActive ? Colors.white : Colors.grey,
  //       BlendMode.srcIn,
  //     ),
  //   );
  // }
}
