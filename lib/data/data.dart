import 'package:flutter/material.dart';

import '../screens/onboarding_screen.dart';
import '../theme/theme.dart';

final images = [
  "assets/images/black t-shirt.png",
  "assets/images/red t-shirt.png",
  "assets/images/cotton pant 1.png",
  "assets/images/grey cotton pant 2.png",
];

final sliderImages = [
  "assets/images/slider_1.png",
  "assets/images/slider_2.png",
  "assets/images/slider_3.png",
  "assets/images/slider_4.png",

];

final categories = [
  {'icon': Icons.laptop_mac_outlined, 'name': 'Electronics'},
  {'icon': Icons.chair_outlined, 'name': 'Furniture'},
  {'icon': Icons.checkroom_outlined, 'name': 'Fashion'},
  {'icon': Icons.sports_basketball_outlined, 'name': 'Sports'},
  {'icon': Icons.phone_android_outlined, 'name': 'Phone'},
  {'icon': Icons.watch_outlined, 'name': 'Accessorise'},
];


final List<Map<String, dynamic>> notifications = [
  {
    'type': 'order',
    'title': 'New Order Received',
    'message': 'Your order #12345 has been successfully placed.',
    'time': '2 hours ago',
    'read': false,
    'icon': Icons.local_shipping_outlined,
    'iconColor': AppTheme.success,
  },
  {
    'type': 'promo',
    'title': 'Special Offer',
    'message': 'Get 50% off on all electronics this weekend!',
    'time': '1 hours ago',
    'read': false,
    'icon': Icons.local_offer_outlined,
    'iconColor': AppTheme.primaryColor,
  },
  {
    'type': 'payment',
    'title': 'Payment Successful',
    'message': 'Payment of \$50.00 has been successfully completed.',
    'time': '3 hours ago',
    'read': false,
    'icon': Icons.payment_outlined,
    'iconColor': AppTheme.success,
  },
  {
    'type': 'alert',
    'title': 'Priority Drop Alert',
    'message': 'Price of your item has dropped below our target',
    'time': '5 hours ago',
    'read': true,
    'icon': Icons.notifications_outlined,
    'iconColor': AppTheme.warning,
  },
  {
    'type': 'system',
    'title': 'System Update',
    'message': 'Your account settings have been updated.',
    'time': '1 day ago',
    'read': true,
    'icon': Icons.system_update_outlined,
    'iconColor': AppTheme.secondaryColor,
  },
  {
    'type': 'order',
    'title': 'New Order Received',
    'message': 'Your order #12345 has been successfully placed.',
    'time': '2 hours ago',
    'read': false,
    'icon': Icons.local_shipping_outlined,
    'iconColor': AppTheme.success,
  },
  {
    'type': 'promo',
    'title': 'Special Offer',
    'message': 'Get 50% off on all electronics this weekend!',
    'time': '1 hours ago',
    'read': false,
    'icon': Icons.local_offer_outlined,
    'iconColor': AppTheme.primaryColor,
  },
  {
    'type': 'payment',
    'title': 'Payment Successful',
    'message': 'Payment of \$50.00 has been successfully completed.',
    'time': '3 hours ago',
    'read': false,
    'icon': Icons.payment_outlined,
    'iconColor': AppTheme.success,
  },
  {
    'type': 'alert',
    'title': 'Priority Drop Alert',
    'message': 'Price of your item has dropped below our target',
    'time': '5 hours ago',
    'read': true,
    'icon': Icons.notifications_outlined,
    'iconColor': AppTheme.warning,
  },
  {
    'type': 'system',
    'title': 'System Update',
    'message': 'Your account settings have been updated.',
    'time': '1 day ago',
    'read': true,
    'icon': Icons.system_update_outlined,
    'iconColor': AppTheme.secondaryColor,
  },

];

final List<Map<String, String>> languages = [
  {'code': 'en', 'name': 'English', 'nativeName': 'English'},
  {'code': 'bn', 'name': 'Bangle', 'nativeName': 'Bangle'},
  {'code': 'es', 'name': 'Spanish', 'nativeName': 'Espalier'},
  {'code': 'fr', 'name': 'French', 'nativeName': 'Français'},
  {'code': 'de', 'name': 'German', 'nativeName': 'Deutsch'},
  {'code': 'it', 'name': 'Italian', 'nativeName': 'Italiano'},
];

