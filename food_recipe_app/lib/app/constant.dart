class Constant {
  static const String severUrl = 'http://192.168.1.106:5115';
  static const String baseUrl = '$severUrl/api';
  static const String notificationUrl = '$severUrl/notificationHub';
  static const String loginEndpoint = '/Login';
  static const String recipeEndpoint = '/Recipe';
  static const String notificationEndpoint = '/Notification';
  static const String userEndpoint = '/User';
  static const String commentEndpoint = '/Comment';
  static const String notificationHub = "/NotificationHub";
  static const List<String> typeList = [
    "Healthy",
    "Fast Food",
    "Quick",
    "Cuisine",
    "Breakfast",
    "Snack",
    "Lunch",
    "Dinner",
    "Dessert",
    "Soup",
    "Drink",
    "Traditional"
  ];
}
