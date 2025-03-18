import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

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
                  'Help & Support',
                  style: TextStyle(
                    fontSize: 20,
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

              // FAQ Section
              _buildSection(
                context,
                title: 'Frequently Asked Questions',
                children: [
                  _buildFAQItem(
                    context,
                    question: 'How do I reset my password?',
                    answer:
                    'Go to the login screen and click on "Forgot Password". Follow the instructions to reset your password.',
                  ),
                  _buildFAQItem(
                    context,
                    question: 'How do I contact support?',
                    answer:
                    'You can contact support by emailing us at support@dealhub.com or using the contact form below.',
                  ),
                  _buildFAQItem(
                    context,
                    question: 'How do I update my profile?',
                    answer:
                    'Go to your profile screen and click on the edit button to update your information.',
                  ),
                ],
              ),

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
                          'If you have any questions or need assistance, please reach out to our support team.',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Your Name',
                            labelStyle: TextStyle(color: AppTheme.textSecondary),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person,color: AppTheme.primaryColor),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Your Email',
                            labelStyle: TextStyle(color: AppTheme.textSecondary),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email,color: AppTheme.primaryColor),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Your Message',
                            labelStyle: TextStyle(color: AppTheme.textSecondary),
                            hintText: 'Type your message here...',
                            hintStyle: TextStyle(color: AppTheme.textSecondary),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.message,color: AppTheme.primaryColor),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Handle send message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Your message has been sent!'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Send Message',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),

              // Quick Actions Section
              _buildSection(
                context,
                title: 'Quick Actions',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildQuickAction(
                          context,
                          icon: Icons.chat,
                          label: 'Live Chat',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Live Chat is not available yet.'),
                              ),
                            );
                          },
                        ),
                        _buildQuickAction(
                          context,
                          icon: Icons.call,
                          label: 'Call Us',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Call support at +123-456-7890.'),
                              ),
                            );
                          },
                        ),
                        _buildQuickAction(
                          context,
                          icon: Icons.email,
                          label: 'Email Us',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Email support at support@dealhub.com.'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
            ]),
          ),

        ],
      ),
    );
  }

  // Build a welcome section
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
            'Welcome to Help & Support',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'We are here to help you with any issues or questions you may have.',
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

  // Build an FAQ item
  Widget _buildFAQItem(BuildContext context, {required String question, required String answer}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ExpansionTile(
          title: Text(
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build a quick action button
  Widget _buildQuickAction(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 30,
              color: AppTheme.primaryColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}