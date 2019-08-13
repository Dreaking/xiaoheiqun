import 'package:flutter/material.dart';

class Draft {
  final String id;
  final String content;
  final String title;
  final String headImg;
  final List img;
  final String biaoqian;

  Draft(
      {this.id,
      this.content,
      this.title,
      this.headImg,
      this.img,
      this.biaoqian});

  factory Draft.fromJson(Map<String, dynamic> json) {
    return Draft(
        id: json['id'] as String,
        content: json['content'] as String,
        title: json['title'] as String,
        headImg: json['headImg'] as String,
        img: json['img'] as List,
        biaoqian: json['biaoqian'] as String);
  }
}
