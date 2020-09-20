import 'dart:convert' as convert;

import 'package:cocktaildbhttpusing/models.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_dto.dart';
import 'package:cocktaildbhttpusing/src/repository/cocktail_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  CocktailRepository repository;

  Map<String, String> _getIngredients(CocktailDTO dto) {
    return <String, String>{
      if (dto.strIngredient1 != null) dto.strIngredient1: dto.strMeasure1,
      if (dto.strIngredient2 != null) dto.strIngredient2: dto.strMeasure2,
      if (dto.strIngredient3 != null) dto.strIngredient3: dto.strMeasure3,
      if (dto.strIngredient4 != null) dto.strIngredient4: dto.strMeasure4,
      if (dto.strIngredient5 != null) dto.strIngredient5: dto.strMeasure5,
      if (dto.strIngredient6 != null) dto.strIngredient6: dto.strMeasure6,
      if (dto.strIngredient7 != null) dto.strIngredient7: dto.strMeasure7,
      if (dto.strIngredient8 != null) dto.strIngredient8: dto.strMeasure8,
      if (dto.strIngredient9 != null) dto.strIngredient9: dto.strMeasure9,
      if (dto.strIngredient10 != null) dto.strIngredient10: dto.strMeasure10,
      if (dto.strIngredient11 != null) dto.strIngredient11: dto.strMeasure11,
      if (dto.strIngredient12 != null) dto.strIngredient12: dto.strMeasure12,
      if (dto.strIngredient13 != null) dto.strIngredient13: dto.strMeasure13,
      if (dto.strIngredient14 != null) dto.strIngredient14: dto.strMeasure14,
      if (dto.strIngredient15 != null) dto.strIngredient15: dto.strMeasure15,
    };
  }

  setUp(() {
    repository = CocktailRepository();
  });

  group('Coctail repository', () {
    test('fetch method should return all available cocktails', () {
      final actualResult = repository.fetchPopularCocktails();
      expect(actualResult, isNotEmpty);
    });

    test('fetch method should return all available cocktails', () async {
      var client = http.Client();
      try {
        // Await the http get response, then decode the json-formatted responce.
        const String url = 'https://the-cocktail-db.p.rapidapi.com/popular.php';
        var response = await http.get(
          url,
          headers: {
            'x-rapidapi-key': 'e5b7f97a78msh3b1ba27c40d8ccdp105034jsn34e2da32d50b',
          },
        );
        if (response.statusCode == 200) {
          final jsonResponse = convert.jsonDecode(response.body);
          var drinks = jsonResponse['drinks'] as Iterable<dynamic>;

          final result = drinks.cast<Map<String, dynamic>>().map((json) => CocktailDTO.fromJson(json));

          var ctor = '';
          for (final dto in result) {
            final glass = GlassType.parse(dto.strGlass);
            final cocktailType = CocktailType.parse(dto.strAlcoholic);
            final category = CocktailCategory.parse(dto.strCategory);

            var ingredients = '';

            _getIngredients(dto)
                .forEach((key, value) => ingredients += 'IngredientDefinition(\'$key\', \'$value\'),\r\n');

            ctor += '''
                  Cocktail(
                    id: '${dto.idDrink}',
                    category: CocktailCategory.${category.name},
                    cocktailType: CocktailType.${cocktailType.name},
                    glassType: GlassType.${glass.name},
                    instruction: '${dto.strInstructions}',
                    isFavourite: true,
                    name: '${dto.strDrink}',
                    ingredients: [
                      $ingredients
                    ],
                    drinkThumbUrl: '${dto.strDrinkThumb}',
                  ),
                ''';
          }

          print(ctor);
        } else {
          print("Request failed with status: ${response.statusCode}.");
        }
      } finally {
        client.close();
      }
    });
  });
}