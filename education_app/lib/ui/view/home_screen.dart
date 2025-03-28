// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:education_app/resources/exports.dart';
import 'package:education_app/view_model/provider/profile_provider.dart';
import 'package:no_screenshot/no_screenshot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  final NoScreenshot _noScreenshot = NoScreenshot.instance;

  @override
  void initState() {
    super.initState();
    _noScreenshot.screenshotOn();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCourses();
      getUserData();
    });
  }

  void getUserData() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    await profileProvider.getUserProfileData(context);
  }

  void fetchCourses() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.fetchCoursesList();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Error fetching subjects: $e");
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
    final courseProvider = Provider.of<AuthProvider>(context, listen: false);
    final userData = Provider.of<ProfileProvider?>(context);
    final String baseUrl = "https://nomore.com.pk/MDCAT_ECAT_Education/API/";
    String? profileImage = userData?.profileModel?.user?.profileImage;
    String defaultImageUrl = 'https://storage.needpix.com/rsynced_images/head-659651_1280.png';

    String imageUrl = (profileImage != null && profileImage.startsWith('http'))
        ? profileImage
        : '$baseUrl$profileImage';

    if (profileImage == null || profileImage.isEmpty) {
      imageUrl = defaultImageUrl;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('ThinkMatte', style: AppTextStyle.appBarText),
        centerTitle: true,
      ),
      drawer: userData?.profileModel != null
          ? drawerWidget(context, userData!)
          : Container(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (userData?.profileModel?.success == true)
                          Text(
                            'Hello ${userData?.profileModel?.user?.username ?? "User"}',
                            style: AppTextStyle.profileTitleText,
                          )
                        else
                          Text(
                            'User name not found',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        Text('Welcome to ThinkMatte',
                            style: AppTextStyle.profileSubTitleText),
                      ],
                    ),
                    CircleAvatar(
                      // backgroundColor: AppColors.primaryColor,
                      radius: 25,
                      backgroundImage: imageUrl.isNotEmpty
                          ? NetworkImage(imageUrl)
                          : AssetImage('assets/images/mdcat.png'),

                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SubscriptionButton(() {
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
                  : (courseProvider.courseList?.data?.isNotEmpty ?? false)
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              courseProvider.courseList?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final courseData =
                                courseProvider.courseList!.data![index];
                            final int courseId = courseData.id ?? -1;
                            final String courseName =
                                courseData.testName ?? 'Course';

                            return CoursesContainer(
                              courseName,
                              'assets/images/mdcat.png',
                              'Brief description of the course content, highlighting key benefits and features.',
                              () async {
                                if (courseId != -1) {
                                  print("Passing course id: $courseId");
                                  final userType =
                                      courseProvider.userSession?.userType;
                                  print('userType = $userType');

                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.course,
                                    arguments: {'courseId': courseId},
                                  );
                                } else {
                                  print("Course id is null");
                                }
                              },
                            );
                          },
                        )
                      : Center(
                          child: Text("No courses available",
                              style: AppTextStyle.profileSubTitleText),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
