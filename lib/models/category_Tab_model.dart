// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:ecommerce_new/utils/app_colors.dart';

class CategoryModel {
  final String id;
  final String name;
  final int productsCount;
  final Color bgColor;
  final Color textColor;
  final String imgurl;
  final String category;

  CategoryModel({
    required this.id,
    required this.name,
    required this.productsCount,
    this.bgColor = Appcolors.primary,
    this.textColor = Appcolors.white,
    required this.imgurl,
    required this.category,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'productsCount': productsCount,
      'bgColor': bgColor.value,
      'textColor': textColor.value,
      'imgurl': imgurl,
      'category': category,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      productsCount: int.tryParse(map['productsCount'].toString()) ?? 0,
      bgColor:
          map['bgColor'] is int ? Color(map['bgColor']) : Appcolors.primary,
      textColor:
          map['textColor'] is int ? Color(map['textColor']) : Appcolors.white,
      imgurl: map['imgurl'] as String? ?? '',
      category: map['category'] as String? ?? '',
    );
  }
}

List<CategoryModel> dummyCategories = [];
