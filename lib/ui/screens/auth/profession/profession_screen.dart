import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/common/custom_title_and_suptitle.dart';
import 'package:cast_in/ui/components/main_button.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';

class ProfessionScreen extends StatefulWidget {
  const ProfessionScreen({super.key});

  @override
  State<ProfessionScreen> createState() => _ProfessionScreenState();
}

class _ProfessionScreenState extends State<ProfessionScreen> {
  String? selectedProfession;

  final List<String> professions = [
    'Company',
    'Foundation',
    'Photographer',
    'Makeup Artist',
    'Director',
    'Fashion',
    'Hairstylist',
    'Co-ordinator',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cast In',
        withIcon: true,
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
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: professions.map((profession) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedProfession = profession;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppStyle.secondaryBgColor,
                                borderRadius: BorderRadius.circular(25),
                                border: selectedProfession == profession
                                    ? Border.all(color: AppStyle.secondaryColor, width: 2)
                                    : null,
                              ),
                              child: Text(profession, style: AppStyle.textStyle1),
                            ),
                          );
                        }).toList(),
                      ),
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
