// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:education_app/resources/exports.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCourses();
  }

  void fetchCourses() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.fetchCoursesList();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Error fetching subjects: $e");
      }
      if (kDebugMode) {
        print(stackTrace);
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final subjectprovider = Provider.of<SubjectProvider>(context);
    final courseProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Eduka',
          style: AppTextStyle.appBarText,
        ),
        centerTitle: true,
      ),
      drawer: drawerWidget(context),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello, Anfal', style: AppTextStyle.profileTitleText),
                    Text('Welcome to Eduka',
                        style: AppTextStyle.profileSubTitleText),
                  ],
                ),
              ),
            ),
          ),
          // SliverPadding(
          //   padding: const EdgeInsets.only(top: 0, left: 20),
          //   sliver: SliverToBoxAdapter(
          //     child: Text('Features', style: AppTextStyle.profileTitleText),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: SubscriptionButton((){
              Navigator.pushNamed(context, RoutesName.subscriptionScreen);
            }),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 30, bottom: 10, left: 20),
            sliver: SliverToBoxAdapter(
              child: Text('Courses We Offer',
                  style: AppTextStyle.profileTitleText),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 240,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : (courseProvider.courseList!.data!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: courseProvider.courseList!.data!.length,
                          itemBuilder: (context, index) {
                            final courseData =
                                courseProvider.courseList!.data![index];
                            final int? courseId = courseData.id;
                            final String courseName =
                                courseData.testName ?? 'Course';
                            return CoursesContainer(
                              courseName,
                              'assets/images/mdcat.png',
                              'Brief description of the course content, highlighting key benefits and features.',
                              () async {
                                if (courseId != null) {
                                  if (kDebugMode) {
                                    print("Passing course id: $courseId");
                                  }
                                  final userType =
                                      courseProvider.userSession?.userType;
                                  print('userType = $userType');
                                  if (userType == "free") {
                                    // await subjectprovider.setSubjects(courseId);
                                    Navigator.pushNamed(
                                        context, RoutesName.course,
                                        arguments: {'courseId': courseId});
                                  } else {
                                    // await subjectprovider.setSubjects(courseId);
                                    Navigator.pushNamed(
                                        context, RoutesName.course,
                                        arguments: {'courseId': courseId});
                                  }
                                } else {
                                  if (kDebugMode) {
                                    print("Course id is null");
                                  }
                                }
                              },
                            );
                          },
                        )
                      : Center(
                          child: Text("No courses available",
                              style: AppTextStyle.profileSubTitleText))),
            ),
          ),

        ],
      ),
    );
  }
  // Widget FeatureButton(VoidCallback onTap, IconData icon, ) => InkWell(
  //   onTap: onTap,
  //   child: Padding(
  //     padding: const EdgeInsets.all(5.0),
  //     child: Container(
  //       height: 50,
  //       width: 50,
  //       decoration: BoxDecoration(
  //         color: Colors.blue,
  //           borderRadius: BorderRadius.circular(20)
  //       ),
  //       child: Column(
  //         children: [],
  //       ),
  //     ),
  //   ),
  // );
}
