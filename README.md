# 🪞 Introspee - Mood-Based Diary & Quote App

A Flutter app to write and store diary entries based on your mood and receive motivational quotes.

## ✨ Features
- Mood-based journaling UI
- Date picker for backdated entries
- Beautiful Firestore-based diary entry storage
- Motivational quotes fetched from [Quotable API](https://quotable.io)
- Hosted on Firebase + release-ready APK

## 📂 Project Structure
```
lib/
├── diary_entries.dart      # View list of saved diaries
├── diary_page.dart         # Write a new diary
├── diary_page_view.dart    # Read full diary
├── firebase_options.dart   # Firebase credentials (auto-generated)
├── home_page.dart          # Mood selection + entry point
├── main.dart               # App start
├── quotes.dart             # Show mood-matching quotes
└── utils.dart              # Moods, colors, config
```

## 🚀 Firebase Hosting

1. Build the web version:
   ```bash
   flutter build web
   ```

2. Deploy:
   ```bash
   firebase deploy
   ```

## 📱 Generate APK
```bash
flutter build apk --release
```

Find the APK at:  
`build/app/outputs/flutter-apk/app-release.apk`

## 🔧 Customize

- To edit moods: `lib/utils.dart`
- To change mood-to-quote mapping: `lib/quotes.dart`

## 🧠 Credits
Made with ❤️ for learning, expression, and emotional well-being.