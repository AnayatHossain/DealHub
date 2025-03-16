import 'package:deal_hub/screens/home_screen/featured_product_section.dart';
import 'package:deal_hub/screens/home_screen/products_categories.dart';
import 'package:deal_hub/screens/home_screen/search_producrs.dart';
import 'package:deal_hub/screens/home_screen/swiper_section.dart';
import 'package:deal_hub/screens/home_screen/useer_profile_data.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'new_arivals_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppTheme.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 16),

                title: UseerProfileData(), //User Profile Data
                background: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 12),
                //Swiper Section
                SwiperSection(),
                SizedBox(height: 12),
                //Search Products
                SearchProducts(),
                //Categories
                ProductsCategories(),
                SizedBox(height: 6),
                // Featured Products
                FeaturedProductSection(),
                SizedBox(height: 8),
                //New Arrivals
                NewArrivalsSection(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
