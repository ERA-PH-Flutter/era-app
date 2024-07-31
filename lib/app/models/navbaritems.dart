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
      defaultIcon:
         'assets/icons/home-navi_white.png',
      selectedIcon:
         'assets/icons/home-navi.png',
      label: "HOME",
      selectedLabel: "HOME",
      onTap: () => Get.toNamed("/home")),
  AppPngAssets(
      defaultIcon:
         'assets/icons/project.png',
      selectedIcon:
          'assets/icons/project1.png',
      label: "PROJECTS",
      selectedLabel: "PROJECTS",
      onTap: () => Get.toNamed("/project-main")),
  AppPngAssets(
      defaultIcon:
        'assets/icons/search-navi_white.png' ,
      selectedIcon:
        'assets/icons/search-navi.png',
      label: "SEARCH",
      selectedLabel: "SEARCH",
      onTap: () => Get.toNamed("/searchresult")),
  AppPngAssets(
      defaultIcon:
        'assets/icons/findagents.png' ,
      selectedIcon:
       'assets/icons/findagents1.png'  ,
      label: "FIND AGENTS",
      selectedLabel: "FIND AGENTS",
      onTap: () => Get.toNamed("/findagents")),
  AppPngAssets(
      defaultIcon:
        'assets/icons/help.png' ,
      selectedIcon:
          'assets/icons/help1.png',
      label: "HELP",
      selectedLabel: "HELP",
      onTap: () => Get.toNamed("/help")),
];


// "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2Fnavbottombar%2Fhome-navi_white.png?alt=media&token=187796a6-46d7-426a-a6f4-c88bf555f966"
//  "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2Fnavbottombar%2Fhome-navi.png?alt=media&token=d32ce53d-c0af-4283-b8f3-6af5af66b99b"
//  "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2Fnavbottombar%2Fproject.png?alt=media&token=20b41925-6a75-4923-ba25-7fa27ccd501e"
//  "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2Fnavbottombar%2Fproject1.png?alt=media&token=375ee2ad-6c21-4863-8e23-6904c463e6cd"
//   "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2Fnavbottombar%2Fsearch-navi_white.png?alt=media&token=3ed0d2c8-3543-44c2-9c64-7aa980a692b7"
//    "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2Fnavbottombar%2Fsearch-navi.png?alt=media&token=73518c36-5d47-45e8-8275-716e92328b45"
//     "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2Fnavbottombar%2Ffindagents.png?alt=media&token=38227ff8-c234-4117-a9b2-c0b8b5819683"
//      "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2Fnavbottombar%2Ffindagents1.png?alt=media&token=37756cc7-2e48-4c67-bf9b-8defab8c7571"
//       "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2Fnavbottombar%2Fhelp.png?alt=media&token=39c02489-158b-41d5-9b17-3e4c1d90485f"
//       "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2Fnavbottombar%2Fhelp1.png?alt=media&token=66f15533-7e38-4c4b-8a89-fbc6d171de3c"