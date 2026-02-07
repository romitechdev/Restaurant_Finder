# Restaurant App Blueprint

## Overview

This document outlines the structure, design, and features of the Restaurant App, a Flutter application that displays a list of restaurants from an API.

## Style, Design, and Features

### Implemented

*   **UI:** The app uses Material Design 3 for a modern and visually appealing user interface.
*   **Theming:**
    *   **Color Scheme:** The app utilizes a custom color scheme generated from a deep purple seed color for both light and dark themes. This ensures a consistent and unique branding.
    *   **Theme Provider:** A `ThemeProvider` is used to manage the application's theme. It allows users to switch between light, dark, and system theme modes.
    *   **Theme Toggle:** The home page includes an `AppBar` with buttons to toggle between light/dark mode and to set the theme to the system default.
*   **State Management:** The app uses the `provider` package for state management, specifically for managing the theme and the restaurant data.
*   **Data Fetching:** The app fetches a list of restaurants from a remote API.
*   **UI Components:**
    *   **RestaurantCard:** A custom widget to display individual restaurant information.
    *   **LoadingIndicator:** A widget to show while data is being fetched.
    *   **ErrorWidget:** A widget to display an error message if data fetching fails.
*   **Navigation:** The app has a single home page that displays the list of restaurants.

### Current Plan: Theme Update

The following steps were taken to update the application's theme:

1.  **Update `lib/main.dart`:**
    *   The `ThemeData` for both light and dark themes was updated to use `ColorScheme.fromSeed` with a `deepPurple` seed color.
    *   `useMaterial3` was set to `true` to enable Material Design 3 components.

2.  **Update `lib/providers/theme_provider.dart`:**
    *   The `ThemeProvider` was updated to include a `setSystemTheme` method.
    *   The default `_themeMode` was changed to `ThemeMode.system`.

3.  **Update `lib/pages/home_page.dart`:**
    *   The `AppBar` was updated to include two `IconButton`s:
        *   One to toggle between light and dark themes.
        *   One to set the theme to the system theme.
