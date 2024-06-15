import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiUtils {
  static Future<GenerateContentResponse> generateContent(
      GenerativeModel model, PromptData prompt) async {
    if (prompt.images.isEmpty) {
      return await GeminiUtils.generateContentFromText(model, prompt);
    } else {
      return await GeminiUtils.generateContentFromMultiModal(model, prompt);
    }
  }

  static Future<GenerateContentResponse> generateContentFromMultiModal(
      GenerativeModel model, PromptData prompt) async {
    final mainText = TextPart(prompt.textInput);
    final additionalTextParts =
        prompt.additionalTextInputs.map((t) => TextPart(t));
    final imagesParts = <DataPart>[];

    for (var f in prompt.images) {
      final bytes = await (f.readAsBytes());
      imagesParts.add(DataPart('image/jpeg', bytes));
    }

    final input = [
      Content.multi([...imagesParts, mainText, ...additionalTextParts])
    ];

    final response = await model.generateContent(
      input,
      generationConfig: GenerationConfig(
        temperature: 0.4,
        topK: 32,
        topP: 1,
        maxOutputTokens: 4096,
      ),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
      ],
    );
    return response;
  }

  static Future<GenerateContentResponse> generateContentFromText(
      GenerativeModel model, PromptData prompt) async {
    final mainText = TextPart(prompt.textInput);
    final additionalTextParts =
        prompt.additionalTextInputs.map((t) => TextPart(t)).join("\n");

    return await model.generateContent([
      Content.text(
        '${mainText.text} \n $additionalTextParts',
      )
    ]);
  }
}

class PromptData {
  PromptData({
    required this.images,
    required this.textInput,
    String? basicIngredients,
    String? cuisines,
    required this.language,
    String? dietaryRestrictions,
    List<String>? additionalTextInputs,
  })  : additionalTextInputs = additionalTextInputs ?? [],
        selectedBasicIngredients = basicIngredients ?? '',
        selectedCuisines = cuisines ?? '',
        selectedDietaryRestrictions = dietaryRestrictions ?? '';

  PromptData.empty()
      : images = [],
        additionalTextInputs = [],
        selectedBasicIngredients = '',
        selectedCuisines = '',
        selectedDietaryRestrictions = '',
        textInput = '',
        language = "English";

  List<File> images;
  String textInput;
  List<String> additionalTextInputs;
  String selectedBasicIngredients;
  String selectedCuisines;
  String selectedDietaryRestrictions;
  String language;

  PromptData copyWith({
    List<File>? images,
    String? textInput,
    List<String>? additionalTextInputs,
    String? basicIngredients,
    String? cuisineSelections,
    String? dietaryRestrictions,
    String? language,
  }) {
    return PromptData(
      language: language ?? "English",
      images: images ?? this.images,
      textInput: textInput ?? this.textInput,
      additionalTextInputs: additionalTextInputs ?? this.additionalTextInputs,
      basicIngredients: basicIngredients ?? selectedBasicIngredients,
      cuisines: cuisineSelections ?? selectedCuisines,
      dietaryRestrictions: dietaryRestrictions ?? selectedDietaryRestrictions,
    );
  }
}
