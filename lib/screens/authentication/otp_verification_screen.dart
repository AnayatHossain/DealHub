import 'package:deal_hub/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/gradient_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final int otpLength = 6;
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];

  int _resendTimer = 30;
  bool _canRecend = false;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < otpLength; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
          _startResendTimer();
        } else {
          _canRecend = true;
        }
      });
    });
  }

  //here otp verification will be implemented

  void _verifyOtp() {
    String otp = _controllers.map((controller) => controller.text).join();
    if (otp.length == otpLength) {
      setState(() => _isVerifying = true);
      Future.delayed(
        Duration(seconds: 2),
            () {
          if (!mounted) return;
        },
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verify Email",
                style: Theme
                    .of(context)
                    .textTheme
                    .displayLarge,
              ),
              SizedBox(height: 8),
              Text(
                "Enter the OTP sent to your email",
                style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
              ),
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  otpLength,
                      (index) =>
                      SizedBox(
                        width: 50,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppTheme.textSecondary.withOpacity(0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppTheme.primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (index < otpLength - 1) {
                                _focusNodes[index + 1].requestFocus();
                              } else {
                                _focusNodes[index].unfocus();
                                _verifyOtp();
                              }
                            } else if (index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive the code?",
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 4),
                    TextButton(
                      onPressed: _canRecend ? () {
                        setState(() {
                          _canRecend = false;
                          _resendTimer = 30;
                        });
                        _startResendTimer();
                      } : null,
                      child: Text(
                        _canRecend ? "Resend Code" : " Resend Code in $_resendTimer sec",
                        style: TextStyle(
                          color: _canRecend
                              ? AppTheme.primaryColor
                              : AppTheme.textSecondary,
                        ),
                      ),

                    )

                  ],
                ),
              ),
              SizedBox(height: 8),
              GradientButton(
                text: _isVerifying ? "Verifying..." : "Verify",
                onPressed: () {
                  if (!_isVerifying) {
                    _verifyOtp();
                  }
                },
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
