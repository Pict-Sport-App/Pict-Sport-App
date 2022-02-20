class NavigationModel {
  String title;
  int num;
  NavigationModel({required this.title, required this.num});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "App User", num: 1),
  NavigationModel(title: "Setting", num: 2),
  NavigationModel(title: "Developer", num: 3),
  NavigationModel(title: "LogOut", num: 4),
];
