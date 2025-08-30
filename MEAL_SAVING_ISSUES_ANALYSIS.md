# Analysis: Why Meals Are Not Being Saved to meal_items Database

## Issues Identified and Fixed

### 1. **CRITICAL: Incorrect mealId Assignment in MealServlet.java**
**Problem:** In `MealServlet.java` line 117, the code was incorrectly setting:
```java
mealItem.setMealId(user.getId()); // WRONG: Using user_id as meal_id
```

**Impact:** This caused meal items to be saved with the user's ID instead of the actual meal ID, breaking the foreign key relationship and making it impossible to properly link meal items to their corresponding meals.

**Fix Applied:** 
- Created a proper `Meal` object first
- Called `mealDAO.addMeal(meal)` to get the actual meal ID
- Used the returned meal ID for the meal item: `mealItem.setMealId(mealId)`

### 2. **Missing Quantity Assignment in MealServlet.java**
**Problem:** The `MealServlet.java` was not setting the quantity for meal items, while `MealFormServlet.java` was correctly doing so.

**Fix Applied:** Added `mealItem.setQuantity(quantity)` to ensure quantity data is preserved.

### 3. **Missing Total Calories Update**
**Problem:** After adding meal items, the meal's total calories were not being updated in `MealServlet.java`.

**Fix Applied:** Added code to update the meal's total calories after successfully adding the meal item.

### 4. **Database Configuration Mismatch**
**Problem:** 
- `DatabaseUtil.java` used password "123"
- `database.properties` used password "password"
- Missing connection parameters for proper MySQL 8.x compatibility

**Fix Applied:** 
- Standardized password to "password" in `DatabaseUtil.java`
- Added proper connection parameters: `useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8`

### 5. **Missing Database Setup**
**Problem:** MySQL was not installed and the `health_diary` database with required tables didn't exist.

**Fix Applied:** 
- Installed MySQL server
- Created `database_setup.sql` with complete schema including:
  - `users` table
  - `meals` table  
  - `meal_items` table with proper foreign key relationships
  - `food_samples` table with sample data

## Code Changes Made

### MealServlet.java Changes:
```java
// Before (BROKEN):
mealItem.setMealId(user.getId()); // Wrong: using user ID instead of meal ID

// After (FIXED):
// Create new meal first
Meal meal = new Meal();
meal.setUserId(user.getId());
meal.setMealTime(mealType);
meal.setLogDate(logDate);
meal.setTotalCalories(null);

int mealId = mealDAO.addMeal(meal);
mealItem.setMealId(mealId); // Correct: using actual meal ID
mealItem.setQuantity(quantity); // Added missing quantity

// Update meal total calories after adding items
meal.setId(mealId);
meal.setTotalCalories(totalItemCalories);
mealDAO.updateMeal(meal);
```

### DatabaseUtil.java Changes:
```java
// Before:
"jdbc:mysql://localhost:3306/health_diary", "root", "123"

// After:
"jdbc:mysql://localhost:3306/health_diary?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8", "root", "password"
```

## Database Setup Instructions

1. Start MySQL service (if not running)
2. Run the `database_setup.sql` script:
   ```bash
   mysql -u root -ppassword < database_setup.sql
   ```

## Testing

After these fixes, the meal saving functionality should work correctly:
1. Meals will be properly created in the `meals` table
2. Meal items will be correctly linked to their parent meals via `meal_id`
3. Quantity and calories will be properly stored
4. Total calories will be calculated and updated in the meal record

The main issue was the fundamental misunderstanding in `MealServlet.java` where `user.getId()` was being used as the `meal_id`, which completely broke the relational database structure.