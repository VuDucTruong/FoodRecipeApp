part of 'ai_recipe_bloc.dart';

@immutable
sealed class AIRecipeEvent {}

class SubmitPrompt extends AIRecipeEvent {
  PromptData userPrompt;
  String additionalContext;

  SubmitPrompt(this.userPrompt, this.additionalContext);
}