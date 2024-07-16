# Bhagavad Gita App

This is a Bhagavad Gita application built using Flutter. It provides a serene and insightful user experience to explore the teachings of the Bhagavad Gita. The app features a splash screen, home page, detail page, and supports themes, likes, and multiple languages.

## Project Structure

```
lib/
├── provider/
│ ├── language_provider.dart
│ ├── like_provider.dart
│ └── theme_provider.dart
├── componentes/
│ └── custom_list_tile.dart
├── pages/
│ ├── detail_page.dart
│ ├── home_page.dart
│ └── splash.dart
├── main.dart
```

## Images & Videos

![bhagavad gita](https://github.com/user-attachments/assets/0bbc3952-c629-4309-8853-8f9ecba81b2f)

https://github.com/user-attachments/assets/f24e4819-61b2-4c3a-8ea7-02be23405c68

## Dependencies

The app uses the following dependencies:

- `carousel_slider: ^4.2.1`
- `provider: ^6.1.2`
- `shared_preferences: ^2.2.3`

## Getting Started

To get started with this project, follow the steps below:

### Installation

1. Clone the repository:

```
git clone https://github.com/PrincePatel027/Bhagavad_Gita
```

2. Navigate to the project directory:

```
cd bhagavad_gita_app
```

3. Install the dependencies:

```
flutter pub get
```

### Running the App
Run the app on an emulator or connected device:

```
flutter run
```

### Code Overview

**~main.dart**

The main entry point of the application. It sets up the providers and defines the routes for the app.

**~Providers**

*LanguageProvider:* Manages the language settings of the app.

*LikeProvider:* Manages the like functionality.

*ThemeProvider:* Manages the theme (Light, Dark, System).

*Pages*

- HomePage: The main page of the app where users can explore the content.
- DetailPage: Provides detailed information on selected content.
- Splash: The splash screen shown when the app is launched.
