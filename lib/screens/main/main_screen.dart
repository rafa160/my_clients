import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_clients_by_anduril/screens/client/client_module.dart';
import 'package:my_clients_by_anduril/screens/home/home_module.dart';
import 'package:my_clients_by_anduril/screens/profile/profile_module.dart';
import 'package:my_clients_by_anduril/screens/prospect_clients/prospect_clients_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }


  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            HomeModule(),
            ProspectClientsModule(),
            ClientModule(),
            ProfileModule(),
          ]),
      bottomNavigationBar:  AnimationConfiguration.staggeredList(
          duration: const Duration(milliseconds: 550),
          position: 1,
          child: SlideAnimation(
            verticalOffset: 150,
            child: FadeInAnimation(
              child:  ConvexAppBar(
                backgroundColor: Colors.white,
                color: Colors.black26,
                activeColor: background,
                style: TabStyle.react,
                items: [
                  TabItem(icon: Icons.home, title: 'Home'),
                  TabItem(icon: Icons.error, title: 'Prospectos'),
                  TabItem(icon: Icons.check_box, title: 'Clientes'),
                  TabItem(icon: Icons.person, title: 'Perfil'),
                ],
                initialActiveIndex: 0,
                onTap: (int i) => _pageController.jumpToPage(i),
              ),
            ),
          )
      ),
    );
  }
}
