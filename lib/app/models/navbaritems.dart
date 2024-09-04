import 'package:eraphilippines/app/constants/assets.dart';
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
      defaultIcon: AppEraAssets.home,
      selectedIcon: AppEraAssets.home1,
      label: "HOME",
      selectedLabel: "HOME",
      onTap: () {
        if (Get.currentRoute != "/home") {
          Get.offAllNamed("/home");
        }
      }),
  AppPngAssets(
      defaultIcon: AppEraAssets.project,
      selectedIcon: AppEraAssets.project1,
      label: "PROJECTS",
      selectedLabel: "PROJECTS",
      onTap: () => Get.offAllNamed("/project-main")),
  AppPngAssets(
      defaultIcon: AppEraAssets.search,
      selectedIcon: AppEraAssets.search1,
      label: "SEARCH",
      selectedLabel: "SEARCH",
      onTap: () => Get.offAllNamed("/searchresult")),
  AppPngAssets(
      defaultIcon: AppEraAssets.findagents,
      selectedIcon: AppEraAssets.findagents1,
      label: "FIND AGENTS",
      selectedLabel: "FIND AGENTS",
      onTap: () => Get.offAllNamed("/findagents")),
  AppPngAssets(
      defaultIcon: AppEraAssets.help,
      selectedIcon: AppEraAssets.help1,
      label: "HELP",
      selectedLabel: "HELP",
      onTap: () => Get.offAllNamed("/help")),
];
