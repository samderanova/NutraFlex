import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

const baseUrl = 'api.spoonacular.com';
const wantedNutritionFacts = [
  'Calories',
  'Fat',
  'Saturated Fat',
  'Carbohydrates',
  'Sugar',
  'Cholesterol',
  'Sodium',
  'Protein',
  'Fiber',
];

// Sample Nutrition Input for Meal Plan
const timeFrame = 'day';
const calories = '2000';
const diet = 'Vegetarian';
const exclude = 'shellfish';

// Makes request to generate meal plan
Future<MealPlan> fetchMealPlan() async {
  await DotEnv.load(); // load variables from .env
  final response = await http.get(Uri.https(baseUrl, 'mealplanner/generate', {
    'apiKey': DotEnv.env['MY_API_KEY'],
    'timeFrame': timeFrame,
    'targetCalories': calories,
    'diet': diet,
    'exclude': exclude,
  }));

  if (response.statusCode == 200) {
    print('Successful request for meal plan data!');
    List mealIds = [];
    var data = jsonDecode(response.body)['meals'];
    for (var i = 0; i < data.length; i++) {
      mealIds.add(data[i]['id']);
    }
    return MealPlan(mealIds);
  } else {
    throw Exception('Failed to get meal plan data.');
  }
}

// Makes request to get individual meal data
Future<Meal> fetchMealInfo(int mealId) async {
  await DotEnv.load(); // load variables from .env
  final response =
      await http.get(Uri.https(baseUrl, 'recipes/$mealId/information', {
    'apiKey': DotEnv.env['MY_API_KEY'],
    'includeNutrition': 'True',
  }));

  if (response.statusCode == 200) {
    print('Successful request for meal info data!');
    var data = jsonDecode(response.body);
    String name = data['title'];
    String image = data['image'];
    List nutritionFacts = [];
    var nutritionData = data['nutrition']['nutrients'];
    for (var i = 0; i < nutritionData.length; i++) {
      if (wantedNutritionFacts.contains(nutritionData[i]['name'])) {
        nutritionData[i].remove('title');
        nutritionFacts.add(nutritionData[i]);
      }
    }

    return Meal(name, image, nutritionFacts);
  } else {
    throw Exception('Failed to get meal info data.');
  }
}

// Meal object stores the meal's name, image, and nutrition facts
class Meal {
  String name = '';
  String image = '';
  List nutritionFacts = [];

  Meal(this.name, this.image, this.nutritionFacts);
}

// MealPlan object stores a list of 3 Meal objects
class MealPlan {
  List meals = [];

  MealPlan(ids) {
    for (var i = 0; i < ids.length; i++) {
      this.meals.add(fetchMealInfo(ids[i]));
    }
  }
}

// Testing
/*
void main() async {
  Future<MealPlan> mealPlan = fetchMealPlan();
  MealPlan mealPlanNew = await mealPlan;
  List meals = mealPlanNew.meals;
  for (var i = 0; i < meals.length; i++) {
    Meal currentMeal = await meals[i];
    print('Meal Name: ' + currentMeal.name);
    print('Meal Image: ' + currentMeal.image);
    print(currentMeal.nutritionFacts);
    print('-----------------------------------');
  }
}
*/
