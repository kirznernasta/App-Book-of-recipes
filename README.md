# Android applicatoin "Book of recipes"
## Kirzner Nastya, group number: 153502
### Here are the main functions of a Flutter app called "Book of Recipes":

 * ***Search***: Allow users to search for recipes based on ingredients, cuisine, course, or recipe name. The search feature provides relevant results and allows for filtering by various criteria.

* ***Recipe list***: Display a list of recipes, which could include popular or recommended recipes, recently added recipes, or user favorites. Each recipe should have a photo, name, and rating, along with the option to view the recipe details.

* ***Recipe details***: Show the details of a selected recipe, including ingredients, preparation steps, cooking time, serving size, nutritional information, and user reviews. Users can also add the recipe to their favorites or shopping list.

* ***Favorites***: Allow users to save their favorite recipes for quick access in the future. Users can add and remove recipes from their favorites list, and the app should remember their selections.

* ***Shopping list***: Enable users to create a shopping list based on the ingredients required for the recipes they plan to make. Users can check off items as they purchase them, and the app should keep track of their progress.

* ***Sharing***: Give users the ability to share recipes with others via email, social media, or text messaging. Users can also copy a recipe link to the clipboard for sharing elsewhere.

* ***User profile***: Allow users to create a profile and save their preferences, such as dietary restrictions, allergies, and favorite cuisines. The app can suggest recipes that align with the user's preferences and track their activity within the app.

* ***Recipe submission***: Allow users to submit their own recipes to the app, including photos, ingredients, and preparation instructions. The app should moderate recipe submissions for accuracy and appropriateness.

* ***Reviews and ratings***: Enable users to rate and review recipes they have tried, and display the average rating and number of reviews for each recipe. Users can also sort recipes by rating to find the most popular or highly rated dishes.

* ***Notifications***: Provide users with notifications for new recipe additions, special promotions, or updates to the app. Users can opt-in or out of notifications based on their preferences.

### The following data models can be defined:

1. `Recipe model` - This model represents a single recipe in the app. It includes properties such as the recipe name, list of ingredients, cooking steps, cooking time, serving size, photo of the dish, and more.

2. `Ingredient model` - This model represents a single ingredient in the recipe. It includes properties such as the ingredient name, quantity, unit of measurement, and more.

3. `User model` - This model represents a user in the app. It includes properties such as the user name, email address, password, list of favorite recipes, and more.

4. `Comment model` - This model represents a user comment on a specific recipe. It includes properties such as the recipe ID, user ID, comment text, and more.

5. `Rating model` - This model represents a rating of a recipe given by users. It may include properties such as the recipe ID, user ID, rating value, and more.