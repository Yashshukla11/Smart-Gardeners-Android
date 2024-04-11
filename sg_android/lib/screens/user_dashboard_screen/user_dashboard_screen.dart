import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:sg_android/controllers/menu.dart';
import 'package:sg_android/utils/constants.dart';
import 'package:sg_android/controllers/home_screen_controller.dart';
import 'package:sg_android/screens/user_dashboard_screen/components/footer.dart';

import '../../services/api_service.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({Key? key, required purchasedItems})
      : super(key: key);

  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  late List<bool> isPlantedList;

  @override
  void initState() {
    super.initState();
    isPlantedList = List.filled(
        10, true); // Assuming 10 items, change it according to your data
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<HomeController>(context, listen: false)
          .getpurchasedProductDetails();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).padding.bottom),
          decoration: const BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Center(
            child: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('Dashboard',
                  style: TextStyle(color: Colors.white)),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
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
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff43cea2),
                              spreadRadius: 5,
                              blurRadius: 50,
                              offset: Offset(0, 3),
                            ),
                          ],
                          gradient: const LinearGradient(
                            colors: [Color(0xff43cea2), Color(0xff185a9d)],
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
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xff185a9d),
                                    spreadRadius: 1,
                                    blurRadius: 80,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Text('🪴12🪴',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 50)),
                            ),
                            const Text('Plants to Protect Future',
                                style: TextStyle(color: Colors.white)),
                            const SizedBox(
                              width: 250,
                              child: Divider(color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/home');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                          left: 20.0,
                                          right: 20.0,
                                          top: 10.0,
                                          bottom: 10.0,
                                        ),
                                        child: Text(
                                          'Plant More',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  const Icon(Icons.share, color: Colors.white),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xffde6161), Color(0xff2657eb)],
                            stops: [0, 1],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ).createShader(bounds),
                          child: const Text(
                            'Progress Report ',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .white, // This color will be covered by gradient
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 150,
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        // Check if purchasedProducts list is empty
                        homeController.purchasedProducts.isEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 100),
                                height: 400,
                                child: const Text(
                                  'Start Contributing!',
                                  style: TextStyle(
                                      fontSize: 18, color: kPrimaryColor),
                                ),
                              )
                            : Column(
                                children: List.generate(
                                  homeController.purchasedProducts.length,
                                  (index) {
                                    final purchasedProduct =
                                        homeController.purchasedProducts[index];
                                    // bool containsPlantedKey =
                                    //     purchasedProduct.plantedDate === null;
                                    var isPlanted =
                                        purchasedProduct.plantedDate != "null"
                                            ? "True"
                                            : "False";
                                    // print(isPlanted);
                                    // print(purchasedProduct.plantedDate);
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
                                                color: Colors.black, width: 1),
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
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: kPrimaryColor,
                                                      width: 2.0,
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SizedBox(
                                                      width: 70,
                                                      height: 70,
                                                      child: Image(
                                                        image: NetworkImage(
                                                            purchasedProduct
                                                                .image),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Container(
                                                  width: 120,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        purchasedProduct.title,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        purchasedProduct
                                                            .subCategory,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey),
                                                      ),
                                                      // Place the product unique id here
                                                    ],
                                                  ),
                                                ),
                                                Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (isPlanted == "True") {
                                                        // Navigate to map page
                                                        Navigator.pushNamed(
                                                            context, '/map');
                                                      } else {
                                                        // Handle starting planting
                                                        ApiService.updateCycleStage(
                                                            purchasedProduct
                                                                .id); // Call the function to update cycle stage
                                                        // Show a message indicating planting has started
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                                'Yup, you have planted!'),
                                                            duration: Duration(
                                                                seconds: 2),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          isPlanted == "True"
                                                              ? "Map"
                                                              : "Start",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        const SizedBox(height: 210)
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
            bottom: 10,
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
