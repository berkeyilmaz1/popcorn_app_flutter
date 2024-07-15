import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class DetailModel extends Equatable {
  String? categoryName;

  DetailModel({
    this.categoryName,
  });

  DetailModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['name'];
  }

  @override
  List<Object?> get props => [categoryName];
}
