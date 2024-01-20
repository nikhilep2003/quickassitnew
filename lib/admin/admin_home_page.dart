

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickassitnew/admin/viewall_users.dart';
import 'package:quickassitnew/common/login_page.dart';
import 'package:quickassitnew/constans/colors.dart';
import 'package:quickassitnew/widgets/customcontainer.dart';
import 'package:quickassitnew/widgets/dashboard_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  String? _type;
  String? uid;
  String? name;
  String? email;
  String? phone;

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _type = await _pref.getString('type');
    email = await _pref.getString('email');
    name = await _pref.getString('name');
    phone = await _pref.getString('phone');
    uid = await _pref.getString('uid');

    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
  final _scaffoldKey=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
     endDrawer: Drawer(
       elevation: 5.0,
       backgroundColor: AppColors.scaffoldColor,
       child: ListView(
         children: [
           DrawerHeader
             (

               decoration: BoxDecoration(

                   color: Colors.transparent),
               child: Row(
             children: [
               CircleAvatar(),
               SizedBox(width: 15,),
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                 Text("Name",style: themedata.textTheme.displaySmall,),
                 Text("jobin@gmail.com",style: themedata.textTheme.displaySmall,),
               ],),
             ],
           )),
           ListTile(
  onTap: ()async{
    SharedPreferences _pref =
        await SharedPreferences.getInstance();
    FirebaseAuth.instance.signOut().then((value) {
      _pref.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage()),
      );
    });

  },
             title: Text("Logout",style: themedata.textTheme.displaySmall,),
           )
         ],
       ),
     ),
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap:(){
                  _scaffoldKey.currentState!.openEndDrawer();
                },child: CircleAvatar()),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Admin Dashboard",
                    style: themedata.textTheme.displayMedium,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          "Hi",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${name.toString()}",
                          style: TextStyle(fontSize: 26, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
           Row(
             children: [
               Expanded(child: dashboardCountWidth(themedata: themedata)),
               SizedBox(width: 20,),
               Expanded(child: dashboardCountWidth(themedata: themedata)),
             ],
           ), 
            SizedBox(
              height: 20,
            ),
            DashboardItemWidget(
                onTap1: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllUsers()));
                },
                onTap2: () {},
                titleOne: "All users",
                titleTwo: "All Shops"),
            SizedBox(
              height: 20,
            ),
            DashboardItemWidget(
                onTap1: () {},
                onTap2: () {},
                titleOne: "All Employees",
                titleTwo: "All Services")
          ],
        ),
      ),
    );
  }
}

class dashboardCountWidth extends StatelessWidget {
  const dashboardCountWidth({
    super.key,
    required this.themedata,
  });

  final ThemeData themedata;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16.0,
      color: AppColors.scaffoldColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
      
         height: 180,
         width: 150,
         decoration: BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
             colors: [
             AppColors.scaffoldColor.withOpacity(0.2),
               AppColors.scaffoldColor
             ]
           ),
             color: AppColors.contColor6,
             borderRadius: BorderRadius.circular(10)),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Text(
               "Total", style: themedata.textTheme.displayMedium,
             ),
             SizedBox(height: 15,),
             Text(
               "150 Shops",
              style: themedata.textTheme.displayLarge,
             )
           ],
         ),
       ),
    );
  }
}
