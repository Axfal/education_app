import 'package:education_app/resources/exports.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  // void _dispose() {
  //   titleController.dispose();
  //   descriptionController.dispose();
  // }

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes', style: AppTextStyle.appBarText),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<NotesModel>();
            return ListView.builder(
                itemCount: box.length,
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 5),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, bottom: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(data[index].title.toString(),
                                      style: AppTextStyle.profileTitleText),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        _update(
                                                data[index],
                                                data[index].title.toString(),
                                                data[index].description)
                                            .toString();
                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        // _delete(data[index]);
                                        _deleteNote(data[index]);
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                              Text(
                                data[index].description.toString(),
                                style: AppTextStyle.profileSubTitleText,
                              ),
                            ]),
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // _dispose();
          _showMyDialog();
        },
        backgroundColor: AppColors.primaryColor,
        child: Icon(
          Icons.add,
          color: AppColors.textColor,
        ),
      ),
    );
  }

  Future<void> _update(
      NotesModel notesModel, String title, String description) async {
    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Notes'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: 'Enter Title', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 5,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText: 'Enter Description',
                        border: OutlineInputBorder()),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    notesModel.title = titleController.text.toString();
                    notesModel.description =
                        descriptionController.text.toString();
                    notesModel.save();
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Save')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Notes'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: 'Enter Title', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 5,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText: 'Enter Description',
                        border: OutlineInputBorder()),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    final data = NotesModel(
                        title: titleController.text,
                        description: descriptionController.text);
                    final box = Boxes.getData();
                    box.add(data);
                    data.save();
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Add')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }

  Future<void> _deleteNote(NotesModel notesModel) async {
    return showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Do you want to delete the note permanently.',
              style: AppTextStyle.profileTitleText,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    notesModel.delete();
                    Navigator.pop(context);
                  },
                  child: Text('Delete')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }
}
