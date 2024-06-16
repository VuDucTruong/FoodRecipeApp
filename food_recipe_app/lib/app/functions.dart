import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/no_connection_dialog.dart';
import 'package:food_recipe_app/presentation/utils/gemini_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_otp/email_otp.dart';
import 'package:intl/intl.dart';

import '../presentation/resources/string_management.dart';

Future<T?> showAnimatedDialog1<T extends Object?>(
    BuildContext context, Widget dialog) {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: true,
    transitionDuration: const Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) {
      return dialog;
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
            .animate(
                CurvedAnimation(parent: animation, curve: Curves.bounceOut)),
        child: child,
      );
    },
  );
}

Future<T?> showAnimatedDialog2<T extends Object?>(
    BuildContext context, Widget dialog) {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: true,
    transitionDuration: const Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) {
      return dialog;
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: animation, curve: Curves.bounceOut)),
        child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(animation),
            child: child),
      );
    },
  );
}

final _emailRegex = RegExp(r'^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$');
final _phoneRegex = RegExp(r'^[0-9]{10,11}$');
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.emailRequiredError.tr();
  }
  if (!_emailRegex.hasMatch(value)) {
    return AppStrings.emailFormatError.tr();
  }
  return null;
}

String? validateEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.emptyError.tr();
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.phoneRequiredError.tr();
  }
  if (!_phoneRegex.hasMatch(value)) {
    return AppStrings.phoneValidationError.tr();
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.passRequiredError.tr();
  }
  if (value.length < 6) {
    return AppStrings.passValidationError.tr();
  }
  return null;
}

String? validateMatch(String? value1, String? value2) {
  if (value1 != value2) {
    return AppStrings.notMatchPass.tr();
  }
  return null;
}

Future<File?> selectImageFromGalery() async {
  final ImagePicker picker = ImagePicker();
// Pick an image.
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image == null) return null;
  return File(image.path);
}

Future<void> sendOTP(EmailOTP myAuth, String email) async {
  var template = 'Thank you for choosing {{app_name}}. Your OTP is {{otp}}.';
  myAuth.setTemplate(render: template);
  myAuth.setTheme(theme: "v2");
  myAuth.setConfig(
      appEmail: "cookit998@gmail.com",
      appName: "Cook It",
      userEmail: email,
      otpLength: 6,
      otpType: OTPType.digitsOnly);
  await myAuth.sendOTP();
}

bool isThereCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

void handleBlocFailures(
    BuildContext context, Failure failure, Function reload) {
  if (failure.code == ResponseCode.NO_INTERNET_CONNECTION) {
    showDialog(
        context: context,
        builder: (context) => NoConnectionDialog(reload: reload));
  } else if (failure.code == ResponseCode.DEFAULT) {
    showDialog(
        context: context,
        builder: (context) => AppErrorDialog(content: failure.message));
  } else if (failure.code == ResponseCode.BAD_REQUEST) {
    showDialog(
        context: context,
        builder: (context) =>
            AppErrorDialog(content: AppStrings.invalidInput.tr()));
  } else if (failure.code == ResponseCode.UNAUTHORISED) {
    showDialog(
        context: context,
        builder: (context) =>
            AppErrorDialog(content: AppStrings.unauthorizedError.tr()));
  } else if (failure.code == ResponseCode.INTERNAL_SERVER_ERROR) {
    showDialog(
        context: context,
        builder: (context) =>
            AppErrorDialog(content: AppStrings.internalServerError.tr()));
  } else if (failure.code == ResponseCode.CONNECT_TIMEOUT) {
    showDialog(
        context: context,
        builder: (context) =>
            AppErrorDialog(content: AppStrings.timeoutError.tr()));
  } else {
    showDialog(
        context: context,
        builder: (context) =>
            AppErrorDialog(content: AppStrings.somethingWentWrong.tr()));
  }
}

PromptData buildPrompt(PromptData userPrompt, String additionalContext) {
  print(getMainPrompt(userPrompt, additionalContext));
  return PromptData(
    language: userPrompt.language,
    images: userPrompt.images,
    textInput: getMainPrompt(userPrompt, additionalContext),
    basicIngredients: userPrompt.selectedBasicIngredients,
    cuisines: userPrompt.selectedCuisines,
    dietaryRestrictions: userPrompt.selectedDietaryRestrictions,
    additionalTextInputs: [getFormat(userPrompt.language)],
  );
}

String getMainPrompt(PromptData userPrompt, String additionalContext) {
  return '''
You are a Cat who's a chef that travels around the world a lot, and your travels inspire recipes.

Recommend a recipe for me based on the provided image.
The recipe should only contain real, edible ingredients.
If there are no images attached, or if the image does not contain food items, please respond exactly with: $badImageFailure

Adhere to food safety and handling best practices like ensuring that poultry is fully cooked.
I'm in the mood for the following types of cuisine: ${userPrompt.selectedCuisines},
I have the following dietary restrictions: ${userPrompt.selectedDietaryRestrictions}
Optionally also include the following ingredients: ${userPrompt.selectedBasicIngredients}
Do not repeat any ingredients.

After providing the recipe, add an descriptions that creatively explains why the recipe is good based on only the ingredients used in the recipe.  Tell a short story of a travel experience that inspired the recipe.
List out any ingredients that are potential allergens.
Provide categories that the recipe belongs to based on this list : ${Constant.typeList.toString()}
Provide a summary of how many people the recipe will serve.

${additionalContext.isNotEmpty}
''';
}

String cleanJson(String maybeInvalidJson) {
  if (maybeInvalidJson.contains('```')) {
    final withoutLeading = maybeInvalidJson.split('```json').last;
    final withoutTrailing = withoutLeading.split('```').first;
    return withoutTrailing;
  }
  return maybeInvalidJson;
}

String badImageFailure =
    "The recipe request either does not contain images, or does not contain images of food items. I cannot recommend a recipe.";

String getFormat(String language) => '''
Return the recipe as valid JSON using the following structure
{
  "ingredients":  \$ingredients,
  "instruction": \$instruction,
  "title": \$title,
  "categories": \$categories,
  "description": \$description,
  "servings": \$servings,
  "cookTime": \$cookTime,
  "isVegan": \$isVegan
}
  

title, description should be of String type and should be in $language. 
ingredients should be of type List<String> and should be in $language.
instruction should be of type String  and each step need to be in a line and numbering by 1 and should be in $language.
servings should be of type Integer . 
categories should be of type String and should be in $language and if there is more than 2 categories , please separate them by a comma .
isVegan should be of type boolean 
cookTime should be of type Integer and the number is in minutes.
''';

String formatDateTime(DateTime date) {
  DateFormat dateFormat = DateFormat('HH:mm dd/MM/yyyy');
  return dateFormat.format(date);
}

Future<void> giveFeedback() async {
  final Email email = Email(
    body: '',
    subject: 'App Feedback',
    recipients: ['cookit998@gmail.com'],
    isHTML: false,
  );
  await FlutterEmailSender.send(email);
}
