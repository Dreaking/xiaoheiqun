import 'package:flutter/material.dart';

class Animate {
  final String id;
  final String createTime;
  final String title;
  final String headImg;
  final int clickCount;
  final bool isShoucang;
  final String isRenzheng;
  final List img;
  final String merchantName;
  final String merchantId;
  final int taolunCount;

  Animate(
      {this.id,
      this.createTime,
      this.title,
      this.headImg,
      this.clickCount,
      this.isShoucang,
      this.isRenzheng,
      this.img,
      this.merchantName,
      this.merchantId,
      this.taolunCount});

  factory Animate.fromJson(Map<String, dynamic> json) {
    return Animate(
      id: json['id'] as String,
      createTime: json['createTime'] as String,
      title: json['title'] as String,
      headImg: json['headImg'] as String,
      clickCount: json['clickCount'] as int,
      isShoucang: json['isShoucang'] as bool,
      isRenzheng: json['isRenzheng'] as String,
      img: json['img'] as List,
      merchantName: json['merchantName'] as String,
      merchantId: json['merchantId'] as String,
      taolunCount: json['taolunCount'] as int,
    );
  }
}
