import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:sg_android/controllers/menu.dart';
import 'package:sg_android/utils/constants.dart';
import 'package:sg_android/controllers/home_screen_controller.dart';
import 'package:sg_android/model/product.dart';
import 'package:sg_android/screens/user_dashboard_screen/components/footer.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({Key? key, required List purchasedItems})
      : super(key: key);

  get progress => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('Dashboard',
                  style: TextStyle(color: Color(0xFF66BB69))),
              centerTitle: true,
              iconTheme: const IconThemeData(
                color: Color(0xFF66BB69),
              ),
            ),
          ),
        ),
      ),
      drawer: Menu(
        onMenuItemSelected: (String title) {
          if (kDebugMode) {
            print('Selected menu item: $title');
          }
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Consumer<HomeController>(
              builder: (context, homeController, _) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black, // Border color
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.lightGreen,
                              spreadRadius: 5,
                              blurRadius: 50,
                              offset: Offset(0, 3),
                            ),
                          ],
                          gradient: const LinearGradient(
                            colors: [Color(0xffafff85), Color(0xfff9e271)],
                            stops: [0, 1],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        width: double.infinity,
                        height: 210,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: const Text('You have Contributed',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xffafff85),
                                    spreadRadius: 1,
                                    blurRadius: 40,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Text('🪴12🪴',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 50)),
                            ),
                            const Text('Plants to Protect Future',
                                style: TextStyle(color: Colors.black)),
                            const SizedBox(
                              width: 250,
                              child: Divider(color: Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.0,
                                          right: 20.0,
                                          top: 10.0,
                                          bottom: 10.0),
                                      child: Text('Plant More',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  const Icon(Icons.share, color: Colors.black),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '🏡Progress Report 🏡',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF66BB69)),
                        ),
                        const SizedBox(
                          width: 150,
                          child: Divider(
                            color: kPrimaryColor,
                          ),
                        ),
                        // Check if purchasedItems list is empty
                        homeController.purchasedItems.isEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 100),
                                height: 400,
                                child: const Text(
                                  'No items purchased yet',
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            : Column(
                                children: homeController.purchasedItems
                                    .map((itemTitle) {
                                  // Find the corresponding product
                                  Product product = demoProducts.firstWhere(
                                      (product) => product.title == itemTitle);
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0,
                                        bottom: 15,
                                        left: 8.0,
                                        right: 8.0),
                                    child: SizedBox(
                                      height: 150,
                                      child: Container(
                                        width: double.infinity,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.black, // Border color
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.lightGreen,
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: kPrimaryColor,
                                                    width:
                                                        2.0, // Increase the width for a bolder border
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: 70,
                                                    height: 70,
                                                    child: Image(
                                                      image: NetworkImage(
                                                          product.image),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              Container(
                                                width: 120,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.title,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      product.subcategory,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Color(0xffcdffb3),
                                                          Color(0xffffea80)
                                                        ],
                                                        stops: [0, 1],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                        "Map View",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                        const SizedBox(
                          height: 210,
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10, // Adjust the distance from the bottom as needed
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomFooter(),
            ),
          ),
        ],
      ),
    );
  }
}
