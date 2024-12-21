import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/screens/auth/components/custom_title_and_suptitle.dart';
import 'package:cast_in/ui/components/main_button.dart';
import 'package:cast_in/ui/screens/auth/verification/verification_controller.dart';
import 'package:cast_in/utils/app_router.dart';

import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinput/pinput.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});

  final VerificationController controller = Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cast In',
        isBackBtnEnabled: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    CustomTitleAndSuptitle(
                        title: 'Verification', suptitle: 'Please enter 4 digit code sent to your number'),
                    const SizedBox(height: 40),
                    Center(
                      child: Pinput(
                        length: 4,
                        controller: controller.pinController,
                        autofocus: true,
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        onCompleted: (value) {},
                        onSubmitted: (value) {},
                        inputFormatters: [],
                        validator: (value) {
                          return null;
                        },
                        errorTextStyle: const TextStyle(height: 0),
                        defaultPinTheme: PinTheme(
                          width: 70,
                          height: 70,
                          textStyle: TextStyle(
                            color: AppStyle.primaryTextColor,
                            fontSize: 18,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: AppStyle.secondaryBgColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Obx(
                      () => Center(
                        child: Text(
                          controller.timer.value,
                          style: AppStyle.bodyTextStyle2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: controller.resendCode,
                      child: Center(
                        child: Text(
                          'Resend code',
                          style: AppStyle.subTitleStyle2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MainButton(
                onPressed: () {
                  Get.toNamed(AppRouter.PROFESSION);
                },
                title: 'Submit',
                fullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
