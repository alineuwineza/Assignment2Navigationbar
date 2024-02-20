import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'NavBar.dart';
import 'login_screen.dart';
import 'signup_screen.dart'; 
import 'screen.dart'; 

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

  final List<Widget> _widgetOptions = <Widget>[
    Container(
      color: Color.fromARGB(255, 7, 160, 255),
      child: Center(
        child: Text(
          "Gallery",
          style: optionStyle,
        ),
      ),
    ),
    Container(
      color: Color.fromARGB(255, 135, 140, 210),
      child: Center(
        child: Text(
          "explore",
          style: optionStyle,
        ),
      ),
    ),
    Screen(), 
    SignUpScreen(),
    LoginScreen(),
  ];

  
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
                    icon: LineIcons.internetExplorer,
                    text: "explore",
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
