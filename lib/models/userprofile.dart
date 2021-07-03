class UserProfile {
  String userId;
  String firstName;
  String lastName;
  String phoneNumber;
  String userImage;
  String password;
  String confirmPassword;

  UserProfile({this.userId, this.firstName, this.lastName, this.phoneNumber,this.userImage});

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userId: json["_id"],
        firstName: json["userFirstName"],
        lastName: json["userLastName"],
        phoneNumber: json["userPhoneNumber"],
      );
}
