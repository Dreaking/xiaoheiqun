import 'package:flutter/material.dart';

class Renzheng {
  final String userId;
  final String birthday;
  final String phone;
  final String headImg;
  final String sex;
  final String isRenzheng;
  final String isShoucang;
  final int age;
  final int money;
  final String userName;
  final String vipType;
  final String qq;
  final String alipayNumber;
  final String poll;
  final String vipdaoqitime;
  final String fromPoll;

  Renzheng(
      {this.userId,
      this.birthday,
      this.isShoucang,
      this.phone,
      this.headImg,
      this.sex,
      this.isRenzheng,
      this.age,
      this.money,
      this.userName,
      this.vipType,
      this.qq,
      this.alipayNumber,
      this.fromPoll,
      this.poll,
      this.vipdaoqitime});

  factory Renzheng.fromJson(Map<String, dynamic> json) {
    return Renzheng(
      userId: json['userId'] as String,
      birthday: json['birthday'] as String,
      phone: json['phone'] as String,
      headImg: json['headImg'] as String,
      sex: json['sex'] as String,
      isRenzheng: json['isRenzheng'] as String,
      age: json['age'] as int,
      money: json['money'] as int,
      userName: json['userName'] as String,
      vipType: json["vipType"] as String,
      qq: json["qq"] as String,
      alipayNumber: json["alipayNumber"] as String,
      fromPoll: json["fromPoll"] as String,
      poll: json["poll"] as String,
      vipdaoqitime: json["vipdaoqitime"] as String,
      isShoucang: json["isShoucang"] as String,
    );
  }
}
