class Company {
  String? createdAt;
  String? companyName;
  String? logo;
  String? email;
  String? mobileNumber;
  String? address;
  int? gstNum;
  String? totalUnpaidBooking;
  int? availableCreditLimit;
  String? id;

  Company(
      {this.createdAt,
      this.companyName,
      this.logo,
      this.email,
      this.mobileNumber,
      this.address,
      this.gstNum,
      this.totalUnpaidBooking,
      this.availableCreditLimit,
      this.id});

  Company.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    companyName = json['companyName'];
    logo = json['logo'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    gstNum = json['gst_num'];
    totalUnpaidBooking = json['totalUnpaidBooking'];
    availableCreditLimit = json['availableCreditLimit'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['companyName'] = this.companyName;
    data['logo'] = this.logo;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['gst_num'] = this.gstNum;
    data['totalUnpaidBooking'] = this.totalUnpaidBooking;
    data['availableCreditLimit'] = this.availableCreditLimit;
    data['id'] = this.id;
    return data;
  }
}
