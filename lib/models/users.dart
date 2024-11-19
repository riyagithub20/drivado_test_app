class Users {
  String? createdAt;
  String? name;
  String? avatar;
  String? email;
  String? mobileNumber;
  String? currency;
  bool? isActive;
  String? totalUnpaidBooking;
  int? availableLimit;
  String? id;
  String? companyId;

  Users(
      {this.createdAt,
      this.name,
      this.avatar,
      this.email,
      this.mobileNumber,
      this.currency,
      this.isActive,
      this.totalUnpaidBooking,
      this.availableLimit,
      this.id,
      this.companyId});

  Users.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    name = json['name'];
    avatar = json['avatar'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    currency = json['currency'];
    isActive = json['isActive'];
    totalUnpaidBooking = json['totalUnpaidBooking'];
    availableLimit = json['availableLimit'];
    id = json['id'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['name'] = name;
    data['avatar'] = avatar;
    data['email'] = email;
    data['mobileNumber'] = mobileNumber;
    data['currency'] = currency;
    data['isActive'] = isActive;
    data['totalUnpaidBooking'] = totalUnpaidBooking;
    data['availableLimit'] = availableLimit;
    data['id'] = id;
    data['companyId'] = companyId;
    return data;
  }
}
