import 'package:flutter/material.dart';
import 'package:flutter_hive_note/presentation/create_note.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_hive_note/model/note.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());

  await Hive.openBox<Note>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  NotePage(),
    );
  }
}


class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late Box<Note> noteBox;

  @override
  void initState() {
    super.initState();
    noteBox = Hive.box<Note>('notes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Notes',
        style: GoogleFonts.caveat(fontWeight: FontWeight.bold,)),
        elevation: 4.0,
      ),
      body: ListView.builder(
        itemCount: noteBox.length,
        itemBuilder: (context, index) {
          final note = noteBox.getAt(index);
          return ListTile(
            style: ListTileStyle.drawer,
            title: Text(note!.title, style: TextStyle(fontWeight: FontWeight.bold), strutStyle: StrutStyle(height: 1),),
            subtitle: Text(note.content, 
            maxLines: 1, 
            overflow: TextOverflow.ellipsis, 
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontFamily: 'cursive'
               ),),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red,),
              onPressed: () {
                noteBox.deleteAt(index);
                setState(() {
                  
                });
              }
            ),
            onTap: () {
              noteBox.putAt(
                index,
                Note(
                  title: note.title,
                  content: note.content,
              )
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => NoteCreatePage())); },child: Icon(Icons.add),),
    );
  }
}