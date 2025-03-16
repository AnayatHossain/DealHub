import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme.dart';
import '../main_screen.dart';
import 'order_tracking_screen.dart';

class MyOrderScreen extends StatelessWidget {
  MyOrderScreen({super.key});

  final orders = [
    {
      "orderId": "12345",
      "date": "March 12, 2025",
      "status": "In Transit",
      "items": ["Premium Cotton T-Shirt (2x)", "Cotton Pants (1x)"],
      "total": 184.97,
    },
    {
      "orderId": "67890",
      "date": "March 10, 2025",
      "status": "Cancelled",
      "items": ["Winter Jacket (3x)"],
      "total": 300.00,
    },
    {
      "orderId": "12345",
      "date": "March 14, 2025",
      "status": "Processing",
      "items": ["Denim Jeans (2x)", "Leather Jacket (2x)", "Belt (1x)"],
      "total": 284.97,
    },
    {
      "orderId": "12345",
      "date": "March 12, 2025",
      "status": "Delivered",
      "items": ["Premium Cotton T-Shirt (2x)", "Cotton Pants (1x)"],
      "total": 184.97,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in transit':
        return AppTheme.warning;
      case 'processing':
        return AppTheme.primaryColor;
      case 'delivered':
        return AppTheme.success;
      case 'cancelled':
        return AppTheme.error;
      default:
        return AppTheme.textSecondary;
    }
  }

  Widget _buildOrderCard({
    required String orderId,
    required String date,
    required String status,
    required double total,
    required List<String> items,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #$orderId',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(status), // Apply status color to text
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Ordered on $date',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
              SizedBox(height: 12),
              Divider(
                thickness: 2,
                color: AppTheme.primaryColor,
              ),
              SizedBox(height: 12),
              Text(
                '${items.length} ${items.length == 1 ? 'item' : 'items'}:',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                items.join(", "),
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Spacer(),
                  TextButton.icon(
                    icon: Icon(
                      Icons.local_shipping_outlined,
                      size: 18,
                    ),
                    onPressed: () {
                      Get.to(() => OrderTrackingScreen());
                    },
                    label: Text("Track Order"),
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: Colors.white,
            pinned: true,
            expandedHeight: 120,
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
                title: Text(
                  'My Order',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search Order...",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                              border: InputBorder.none,
                              icon: Icon(Icons.search,
                                  color: AppTheme.primaryColor),
                              suffixIcon: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.filter_list,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  ...orders.map((order) => _buildOrderCard(
                    orderId: order['orderId'] as String,
                    date: order['date'] as String,
                    status: order['status'] as String,
                    total: order['total'] as double,
                    items: order['items'] as List<String>,
                    onTap: () {},
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}