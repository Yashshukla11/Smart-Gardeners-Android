import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sg_android/controllers/menu.dart'; // Import the Menu widget from its file location
import 'package:sg_android/utils/constants.dart';
import 'package:sg_android/model/product.dart';
import 'package:sg_android/model/product_purchased.dart'; // Import ProductPurchased class

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> purchasedProducts =
    ProductPurchased().getPurchasedProducts().cast<String>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery
              .of(context)
              .padding
              .top),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title:
            const Text('Dashboard', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
      ),
      drawer: Menu(
        onMenuItemSelected: (String title) {
          // Handle menu item selection here if needed
          if (kDebugMode) {
            print('Selected menu item: $title');
          }
          // Close the drawer after selecting an item
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff12c2e9),
                      Color(0xffc471ed),
                      Color(0xfff64f59)
                    ],
                    stops: [0, 0.5, 1],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
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
                            color: Color(0xffc471ed),
                            spreadRadius: 1,
                            blurRadius: 40,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Text('12',
                          style: TextStyle(
                              color: Color(0xFFAEFFAE), fontSize: 50)),
                    ),
                    const Text('Plants to the Protect Future',
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(
                      width: 250,
                      child: Divider(color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
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
                                      color: Colors.white, fontSize: 15)),
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
            // Display purchased items
            Column(
              children: purchasedProducts.map((title) {
                // Assuming 'title' is the identifier for products
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.orange,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.blue,
                            // Placeholder color
                            // Assuming there's no image data available
                            // Replace this with actual image widget if available
                            child: Text(title),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
