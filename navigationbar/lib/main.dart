import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'NavBar.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'screen.dart';
import 'homescreen.dart';
import 'contact.dart'; // Import Contact class from separate file

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  List<Widget> _widgetOptions = []; // Initialize as empty list

  final ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    hintColor: Colors.amber,
    brightness: Brightness.light,
  );

  final ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.teal,
    hintColor: Colors.deepOrange,
    brightness: Brightness.dark,
  );

  ThemeData _currentTheme = ThemeData.light();

  void _toggleTheme() {
    setState(() {
      _currentTheme = (_currentTheme == _lightTheme) ? _darkTheme : _lightTheme;
    });
  }

  List<Contact> _contacts = []; // Initialize as empty list

  @override
  void initState() {
    super.initState();
    _contacts =
        Contact.generateRandomContacts(10); // Generate initial random contacts

    // Initialize _widgetOptions after _contacts is initialized
    _widgetOptions = <Widget>[
      HomeScreen(),
      Container(
        color: Colors.blue, // Changed background color to blue
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Contacts", // Changed text here
                style: optionStyle.copyWith(
                    color: Colors.white), // Changed text color to white
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_contacts[index].name),
                      subtitle: Text(_contacts[index].phoneNumber),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Import more contacts
                  setState(() {
                    _contacts.addAll(Contact.generateRandomContacts(5));
                  });
                },
                child: Text('Import More Contacts'),
              ),
            ],
          ),
        ),
      ),
      Screen(),
      LoginScreen(),
      SignUpScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _currentTheme,
      home: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("Navigation Bar"),
          actions: [
            IconButton(
              icon: Icon(Icons.lightbulb),
              onPressed: _toggleTheme,
            ),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 30,
                color: Colors.blueGrey.withOpacity(0.1),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[300]!,
                gap: 7,
                activeColor: Colors.blueAccent,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: LineIcons.enviraGallery,
                    text: "gallery",
                  ),
                  GButton(
                    icon: LineIcons.users,
                    text: "contacts",
                  ),
                  GButton(
                    icon: LineIcons.calculator,
                    text: "Calculator",
                  ),
                  GButton(
                    icon: LineIcons.userLock,
                    text: "Login",
                  ),
                  GButton(
                    icon: LineIcons.userPlus,
                    text: "Sign Up",
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
