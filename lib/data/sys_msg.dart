import 'package:flutter/material.dart';

class sys_msg {
  final String createTime;
  final String title;
  final String content;

  sys_msg({
    this.createTime,
    this.title,
    this.content,
  });

  factory sys_msg.fromJson(Map<String, dynamic> json) {
    return sys_msg(
      content: json['content'] as String,
      createTime: json['createTime'] as String,
      title: json['title'] as String,
    );
  }
}
