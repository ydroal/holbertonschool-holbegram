import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import '../screens/pages/feed.dart';
import '../screens/pages/search.dart';
import '../screens/pages/add_image.dart';
import '../screens/pages/favorite.dart';
import '../screens/pages/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});
  
  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  late PageController _pageController;


  @override
    void initState() {
      super.initState();
      _pageController = PageController();
    }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          Feed(),
          Search(),
          AddImage(),
          Favorite(),
          Profile(),
        ],
        // onPageChanged: (index) {
        //   setState(() => _currentIndex = index);
        // },
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          // _pageController.jumpToPage(index);
        },
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.feed),
            title: const Text('Feed',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
              )
            ),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
            ),
          BottomNavyBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
              )
            ),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
            ),
          BottomNavyBarItem(
            icon: const Icon(Icons.add_a_photo),
            title: const Text('Add Image',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
              )
            ),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
            ),
          BottomNavyBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text('Favorite',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
              )
            ),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
            ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
              )
            ),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
            ),
        ],
      ),
    );
  }
}