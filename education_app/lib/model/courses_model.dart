// import 'package:education_app/resources/exports.dart';

class CourseModel {
  final String title;
  final String description;
  final String image;

  CourseModel(
      {required this.image, required this.title, required this.description});
}

List<CourseModel> courses = <CourseModel>[
  CourseModel(
      image: 'assets/images/mdcat.png',
      title: 'title',
      description: 'description')
];
