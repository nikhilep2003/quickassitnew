

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quickassitnew/constans/text.dart';
import 'package:quickassitnew/services/location_provider.dart';
import 'package:quickassitnew/widgets/apptext.dart';
import 'package:quickassitnew/widgets/customcontainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg.dart';


import '../../constans/colors.dart';


class Homepage extends StatefulWidget {

  const Homepage({super.key,});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  String? _type;
  String?uid;
  String?name;
  String?email;
  String?phone;


  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _type = await _pref.getString('type');
    email= await _pref.getString('email');
    name = await _pref.getString('name');
    phone = await _pref.getString('phone');
    uid = await _pref.getString('uid');

    setState(() {});
  }
  var locationCity;
  @override
  void initState() {
    getData();


    Provider.of<LocationProvider>(context, listen: false).determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
    final themedata=Theme.of(context);

    return Consumer<LocationProvider>(
        builder: (context, locationProvider, child){
          if (locationProvider.currentLocationName != null) {
            locationCity = locationProvider.currentLocationName!.locality;
            print(locationCity);
          } else {
            locationCity = "Unknown Location";
          }
          return Container(

            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,

                          child: Consumer<LocationProvider>(
                              builder: (context, locationProvider, child) {

                                if (locationProvider.currentLocationName != null) {
                                  locationCity = locationProvider.currentLocationName!.locality;
                                  print(locationCity);
                                } else {
                                  locationCity = "Unknown Location";
                                }

                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                locationCity,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                );
                              }),
                        ),
                        InkWell(
                          onTap: (){
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) =>NotificationPage()),
                            // );

                          },
                          child: Icon(
                            Icons.notification_important,
                            color: Colors.orangeAccent,
                            size: 30,
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) =>NotificationPage()),
                              // );

                            },
                            child: CircleAvatar(

                            )
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text("Hi",style: TextStyle(fontSize: 22,color: Colors.white),),
                              SizedBox(width: 8,),
                              Text("${name.toString()}",style: TextStyle(fontSize: 26,color: Colors.white),),
                            ],
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 10,),


                    CustomContainer(
                      ontap: (){

                      },

                      height: 185,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(  color: AppColors.contColor1,

                          borderRadius: BorderRadius.circular(15)),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(data: "50% Offer on Car Washing",size: 22,color: Colors.white,),
                                AppText(data: "Keep your car shining",size: 16,color: Colors.white,)

                              ],
                            ),
                          ),
                          Expanded(child: SvgPicture.asset('assets/svg/carwash.svg'))
                        ],

                      ),
                    ),

                    SizedBox(height: 10,),
                    Text(
                      "Select Vehicle Type",
                      style: themedata.textTheme.displayMedium,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                          itemCount: serviceType.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final service=serviceType[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CustomContainer(
                                decoration: BoxDecoration(
                                    color: AppColors.contColor2,
                                    borderRadius: BorderRadius.circular(10)),
                                ontap: () {},
                                height: 150,
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      '${service['img']}',
                                      height: 80,
                                      width: 120,
                                    ),
                                    Text("${service['title']}",textAlign: TextAlign.center,)
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),


                    SizedBox(height: 10,),
                    Text(
                      "Select Vehicle Type",
                      style: themedata.textTheme.displayMedium,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                          itemCount: otherserviceType.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final service=otherserviceType[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CustomContainer(
                                decoration: BoxDecoration(
                                    color: AppColors.contColor2,
                                    borderRadius: BorderRadius.circular(10)),
                                ontap: () {},
                                height: 150,
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      '${service['img']}',
                                      height: 80,
                                      width: 120,
                                    ),
                                    Text("${service['title']}",textAlign: TextAlign.center,)
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                )
            ),
          );
        }
    );


  }
}