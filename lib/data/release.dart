import 'package:flutter/material.dart';

class Release {
  final String id;
  final String content;
  final String title;
  final String headImg;
  final List img;
  final String biaoqian;
  final String createTime;
  final int clickCount;

  Release(
      {this.id,
      this.content,
      this.title,
      this.headImg,
      this.createTime,
      this.clickCount,
      this.img,
      this.biaoqian});

  factory Release.fromJson(Map<String, dynamic> json) {
    return Release(
        id: json['id'] as String,
        content: json['content'] as String,
        title: json['title'] as String,
        headImg: json['headImg'] as String,
        createTime: json['createTime'] as String,
        clickCount: json['clickCount'] as int,
        img: json['img'] as List,
        biaoqian: json['biaoqian'] as String);
  }
}
