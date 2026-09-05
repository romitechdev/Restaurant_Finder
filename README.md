
# Restaurant Finder - Flutter App

![Restaurant App Demo](https://firebasestorage.googleapis.com/v0/b/project-revelation-396514.appspot.com/o/pop-os-2024-07-25_21-02-18.gif?alt=media&token=c60c3b87-142f-488f-b98a-bb0977209930)

## 📜 Description

This is a Flutter mobile app that displays a list of restaurants. The app was created as a sample portfolio project demonstrating the implementation of modern concepts in Flutter development, including clean architecture, state management, and responsive UI design.

The app fetches restaurant data from a local JSON file and displays it in an attractive list. Users can view the details of each restaurant on a separate page, and can also switch the theme between light and dark mode.

---

## ✨ Key Features

-   **Restaurant List**: Displays a list of restaurants with images, names, and cities.
-   **Detail Page**: A dedicated page for each restaurant showing more complete information such as descriptions, food menu, and drinks.
-   **State Management**: Uses `Provider` to manage application state, such as restaurant data and theme.
-   **Light & Dark Theme**: Includes a button to dynamically switch between light and dark mode.
-   **Responsive UI**: A layout that adapts to various screen sizes.
-   **Clean Architecture**: Code is organized by separating the UI layer (pages, widgets), state management (providers), and data (models).
-   **Font Customization**: Uses the `google_fonts` package for more appealing typography.

---

## 🚀 Technology & Libraries

-   **Framework**: [Flutter](https://flutter.dev/)
-   **Language**: [Dart](https://dart.dev/)
-   **State Management**: [provider](https://pub.dev/packages/provider)
-   **HTTP Client**: [http](https://pub.dev/packages/http)
-   **Typography**: [google_fonts](https://pub.dev/packages/google_fonts)
-   **Code Analysis**: [flutter_lints](https://pub.dev/packages/flutter_lints)

---

## 📂 Project Structure

The project is organized with a feature-oriented folder structure to make navigation and scalability easier:

```
lib/
├── models/         # Data models for the app (Restaurant, ApiResponse)
├── pages/          # Main pages or screens (HomePage, DetailPage)
├── providers/      # Business logic and state management (RestaurantProvider, ThemeProvider)
├── widgets/        # Reusable UI components (RestaurantCard, ErrorWidget)
└── main.dart       # Main application entry point and theme configuration
```

---

## 🏁 Getting Started

To run this project locally, follow these steps:

1.  **Clone this repository:**
    ```bash
    git clone https://github.com/NAMAPENGGUNAANDA/NAMA-REPOSITORIANDA.git
    ```

2.  **Enter the project directory:**
    ```bash
    cd NAMA-REPOSITORIANDA
    ```

3.  **Install all dependencies:**
    ```bash
    flutter pub get
    ```

4.  **Run the application:**
    ```bash
    flutter run
    ```

---

> This project was created for demonstration and portfolio purposes. Feel free to use it as a reference.