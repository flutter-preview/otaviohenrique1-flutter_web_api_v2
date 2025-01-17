import 'package:flutter/material.dart';
import 'package:flutter_web_api_v2/models/journal.dart';
import 'package:flutter_web_api_v2/screens/add_journal_screen/add_journal_screen.dart';
import 'package:flutter_web_api_v2/screens/home_screen/home_screen.dart';
import 'package:flutter_web_api_v2/screens/login_screen/login_screen.dart';
import 'package:flutter_web_api_v2/services/async_study.dart';
import 'package:flutter_web_api_v2/services/journal_service.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const App());

  JournalService service = JournalService();
  // service.register("Ola mundo");
  // service.register(Journal.empty());
  // service.getAll();
  asyncStudy();
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Journal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        // textTheme: GoogleFonts.bitterTextTheme(),
        // textTheme: TextTheme(),
        fontFamily: "Bitter",
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute: "login",
      routes: {
        "home": (context) => const HomeScreen(),
        "login": (context) => LoginScreen(),
        // "add-journal": (context) => AddJournalScreen(
        //       journal: Journal(
        //         id: "id",
        //         content: "content",
        //         createdAt: DateTime.now(),
        //         updatedAt: DateTime.now(),
        //       ),
        //     ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "add-journal") {
          Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;

          final Journal journal = map["journal"];
          // final Journal journal = settings.arguments as Journal;
          final bool isEditing = map["is_editing"];

          return MaterialPageRoute(builder: (context) {
            return AddJournalScreen(
              journal: journal,
              isEditing: isEditing,
            );
          });
        }
        return null;
      },
    );
  }
}
