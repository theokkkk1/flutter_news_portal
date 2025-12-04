# Flutter News Portal - Final

Features added:
- Theme toggle (AppBar button) with persistence
- Registration (name, email, password) stored locally
- Categories derived from news_site (ChoiceChips)
- Article details view with share and favorite
- Profile view with basic user info and theme switch
- Infinite scroll + Favorites persisted with SharedPreferences

How to run:
1. flutter pub get
2. flutter run -d chrome (or device)

Notes:
- For full browser opening of links, add webview or url_launcher as needed.
- The Share feature uses share_plus plugin.
