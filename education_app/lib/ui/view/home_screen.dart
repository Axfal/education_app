import 'package:education_app/resources/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello, Anfal',
                            style: AppTextStyle.profileTitleText),
                        Text('Welcome to Eduka',
                            style: AppTextStyle.profileSubTitleText),
                      ],
                    ),
                    Image(
                      height: 50,
                      image: AssetImage('assets/images/profile.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SubscriptionButton(),
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
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4, // Number of courses
                itemBuilder: (context, index) {
                  return CoursesContainer(
                    'MDCAT',
                    'assets/images/mdcat.png',
                    'Brief description of the course content, highlighting key benefits and features.',
                    () {
                      Navigator.pushNamed(context, RoutesName.course);
                    },
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 0, left: 20),
            sliver: SliverToBoxAdapter(
              child: Text('My Notes', style: AppTextStyle.profileTitleText),
            ),
          ),
        ],
      ),
    );
  }
}
