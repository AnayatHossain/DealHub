import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar for the header
          SliverAppBar(
            pinned: true,
            foregroundColor: Colors.white,
            expandedHeight: 100,
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
                  'About DealHub',
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

          // SliverList for the content
          SliverList(
            delegate: SliverChildListDelegate([
              // Welcome Section
              _buildWelcomeSection(context),

              // About DealHub Section
              _buildSection(
                context,
                title: 'About DealHub',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'DealHub is a social shopping platform that brings people together to unlock group-buying discounts. Shop smarter, save more, and enjoy exclusive deals with your friends and community!',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              // Developer Info Section
              _buildSection(
                context,
                title: 'Meet the Developer',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Developer Image (Square)
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage('assets/images/profile.JPG'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),

                        // Developer Information
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Anayat Hossain',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Tooltip(
                                    message: 'Verified account',
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.verified,
                                        color: AppTheme.success,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 4),
                              Text(
                                'B.Sc. Engg. in CSE at BUBT',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Fullstack Flutter App Developer',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Founder & CEO of DigiDev Solution',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              // Social Media Links (Animated)
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  _buildAnimatedSocialMediaIcon(
                                    context,
                                    icon: Icons.facebook,
                                    onTap: () {
                                      // Handle Facebook link
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Follow us on Facebook!'),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  _buildAnimatedSocialMediaIcon(
                                    context,
                                    icon: Icons.work,
                                    onTap: () {
                                      // Handle LinkedIn link
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Connect with us on LinkedIn!'),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  _buildAnimatedSocialMediaIcon(
                                    context,
                                    icon: Icons.code,
                                    onTap: () {
                                      // Handle GitHub link
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Check out our GitHub repository!'),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  _buildAnimatedSocialMediaIcon(
                                    context,
                                    icon: Icons.email,
                                    onTap: () {
                                      // Handle Email link
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Email us at support@dealhub.com!'),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  _buildAnimatedSocialMediaIcon(
                                    context,
                                    icon: Icons.link,
                                    onTap: () {
                                      // Handle Website link
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Visit our website!'),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // About DigiDev Solutions Section
              _buildSection(
                context,
                title: 'About DigiDev Solutions',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'DigiDev Solutions is a software development company specializing in mobile and web applications. We provide innovative solutions to help businesses grow and succeed in the digital world. Our team of experts is dedicated to delivering high-quality products and services.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              // Contact Support Section
              _buildSection(
                context,
                title: 'Contact Support',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          'If you have any questions or need assistance, please reach out to our support team:',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          leading: Icon(Icons.email, color: AppTheme.primaryColor),
                          title: Text(
                            'Email: support@dealhub.com',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          onTap: () {
                            // Handle email tap
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Email us at support@dealhub.com!'),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.phone, color: AppTheme.primaryColor),
                          title: Text(
                            'Phone: +880 1234 567890',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          onTap: () {
                            // Handle phone tap
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Call us at +880 1234 567890!'),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.location_on, color: AppTheme.primaryColor),
                          title: Text(
                            'Address: Dhaka, Bangladesh',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          onTap: () {
                            // Handle address tap
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Visit us in Dhaka, Bangladesh!'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  // Build Welcome Section
  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Welcome to DealHub',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'A social shopping platform with group-buying discounts.',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Build a section with a title and children
  Widget _buildSection(BuildContext context, {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  // Build an animated social media icon
  Widget _buildAnimatedSocialMediaIcon(BuildContext context, {required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}