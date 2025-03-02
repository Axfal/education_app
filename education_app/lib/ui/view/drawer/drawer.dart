// ignore_for_file: prefer_const_constructors

import 'package:education_app/resources/exports.dart';

Widget drawerWidget(BuildContext context) => Drawer(
      backgroundColor: AppColors.primaryColor,
      child: Container(
        decoration: BoxDecoration(color: AppColors.primaryColor),
        child: Consumer<BottomNavigatorBarProvider>(
          builder: (context, provider, child) {
            return ListView(children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      // child:
                      // Image(image: AssetImage('assets/images/profile.png')),
                    ),
                    SizedBox(height: 5),
                    Text('Muhammad Anfal',
                        style: AppTextStyle.subscriptionTitleText),
                    Text('anfalshah72@gmil.com',
                        style: AppTextStyle.subscriptionDetailText),
                  ],
                ),
              ),
              drawerItems('Profile', () {
                Navigator.pushNamed(context, RoutesName.profile);
              }, Icons.account_circle),
              drawerItems('Create Mock Test', () {
                Navigator.pushNamed(context, RoutesName.createMockTest);
              }, Icons.create_new_folder_outlined),
              drawerItems('Previous Tests', () {
                Navigator.pushNamed(context, RoutesName.previousTestScreen);
              }, Icons.history_outlined),
              drawerItems('Notes', () {
                Navigator.pushNamed(context, RoutesName.noteScreen);
              }, Icons.notes_outlined),
              drawerItems('My Notebook', () {}, Icons.book_outlined),
              drawerItems('Help', () {}, Icons.help_outline_outlined),
              drawerItems('Sign  Out', () {
                LogOut(context);
              }, Icons.logout),
            ]);
          },
        ),
      ),
    );

void LogOut(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Do you want to Logged out?',
        style: AppTextStyle.questionText,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: (){
                try {
                  final previousTestProvider =
                      Provider.of<PreviousTestProvider>(context, listen: false);
                  final provider =
                      Provider.of<AuthProvider>(context, listen: false);

                  // previousTestProvider.deleteAllTests;
                  provider.logout();
                  Navigator.pushReplacementNamed(context, RoutesName.login);
                } catch (e) {
                  rethrow;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logged out successfully!'),
                  ),
                );

                // Navigator.pop(context);
                //
                // try {
                //   final provider =
                //       Provider.of<AuthProvider>(context, listen: false);
                //   provider.logout();
                //
                //   Navigator.pushReplacementNamed(context, RoutesName.login);
                // } catch (e) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text('Error logging out!')),
                //   );
                // }
              },
              child: Text('Logout')),
          SizedBox(width: 20),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel')),
        ],
      ),
    ),
  );
}

Widget drawerItems(String title, VoidCallback onTap, IconData icon) => InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.textColor,
        ),
        title: Text(
          title,
          style: AppTextStyle.drawerText,
        ),
      ),
    );