final List<Map<String, dynamic>> messages = [
  {
    'message': "Asslamu-Alaikum, there!",
    'isMe': false,
    'time': "2:30 PM",
    'status': "read",
  },
  {
    'message': "Wolaikum-Assalam, How can I help you today?",
    'isMe': true,
    'time': "2:31 PM",
    'status': "read",
  },
  {
    'message': "I have a question about my recent order",
    'isMe': false,
    'time': "2:32 PM",
    'status': "read",
  },
  {
    'message':
    "Of course! I\'d be happy to help. Could you please provide Order ID.",
    'isMe': true,
    'time': "2:30 PM",
    'status': "read",
  },
];


final List<Map<String, dynamic>> chatList = [
  {
    'name': 'Anayat Hossain',
    'lastMessage': 'Asslamu-Alaikum, there!',
    'time': '2:30 PM',
    'unreadCount': 2,
    'avatar': 'assets/images/profile.JPG',
    'isOnline': true,
  },
  {
    'name': 'Shajuddin',
    'lastMessage': 'The package has been delivered',
    'time': '1:45 PM',
    'unreadCount': 0,
    'avatar': 'assets/images/profile.JPG',
    'isOnline': false,
  },
  {
    'name': 'Hasan Al Banna',
    'lastMessage': 'Provide more details for the order',
    'time': '3:30 PM',
    'unreadCount': 3,
    'avatar': 'assets/images/profile.JPG',
    'isOnline': true,
  },
  {
    'name': 'Anayat Hossain',
    'lastMessage': 'Asslamu-Alaikum, there!',
    'time': '2:30 PM',
    'unreadCount': 2,
    'avatar': 'assets/images/profile.JPG',
    'isOnline': true,
  },
  {
    'name': 'Shajuddin',
    'lastMessage': 'The package has been delivered',
    'time': '1:45 PM',
    'unreadCount': 0,
    'avatar': 'assets/images/profile.JPG',
    'isOnline': false,
  },
  {
    'name': 'Hasan Al Banna',
    'lastMessage': 'Provide more details for the order',
    'time': '3:30 PM',
    'unreadCount': 3,
    'avatar': 'assets/images/profile.JPG',
    'isOnline': true,
  },
  {
    'name': 'Anayat Hossain',
    'lastMessage': 'Asslamu-Alaikum, there!',
    'time': '2:30 PM',
    'unreadCount': 2,
    'avatar': 'assets/images/profile.JPG',
    'isOnline': true,
  },
  {
    'name': 'Shajuddin',
    'lastMessage': 'The package has been delivered',
    'time': '1:45 PM',
    'unreadCount': 0,
    'avatar': 'assets/images/profile.JPG',
    'isOnline': false,
  },
  {
    'name': 'Hasan Al Banna',
    'lastMessage': 'Provide more details for the order',
    'time': '3:30 PM',
    'unreadCount': 3,
    'avatar': 'assets/images/profile.JPG',
    'isOnline': true,
  },
];

final List<OnboardingData> pages = [
  OnboardingData(
    title: "Discover Latest Deals",
    description: "Get access to exclusive discounts and trending deals. "
        "Save more with our group-buying offers and special promotions!",
    image: "assets/images/onboarding1.png",
  ),
  OnboardingData(
    title: "Easy Shopping Experience",
    description: "Enjoy a seamless and hassle-free shopping journey. "
        "Browse, compare, and purchase your favorite products effortlessly!",
    image: "assets/images/onboarding2.png",
  ),
  OnboardingData(
    title: "Secure Payments",
    description:
    "Shop with confidence using our secure and reliable payment system. "
        "Your transactions are encrypted and protected at all times!",
    image: "assets/images/onboarding3.png",
  ),
];

final sortOptions = [
  'Popular',
  'Newest',
  'Price: Low to High',
  'Price: High to Low',
  'Rating'
];
final activeFilters = ['\$0 - \$1000', 'Brand: A', 'Size: M', 'In Stock'];
final brands = [
  'Brand A',
  'Brand B',
  'Brand C',
  'Brand D',
  'Brand E',
  'Brand F',
  'Brand G',
  'Brand H',
  'Brand I',
  'Brand J',
];
final sizes = ['S', 'M', 'L', 'XL', 'XXL'];
final colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.pink,
  Colors.brown,
  Colors.grey,
  Colors.black
];
