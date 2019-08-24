class guanzhuUser {
  final String userId;
  final String birthday;
  final String phone;
  final String headImg;
  final String sex;
  final String isRenzheng;
  final int isShoucang;
  final int age;
  final int money;
  final String account;
  final String userName;
  final String vipType;
  final String qq;

  guanzhuUser(
      {this.userId,
      this.birthday,
      this.phone,
      this.headImg,
      this.sex,
      this.isRenzheng,
      this.isShoucang,
      this.age,
      this.money,
      this.account,
      this.userName,
      this.vipType,
      this.qq});

  factory guanzhuUser.fromJson(Map<String, dynamic> json) {
    return guanzhuUser(
        userId: json['id'] as String,
        birthday: json['birthday'] as String,
        phone: json['phone'] as String,
        headImg: json['headImg'] as String,
        sex: json['sex'] as String,
        isRenzheng: json['isRenzheng'] as String,
        isShoucang: json['isShoucang'] as int,
        age: json['age'] as int,
        money: json['money'] as int,
        account: json['account'] as String,
        userName: json['userName'] as String,
        vipType: json["vipType"] as String,
        qq: json["qq"] as String);
  }
}
