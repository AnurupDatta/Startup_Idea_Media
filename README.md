# Startup Ideas App

A Flutter application for sharing, upvoting, and exploring innovative startup ideas. Users can submit their own ideas, view a leaderboard, and toggle between light and dark themes. Data is persisted locally using Shared Preferences.

## Features

- 🌟 Submit new startup ideas with title, tagline, and description
- 👍 Upvote your favorite ideas
- 🏆 Leaderboard to see top-voted ideas
- 🌙 Light and dark mode support
- 💾 Local data persistence (no backend required)
- 📤 Share ideas with others

## Screenshots

_Add screenshots here if available_

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart SDK (comes with Flutter)
- Android Studio, VS Code, or any preferred IDE

### Installation

1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd startup
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

## Project Structure

- `lib/main.dart` – App entry point, theme management
- [`lib/main_page/home_screen.dart`](lib/main_page/home_screen.dart) – Main navigation, state management, and theme toggle
- [`lib/screens/main_idea_screen.dart`](lib/screens/main_idea_screen.dart) – Idea submission and listing
- [`lib/screens/leaderboard.dart`](lib/screens/leaderboard.dart) – Leaderboard view
- [`lib/screens/idea_information.dart`](lib/screens/idea_information.dart) – Detailed idea info
- [`lib/screens/submission_page.dart`](lib/screens/submission_page.dart) – Idea submission form
- [`lib/model/idea_model.dart`](lib/model/idea_model.dart) – Idea data model

## Dependencies

- [shared_preferences](https://pub.dev/packages/shared_preferences) – Local storage
- [share_plus](https://pub.dev/packages/share_plus) – Sharing ideas
- [flutter](https://flutter.dev) – UI framework

## Customization

- Change theme colors in `main.dart` and `home_screen.dart`
- Modify the idea model in [`lib/model/idea_model.dart`](lib/model/idea_model.dart) to add more fields

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](LICENSE) (or specify your license)

---

Made
