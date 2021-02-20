import 'package:flutter/material.dart';
import 'package:NutraFlex/models/spoonacular.dart';

class Nutrition extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NutritionState();
  }
}

class _NutritionState extends State<Nutrition> {
  Future<List> futureMealPlan;

  void initState() {
    super.initState();
    futureMealPlan = fetchMealData();
  }

  Future<List> fetchMealData() async {
    List currentMealPlan = [];
    Future<MealPlan> mealPlan = fetchMealPlan();
    MealPlan mealPlanNew = await mealPlan;
    List meals = mealPlanNew.meals;
    for (var i = 0; i < meals.length; i++) {
      Meal currentMeal = await meals[i];
      currentMealPlan.add({
        'name': currentMeal.name,
        'image': currentMeal.image,
        'facts': currentMeal.nutritionFacts
      });
    }

    return currentMealPlan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: futureMealPlan,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (var i = 0; i < 3; i++)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    snapshot.data[i]['name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Image.network(
                                  snapshot.data[i]['image'],
                                  height: 75,
                                  width: 100,
                                ),
                              ],
                            ),
                            Table(children: [
                              TableRow(children: [
                                Center(
                                    child: Text('Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Center(
                                    child: Text('Amount',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Center(
                                    child: Text('% of Daily Need',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                              ]),
                              for (var j = 0;
                                  j < snapshot.data[i]['facts'].length;
                                  j++)
                                TableRow(children: [
                                  Center(
                                      child: Text(
                                          snapshot.data[i]['facts'][j]['name'],
                                          style: TextStyle(fontSize: 12))),
                                  Center(
                                      child: Text(
                                          snapshot.data[i]['facts'][j]['amount']
                                                  .toString() +
                                              ' ' +
                                              snapshot.data[i]['facts'][j]
                                                  ['unit'],
                                          style: TextStyle(fontSize: 12))),
                                  Center(
                                      child: Text(
                                          snapshot.data[i]['facts'][j]
                                                      ['percentOfDailyNeeds']
                                                  .toString() +
                                              '%',
                                          style: TextStyle(fontSize: 12))),
                                ])
                            ]),
                          ],
                        )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        snapshot.error.toString().substring(11),
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                }
                return CircularProgressIndicator();
              })
        ],
      ),
    );
  }
}
