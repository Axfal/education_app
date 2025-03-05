class GetTestResultModel {
  bool? success;
  Test? test;
  String? date;
  Overall? overall;
  List<Subjects>? subjects;

  GetTestResultModel(
      {this.success, this.test, this.date, this.overall, this.subjects});

  GetTestResultModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    test = json['test'] != null ? new Test.fromJson(json['test']) : null;
    date = json['date'];
    overall =
        json['overall'] != null ? new Overall.fromJson(json['overall']) : null;
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.test != null) {
      data['test'] = this.test!.toJson();
    }
    data['date'] = this.date;
    if (this.overall != null) {
      data['overall'] = this.overall!.toJson();
    }
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Test {
  int? id;
  String? testName;

  Test({this.id, this.testName});

  Test.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testName = json['test_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_name'] = this.testName;
    return data;
  }
}

class Overall {
  int? correct;
  int? incorrect;
  String? percentage;
  String? status;

  Overall({this.correct, this.incorrect, this.percentage, this.status});

  Overall.fromJson(Map<String, dynamic> json) {
    correct = json['correct'];
    incorrect = json['incorrect'];
    percentage = json['percentage'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['percentage'] = this.percentage;
    data['status'] = this.status;
    return data;
  }
}

class Subjects {
  String? subjectName;
  int? correct;
  int? incorrect;
  int? total;
  String? percentage;
  String? status;

  Subjects(
      {this.subjectName,
      this.correct,
      this.incorrect,
      this.total,
      this.percentage,
      this.status});

  Subjects.fromJson(Map<String, dynamic> json) {
    subjectName = json['subject_name'];
    correct = json['correct'];
    incorrect = json['incorrect'];
    total = json['total'];
    percentage = json['percentage'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_name'] = this.subjectName;
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['total'] = this.total;
    data['percentage'] = this.percentage;
    data['status'] = this.status;
    return data;
  }
}
