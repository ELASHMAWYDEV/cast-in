import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRouter.CHAT);
        },
        overlayColor: WidgetStatePropertyAll(AppStyle.secondaryBgColor.withAlpha(70)),
        child: Ink(
          decoration: BoxDecoration(
            color: AppStyle.primaryBgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppStyle.grey.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    AppAssets.testProfileImage,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Eleanor Pena',
                              style: AppStyle.subTitleStyle1.copyWith(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '2:30 pm',
                            style: AppStyle.textButtonTextStyle.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              'am contacting you because of the following concern',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppStyle.bodyTextStyle3.copyWith(color: AppStyle.darkGrey),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppStyle.secondaryTextColor,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '2',
                              style: AppStyle.bodyTextStyle3.copyWith(
                                fontSize: 12,
                                color: AppStyle.primaryBgColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
