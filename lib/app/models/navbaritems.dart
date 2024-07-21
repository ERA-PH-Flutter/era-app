import 'package:get/get.dart';

class AppPngAssets {
  final String defaultIcon;
  final String selectedIcon;
  final String label;
  final String selectedLabel;
  final Function? onTap;

  AppPngAssets(
      {required this.defaultIcon,
      required this.selectedIcon,
      required this.label,
      required this.selectedLabel,
      this.onTap});
}

List<AppPngAssets> navBarItems = [
  AppPngAssets(
      defaultIcon: "assets/icons/home-navi_white.png",
      selectedIcon: "assets/icons/home-navi.png",
      label: "HOME",
      selectedLabel: "HOME",
      onTap: () => Get.toNamed("/home")),
  AppPngAssets(
      defaultIcon: "assets/icons/project.png",
      selectedIcon: "assets/icons/project1.png",
      label: "PROJECTS",
      selectedLabel: "PROJECTS",
      onTap: () => Get.toNamed("/project-main")),
  AppPngAssets(
      defaultIcon: "assets/icons/search-navi_white.png",
      selectedIcon: "assets/icons/search-navi.png",
      label: "SEARCH",
      selectedLabel: "SEARCH",
      onTap: () => Get.toNamed("/searchresult")),
  AppPngAssets(
      defaultIcon: "assets/icons/findagents.png",
      selectedIcon: "assets/icons/findagents1.png",
      label: "FIND AGENTS",
      selectedLabel: "FIND AGENTS",
      onTap: () => Get.toNamed("/findagents")),
  AppPngAssets(
      defaultIcon: "assets/icons/help.png",
      selectedIcon: "assets/icons/help1.png",
      label: "HELP",
      selectedLabel: "HELP",
      onTap: () => Get.toNamed("/help")),
];
