import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/FirebaseLogic/GoogleSigninProvider.dart';
import 'package:dry_shades/UI/Authentication-Screen/WelcomeScreen.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/BottomBar.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:dry_shades/UI/Drawer_Screen/AboutUs.dart';
import 'package:dry_shades/UI/Drawer_Screen/ContactWithUs.dart';
import 'package:dry_shades/UI/Drawer_Screen/Home%20Service/Packers&Movers.dart';
import 'package:dry_shades/UI/Drawer_Screen/Settings.dart';
import 'package:dry_shades/UI/Main_Screen/HomeScreen/HomeScreen.dart';
import 'package:dry_shades/UI/Main_Screen/Notifications.dart';
import 'package:dry_shades/UI/Main_Screen/Profile_Screen/Profile.dart';
import 'package:dry_shades/UI/Main_Screen/ShortList.dart';
import 'package:dry_shades/UI/Others_Screen/CreateAdvertisement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//rezu 01

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  _ScreensState createState() => _ScreensState();
}

class CardItem {
  final String id;
  final String urlImage;
  final String title;

  CardItem({
    required this.id,
    required this.urlImage,
    required this.title,
  });
}

class _ScreensState extends State<Screens> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final storage = new FlutterSecureStorage();

  var name;
  var email;
  var imageUrl;
  bool _PlanExpanded = false;
  bool _ServiceExpanded = false;
  bool _SettingExpanded = false;
  int index = 0;
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;

  final Screens = [
    HomeScreen(),
    Notifications(),
    ShortList(),
    Profile(),
  ];



  // void getData() async{
  //   var collection = await FirebaseFirestore.instance
  //       .collection("UserData")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //
  //   setState (() {
  //     name = collection.data()!["FullName"];
  //     email = collection.data()!["Email"];
  //     imageUrl = collection.data()!["ImageUrl"];
  //   });
  // }

  // void getData() async{
  //   User? user = FirebaseAuth.instance.currentUser;
  //   var collection =FirebaseFirestore.instance.collection("UserData").doc(user!.uid).get();
  //   Map<String, dynamic> userData = collection as Map<String, dynamic>;
  //
  //   setState (() {
  //     name = userData["FullName"];
  //     email = userData["Email"];
  //     imageUrl = userData["ImageUrl"];
  //   }
  //   );
  // }
  //
  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  drawerScreen(data){
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.only(
            left: 10.w,
          ),
          children: [
            buildHeader(
              name: data["FullName"],
              email: data["Email"],
              path: data["ImageUrl"],
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                left: 10.w,
                right: 16.w,
              ),
              child: Column(
                children: [
                  //const SizedBox(height: 12),
                  buildSearchField(),
                  SizedBox(height: 16.h),
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home_outlined,
                    onClicked: () => Navigator.of(context).push(_buildScreen()),
                  ),
                  buildMenuItem(
                    text: 'Create Advertisement',
                    icon: Icons.post_add_outlined,
                    onClicked: () => Navigator.of(context).push(_createAdvertisement()),
                  ),
                  ExpansionPanelList(
                    elevation: 0.0,
                    animationDuration: Duration(milliseconds: 1000),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            selectedTileColor: Colors.white,
                            selected: true,
                            title: Text('Residential Plans', style: TextStyle(color: Colors.black, fontSize: 17.sp),),
                            leading: Icon(Icons.apartment_outlined, color: Colors.black,),
                            //onTap: () => selectedItem(context, 4),
                          );
                        },
                        body: Column(
                          children: [
                            ListTile(
                              title: Text('For Owners/Seller',style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.only(
                                left: 40.w,
                              ),
                              leading: Icon(Icons.person_outline, color: Colors.black,),
                            ),
                            ListTile(
                              title: Text('For Renter/Buyer',style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.only(
                                left: 40.w,
                              ),
                              leading: Icon(Icons.person, color: Colors.black,),
                            ),
                          ],
                        ),
                        isExpanded: _PlanExpanded,
                        canTapOnHeader: true,
                      ),
                    ],
                    dividerColor: Colors.black,
                    expandedHeaderPadding: EdgeInsets.only(
                      top: 0.h,
                      bottom: 0.h,
                    ),
                    expansionCallback: (panelIndex, isExpanded) {
                      _PlanExpanded = !_PlanExpanded;
                      setState(() {
                      });
                    },
                  ),
                  ExpansionPanelList(
                    elevation: 0.0,
                    animationDuration: Duration(milliseconds: 1000),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            selectedTileColor: Colors.white,
                            selected: true,
                            title: Text('Home Service', style: TextStyle(color: Colors.black, fontSize: 17.sp),),
                            leading: Icon(Icons.home_repair_service_outlined, color: Colors.black,),
                            //onTap: () => selectedItem(context, 5),
                          );
                        },
                        body: Column(
                          children: [
                            ListTile(
                              title: Text('Packers & Movers',style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.only(
                                left: 40.w,
                              ),
                              leading: Icon(Icons.airport_shuttle_outlined, color: Colors.black,),
                              onTap: (){
                                Navigator.of(context).push(_packersMovers());
                              },
                            ),
                            ListTile(
                              title: Text('Painting',style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.only(
                                left: 40.w,
                              ),
                              leading: Icon(Icons.format_paint_outlined, color: Colors.black,),
                              onTap: (){
                                Navigator.of(context).push(_packersMovers());
                              },
                            ),
                            ListTile(
                              title: Text('Cleaning',style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.only(
                                left: 40.w,
                              ),
                              leading: Icon(Icons.cleaning_services_outlined, color: Colors.black,),
                              onTap: (){
                                Navigator.of(context).push(_packersMovers());
                              },
                            ),
                            ListTile(
                              title: Text('Interior',style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.only(
                                left: 40.w,
                              ),
                              leading: Icon(Icons.bedroom_parent_outlined, color: Colors.black,),
                              onTap: (){
                                Navigator.of(context).push(_packersMovers());
                              },
                            ),
                            ListTile(
                              title: Text('Furniture',style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.only(
                                left: 40.w,
                              ),
                              leading: Icon(Icons.chair_outlined, color: Colors.black,),
                              onTap: (){
                                Navigator.of(context).push(_packersMovers());
                              },
                            ),
                          ],
                        ),
                        isExpanded: _ServiceExpanded,
                        canTapOnHeader: true,
                      ),
                    ],
                    dividerColor: Colors.black,
                    expandedHeaderPadding: EdgeInsets.only(
                      top: 0.h,
                      bottom: 0.h,
                    ),
                    expansionCallback: (panelIndex, isExpanded) {
                      _ServiceExpanded = !_ServiceExpanded;
                      setState(() {
                      });
                    },
                  ),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings_outlined,
                    onClicked: () => Navigator.of(context).push(_settings()),
                  ),
                  //const SizedBox(height: 16),
                  ExpansionPanelList(
                    elevation: 0.0,
                    animationDuration: Duration(milliseconds: 1000),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            selectedTileColor: Colors.white,
                            selected: true,
                            title: Text('Help & Support', style: TextStyle(color: Colors.black, fontSize: 17.sp),),
                            leading: Icon(Icons.help_outline, color: Colors.black,),
                            //onTap: () => selectedItem(context, 7),
                          );
                        },
                        body: Column(
                          children: [
                            ListTile(
                              title: Text('Privacy Policy',style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                              leading: Icon(Icons.privacy_tip_outlined, color: Colors.black),
                              contentPadding: EdgeInsets.only(
                                left: 40.w,
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.feedback_outlined, color: Colors.black),
                              title: Text('Feedback',style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.only(
                                left: 40.w,
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.info_outline, color: Colors.black),
                              title: Text('About Us',style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.only(
                                left: 40.w,
                              ),
                              onTap: () => Navigator.of(context).push(_aboutUs()),
                            ),
                            ListTile(
                              leading: Icon(Icons.question_answer_outlined, color: Colors.black),
                              title: Text('Contact with Us',style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.only(
                                left: 40.w,
                              ),
                              onTap: () => Navigator.of(context).push(_contactScreen()),
                            ),
                          ],
                        ),
                        isExpanded: _SettingExpanded,
                        canTapOnHeader: true,
                      ),
                    ],
                    dividerColor: Colors.black,
                    expandedHeaderPadding: EdgeInsets.only(
                      top: 0.h,
                      bottom: 0.h,
                    ),
                    expansionCallback: (panelIndex, isExpanded) {
                      _SettingExpanded = !_SettingExpanded;
                      setState(() {
                      });
                    },
                  ),
                  buildMenuItem(
                      text: 'Log Out',
                      icon: Icons.logout_outlined,
                      onClicked: () async {
                        await storage.delete(key: "uid");
                        await FirebaseAuth.instance.signOut().then((value) =>
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                                    (route) => false));
                        final gProvider =
                        Provider.of<GoogleSignInProvider>(context, listen: false);
                        gProvider.logOut();
                      }
                    // onClicked: () => selectedItem(context, 8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("UserData")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return Container(
              color: kBackGroundColor,
              child: Center(
                  child: CircularProgressIndicator(color: kMainColor)),
            );
          }
          return drawerScreen(data);
        },
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackGroundColor,
      // you can use silverAppBar with custom scroll view
        appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff7f6fb),
        iconTheme: IconThemeData(
          color: kMainColor,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.post_add_outlined,
              color: kMainColor,
            ),
            onPressed: () {},
          )
        ],
        title: Text("DryShades",
          style: GoogleFonts.courgette( //zenKurenaido
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.none,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: kMainColor,
          ),
        ),
      ),
      // bottomNavigationBar: NavigationBarTheme(
      //   data: NavigationBarThemeData(
      //     indicatorColor: Colors.grey.shade400,
      //     labelTextStyle: MaterialStateProperty.all(
      //       TextStyle(
      //         fontSize: 14.sp,
      //         fontWeight: FontWeight.w700
      //       ),
      //     ),
      //   ),
      //   child: NavigationBar(
      //     height: 65.h,
      //       backgroundColor: Color(0xfff7f6fb),
      //       //backgroundColor: Colors.white,
      //       animationDuration: Duration(seconds: 2),
      //       //labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      //       labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      //       selectedIndex: index,
      //       onDestinationSelected: (index) =>
      //       setState(() => this.index = index),
      //       destinations: [
      //         NavigationDestination(
      //             icon: Icon(Icons.home_outlined),
      //             selectedIcon: Icon(Icons.home),
      //             label: 'Home',
      //         ),
      //         NavigationDestination(
      //           icon: Icon(Icons.favorite_outline),
      //           selectedIcon: Icon(Icons.favorite),
      //           label: 'Shortlist',
      //         ),
      //         NavigationDestination(
      //             icon: Icon(Icons.notifications_outlined),
      //             selectedIcon: Icon(Icons.notifications),
      //             label: 'Notifications',
      //         ),
      //         NavigationDestination(
      //             icon: Icon(Icons.account_circle_outlined),
      //             selectedIcon: Icon(Icons.account_circle),
      //             label: 'Profile',
      //         ),
      //       ]
      //   ),
      // ),
      // body: Screens[index],
      body: ScreenBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
  Widget ScreenBody() {
    List<Widget> pages = [
      HomeScreen(),
      Notifications(),
      ShortList(),
      Profile(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  Widget _buildBottomNavigationBar(){
    return CustomAnimatedBottomBar(
      containerHeight: 60.h,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24.r,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          activeColor: kMainColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.notifications),
          title: Text('Notifications'),
          activeColor: kMainColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.favorite),
          title: Text(
            'Shortlist',
          ),
          activeColor: kMainColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('Profile'),
          activeColor: kMainColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildHeader({path, name, email}) =>
      InkWell(
        child: Container(
          padding: EdgeInsets.only(
            top: 50.h,
            bottom: 20.h,
          ),
          child: Column(
            children: [
              // Container(
              //   width: 130.w,
              //   height: 130.h,
              //   decoration: BoxDecoration(
              //     border: Border.all(width: 4.w, color: Colors.white),
              //     boxShadow: [
              //       BoxShadow(
              //           spreadRadius: 2.r,
              //           blurRadius: 10.r,
              //           color: Colors.black.withOpacity(0.1)
              //       )
              //     ],
              //     shape: BoxShape.circle,
              //     image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: NetworkImage(path)),
              //   ),
              // ),
              Container(
                width: 130.w,
                height: 130.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 4.w, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2.r,
                        blurRadius: 10.r,
                        color: Colors.black.withOpacity(0.1))
                  ],
                  shape: BoxShape.circle,
                  // image: DecorationImage(
                  //     fit: BoxFit.cover,
                  //     image: AssetImage("assets/images/IMG20220215145450.jpg"),
                  // ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Image.network(
                    path,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                name,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.black),
              ),
              SizedBox(height: 4.h),
              Text(
                email,
                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w400),
                ),
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.black;
    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.black12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: Colors.lightBlue.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

   buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.black;
    final hoverColor = Colors.red;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.r),
        bottomLeft: Radius.circular(32.r),
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(text, style: TextStyle(color: color, fontSize: 17.sp)),
        hoverColor: hoverColor,
        // selectedColor: Colors.black12,
        selected: true,
        onTap: onClicked,
      ),
    );
  }
}


PageRouteBuilder _contactScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return ContactScreen();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
  );
}
PageRouteBuilder _packersMovers() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return PackersMovers();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
  );
}
PageRouteBuilder _aboutUs() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return AboutUs();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
  );
}
PageRouteBuilder _settings() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return SettingsScreen();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
  );
}
PageRouteBuilder _buildScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Screens();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
  );
}
PageRouteBuilder _notificationScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Notifications();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
  );
}
PageRouteBuilder _createAdvertisement() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return CreateAdvertisement();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
  );
}
PageRouteBuilder _shortlistScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return ShortList();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
  );
}



