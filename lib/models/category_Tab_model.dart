// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ecommerce_new/utils/app_colors.dart';

class CategoryModel {
  final String id;
  final String name;
  final int productsCount;
  final Color bgColor;
  final Color textColor;
  final String imgurl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.productsCount,
    this.bgColor = Appcolors.primary,
    this.textColor = Appcolors.white,
    required this.imgurl,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'productsCount': productsCount});
    result.addAll({'bgColor': bgColor.value.toRadixString(16)});
    result.addAll({'textColor': textColor.value.toRadixString(16)});

    return result;
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      productsCount: map['productsCount'.toString()] ?? 0,
      bgColor: Color(int.tryParse('0xFF${map['bgColor']}') ?? 0xEEEEEE),
      textColor: Color(int.tryParse('0xFF${map['textColor']}') ?? 0x000000),
      imgurl: map['imgurl'] ?? '',
    );
  }
}

List<CategoryModel> dummyCategories = [
  // CategoryModel(
  //   id: '1',
  //   name: 'New Arrivals',
  //   productsCount: 208,
  //   bgColor: Appcolors.grey,
  //   textColor: Appcolors.black,
  // ),
  // CategoryModel(
  //   id: '2',
  //   name: 'Clothes',
  //   productsCount: 358,
  //   bgColor: Appcolors.green,
  //   textColor: Appcolors.white,
  // ),
  // CategoryModel(
  //   id: '3',
  //   name: 'Bags',
  //   productsCount: 160,
  //   bgColor: Appcolors.black,
  //   textColor: Appcolors.white,
  // ),
  // CategoryModel(
  //     id: '4',
  //     name: 'Shoes',
  //     productsCount: 230,
  //     bgColor: Appcolors.grey,
  //     textColor: Appcolors.black),
  // CategoryModel(
  //     id: '5',
  //     name: 'Electronics',
  //     productsCount: 101,
  //     bgColor: Appcolors.blue,
  //     textColor: Appcolors.white),
];
