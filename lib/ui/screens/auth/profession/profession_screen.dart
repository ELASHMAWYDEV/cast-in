import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/screens/auth/components/custom_title_and_suptitle.dart';
import 'package:cast_in/ui/components/main_button.dart';
import 'package:cast_in/ui/screens/auth/profession/profession_controller.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfessionScreen extends StatelessWidget {
  ProfessionScreen({super.key});

  final ProfessionController controller = Get.put(ProfessionController());

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    CustomTitleAndSuptitle(title: 'Profession', suptitle: 'Please select your profession.'),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GetBuilder<ProfessionController>(builder: (controller) {
                        return Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: controller.professions.map((profession) {
                            return GestureDetector(
                              onTap: () {
                                controller.selectProfession(profession);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                    color: AppStyle.secondaryBgColor,
                                    borderRadius: BorderRadius.circular(25),
                                    border: controller.selectedProfession == profession
                                        ? Border.all(color: AppStyle.primaryColor, width: 2)
                                        : Border.all(color: Colors.transparent, width: 2)),
                                child: Text(profession, style: AppStyle.subTitleStyle1),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              MainButton(
                onPressed: () {},
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
