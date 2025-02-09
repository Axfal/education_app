import 'package:education_app/resources/exports.dart';

class ChaptersScreen extends StatefulWidget {
  const ChaptersScreen({super.key});

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  final List<String> _chapter = [
    'Simple Harmonic Motion and Waves',
    'Sound',
    'Geometrical Optics',
    'Electrostatics',
    'Current Electricity',
    'Electromagnetism',
    'Basic Electronics',
    'Information and Communication Technology',
    'Atomic and Nuclear Physics'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapters',style: AppTextStyle.appBarText,),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, RoutesName.questionScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 2),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            child: Center(
                                child: Text('${index + 1}',
                                    style: AppTextStyle.appBarText)),
                          ),
                          title: Text(_chapter[index]),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
