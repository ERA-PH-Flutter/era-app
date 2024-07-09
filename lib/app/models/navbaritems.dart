class AppPngAssets {
  final String defaultIcon;
  final String selectedIcon;
  final String label;
  final String selectedLabel;

  AppPngAssets(
      {required this.defaultIcon,
      required this.selectedIcon,
      required this.label,
      required this.selectedLabel});
}

List<AppPngAssets> navBarItems = [
  AppPngAssets(
      defaultIcon: "assets/icons/home-navi_white.png",
      selectedIcon: "assets/icons/home-navi.png",
      label: "Home",
      selectedLabel: "Home"),
  AppPngAssets(
      defaultIcon: "assets/icons/search-navi_white.png",
      selectedIcon: "assets/icons/search-navi.png",
      label: "Search",
      selectedLabel: "Search"),
  AppPngAssets(
    defaultIcon: "assets/icons/favs-navi_white.png",
    selectedIcon: "assets/icons/favs-navi.png",
    label: "Favorites",
    selectedLabel: "Favorites",
  ),
  AppPngAssets(
      defaultIcon: "assets/icons/mail-navi_white.png",
      selectedIcon: "assets/icons/mail-navi.png",
      label: "Mail",
      selectedLabel: "Mail"),
  AppPngAssets(
      defaultIcon: "assets/icons/training-navi_white.png",
      selectedIcon: "assets/icons/training-navi.png",
      label: "Training",
      selectedLabel: "Training"),
];
