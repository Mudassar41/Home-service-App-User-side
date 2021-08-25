class ProviderProfile {
  String id;
  String imageLink;
  String providerFirstName;
  String providerLastName;
  String providerPhoneNumber;
  String deviceToke;

  ProviderProfile(
      {this.id,
      this.imageLink,
      this.providerFirstName,
      this.providerLastName,
      this.providerPhoneNumber,
      this.deviceToke});

  factory ProviderProfile.fromJson(Map<String, dynamic> json) =>
      ProviderProfile(
          id: json["_id"],
          imageLink: json['imageLink'],
          providerFirstName: json["providerFirstName"],
          providerLastName: json["providerLastName"],
          providerPhoneNumber: json["providerPhoneNumber"],
          deviceToke: json['deviceToken']);
}
