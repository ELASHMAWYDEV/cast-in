import 'package:cast_in/ui/components/form/drop_down_field.dart';
import 'package:cast_in/ui/components/form/input_field.dart';
import 'package:cast_in/ui/components/main_button.dart';
import 'package:cast_in/ui/screens/profile/profile/components/profile_and_background_photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /////// profile photo and background photo
            ProfileAndBackgroundPhotos(
              editScreen: true,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 30,
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                FormBuilder(
                  child: Column(
                    children: [
                      InputField(
                        name: 'full_name',
                        labelText: "Full name",
                        hintText: 'John Smith',
                        validator: FormBuilderValidators.required(
                          errorText: "Full name is required",
                        ),
                      ),
                      SizedBox(height: 15),
                      InputField(
                        name: 'user_name',
                        labelText: "User Name",
                        hintText: '@username',
                        validator: FormBuilderValidators.required(
                          errorText: "Username is required",
                        ),
                      ),
                      SizedBox(height: 15),
                      InputField(
                        name: 'phone_number',
                        labelText: "Phone No",
                        hintText: '+9999999999',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: "Phone number is required"),
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.minLength(10, errorText: "Minimum 10 digits"),
                        ]),
                      ),
                      SizedBox(height: 30),
                      DropDownField(
                        name: 'country',
                        labelText: 'Country',
                        hintText: ' your country',
                        items: ['USA', 'UK', 'Canada', 'Dubai', 'India', 'Indonesia'],
                        validator: FormBuilderValidators.required(errorText: 'Country is required'),
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DropDownField(
                        name: 'city',
                        labelText: 'City',
                        hintText: ' your city',
                        items: ['Cairo', 'Alexandria'],
                        validator: FormBuilderValidators.required(errorText: 'City is required'),
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                MainButton(
                  onPressed: () {},
                  title: 'Update',
                  fullWidth: true,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
