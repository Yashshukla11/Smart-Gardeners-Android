import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sg_android/controllers/home_screen_controller.dart';
import 'package:sg_android/screens/home_screen/components/cart_details_view.dart';
import 'package:sg_android/screens/home_screen/components/cart_short_view.dart';
import 'package:sg_android/utils/constants.dart';
import 'package:sg_android/screens/home_screen/components/navbar.dart'; // Import the CustomNavBar widget

import '../../controllers/menu.dart';
import '../../model/product.dart';
import 'components/product_card.dart';
import 'deatils/details.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = HomeController();

  HomeScreen({super.key});

  static const Duration panelTransitionDuration = Duration(milliseconds: 500);

  static const double headerHeight = 80.0; // Example height for the header
  static const double cartBarHeight = 80.0;

  get panelTransition =>
      panelTransitionDuration; // Example height for the cart bar

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller.changeHomeState(HomeState.normal);
    }
  }

  void _openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void _handleMenuItemSelected(String menuItem) {
    // Implement the functionality for handling the selected menu item here
    if (kDebugMode) {
      print('Selected menu item: $menuItem');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: const Color(0xFFEAEAEA),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return LayoutBuilder(
                builder: (context, BoxConstraints constraints) {
                  return Stack(
                    children: [
                      // Products Grid
                      AnimatedPositioned(
                        duration: panelTransition,
                        top: controller.homeState == HomeState.normal
                            ? headerHeight
                            : -(constraints.maxHeight -
                                cartBarHeight * 2 -
                                headerHeight),
                        left: 0,
                        right: 0,
                        height: constraints.maxHeight -
                            headerHeight -
                            cartBarHeight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child: GridView.builder(
                            padding: const EdgeInsets.all(kDefaultPadding / 8),
                            itemCount: demoProducts.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.58,
                              crossAxisSpacing: kDefaultPadding / 2,
                              mainAxisSpacing: kDefaultPadding / 2,
                            ),
                            itemBuilder: (context, index) => ProductCard(
                              product: demoProducts[index],
                              press: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    reverseTransitionDuration:
                                        const Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        FadeTransition(
                                      opacity: animation,
                                      child: DetailsScreen(
                                        product: demoProducts[index],
                                        onProductAdd: () {
                                          controller.addProductToCart(
                                              demoProducts[index]);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      // CustomNavBar - Replace AppBar with CustomNavBar
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: CustomNavBar(
                          onMenuPressed: () {
                            _openDrawer(
                                context); // Implement your menu button action here
                          },
                          onNotificationPressed: () {
                            // Implement your notification button action here
                          },
                        ),
                      ),
                      // Card Panel
                      AnimatedPositioned(
                        duration: panelTransition,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: controller.homeState == HomeState.normal
                            ? cartBarHeight
                            : (constraints.maxHeight - cartBarHeight),
                        child: GestureDetector(
                          onVerticalDragUpdate: _onVerticalGesture,
                          child: Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border.fromBorderSide(
                                  BorderSide(color: Color(0xFF66BB69))),
                            ),
                            alignment: Alignment.topLeft,
                            child: AnimatedSwitcher(
                              duration: panelTransition,
                              child: controller.homeState == HomeState.normal
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: defaultPadding / 2),
                                      child: CartShortView(
                                        controller: controller,
                                        cartColor: Colors
                                            .white, // Change cart color to white
                                      ),
                                    )
                                  : CartDetailsView(controller: controller),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
      drawer: Menu(
        onMenuItemSelected: _handleMenuItemSelected,
      ),
    );
  }
}
