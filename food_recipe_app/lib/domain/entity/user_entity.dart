class UserEntity {
  String id;
  DateTime createdAt;
  AuthenticationInformation authenticationInfo;
  ProfileInformation profileInfo;
  List<String> notificationBatchIds;
  String? currentNotificationBatchId;
  List<String> recipeIds;
  List<String> savedRecipeIds;
  List<String> followingIds;
  List<String> followerIds;
  List<LoginTicket> loginTickets;

  UserEntity(
      this.id,
      this.createdAt,
      this.authenticationInfo,
      this.profileInfo,
      this.notificationBatchIds,
      this.currentNotificationBatchId,
      this.recipeIds,
      this.savedRecipeIds,
      this.followingIds,
      this.followerIds,
      this.loginTickets);
}

class ProfileInformation {
  String fullName;
  String avatarUrl;
  bool isVegan;
  String bio;
  List<String> categories;
  int hungryHeads;

  ProfileInformation(this.fullName, this.avatarUrl, this.isVegan, this.bio,
      this.categories, this.hungryHeads);
}

class AuthenticationInformation {
  String? googleId;
  String? facebookId;
  String? email;
  String? password;

  AuthenticationInformation(
      this.googleId, this.facebookId, this.email, this.password);
}

class LoginTicket {
  String refreshToken;
  String deviceInfo;
  DateTime createTime;
  DateTime expireTime;

  LoginTicket(
      this.refreshToken, this.deviceInfo, this.createTime, this.expireTime);
}
