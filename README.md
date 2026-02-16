# Lean Body Mass Calculator (Flutter)

Simple Flutter app to calculate Lean Body Mass (LBM) using 3 formulas:
- Boer
- James
- Hume

The app uses metric input:
- Height in `cm`
- Weight in `kg`

## Features
- Clean, mobile-friendly form UI
- Male/Female selection
- Input validation (required, numeric, > 0)
- Result table for all 3 formulas
- Clear button to reset form and results

## Formula Used
`W = weight (kg)`, `H = height (cm)`

Male:
- Boer: `0.407W + 0.267H - 19.2`
- James: `1.1W - 128(W/H)^2`
- Hume: `0.32810W + 0.33929H - 29.5336`

Female:
- Boer: `0.252W + 0.473H - 48.3`
- James: `1.07W - 148(W/H)^2`
- Hume: `0.29569W + 0.41813H - 43.2933`

## Run Locally
1. Install Flutter SDK.
2. Get dependencies:
   ```bash
   flutter pub get
   ```
3. Run app:
   ```bash
   flutter run
   ```

## Test
```bash
flutter test
```

## Project Structure
- `lib/main.dart`: app UI, validation, and calculation logic
- `lib/result.dart`: result table widget
- `test/widget_test.dart`: basic widget smoke test

## Preview
![App preview](lab%201.gif)
