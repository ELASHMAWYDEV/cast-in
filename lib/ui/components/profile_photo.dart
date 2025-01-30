import 'dart:io';

import 'package:cast_in/ui/common/app_snackbar.dart';
import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhotoWidget extends StatefulWidget {
  const ProfilePhotoWidget({super.key, required this.onPickImage, this.image});

  final Function(File) onPickImage;
  final File? image;

  @override
  State<ProfilePhotoWidget> createState() => _ProfilePhotoWidgetState();
}

class _ProfilePhotoWidgetState extends State<ProfilePhotoWidget> {
  final ImagePicker _picker = ImagePicker();

  late File? _image;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          widget.onPickImage(File(image.path));
          setState(() {
            _image = File(image.path);
          });
        } else {
          AppSnackbar.showWarning(message: "You didn't choose an image");
        }
      },
      child: DottedBorder(
        color: _image == null ? AppStyle.primaryColor : Colors.transparent,
        strokeWidth: 2,
        dashPattern: [8, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(16),
        child: Container(
          width: 130,
          height: 130,
          alignment: Alignment.center,
          child: _image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: Image.file(_image!, width: double.infinity, height: double.infinity, fit: BoxFit.cover))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppStyle.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 48,
                          height: 48,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        Positioned(
                          bottom: -5,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppStyle.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Profile Photo Text
                    Text("Profile Photo", style: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.primaryColor)),
                  ],
                ),
        ),
      ),
    );
  }
}
