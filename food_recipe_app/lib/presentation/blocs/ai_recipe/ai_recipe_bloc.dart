import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/utils/gemini_utils.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:meta/meta.dart';

part 'ai_recipe_event.dart';
part 'ai_recipe_state.dart';

class AIRecipeBloc extends Bloc<AIRecipeEvent, AIRecipeState> {
  late GenerativeModel geminiProModel;
  AIRecipeBloc() : super(AIRecipeInitial()) {
    initGeminiModel();
    on<SubmitPrompt>(_onSubmitPrompt);
  }
  initGeminiModel() {
    const apiKey = 'AIzaSyD1t4IjPqkSNc6worsxE1DQHPpQFYHsFx0';
    if (apiKey == 'key not found') {
      throw InvalidApiKey(
        'Key not found in environment. Please add an API key.',
      );
    }

    geminiProModel = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: apiKey,
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
  }

  Future<FutureOr<void>> _onSubmitPrompt(
      SubmitPrompt event, Emitter<AIRecipeState> emit) async {
    var model = geminiProModel;

    final prompt = buildPrompt(event.userPrompt, event.additionalContext);
    try {
      emit(AIRecipeLoadingState());
      final content = await GeminiUtils.generateContent(model, prompt);
      log(content.text ?? '');
      // handle no image or image of not-food
      if (content.text != null && content.text!.contains(badImageFailure)) {
        emit(AIRecipeErrorState(Failure.actionFailed(badImageFailure)));
      } else {
        RecipeEntity recipe = RecipeEntity.fromGeneratedContent(content);
        emit(AIRecipeLoadedState(recipe));
      }
    } catch (error) {
      emit(AIRecipeErrorState(
          Failure.actionFailed("Failed to reach Gemini. \n\n$error")));
    }
  }
}
