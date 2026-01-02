# Kilimo - NPK Testing App with Supabase

This Flutter app helps farmers test soil NPK levels and manage their farming profiles.

## Setup Instructions

### 1. Create a Supabase Project

1. Go to [supabase.com](https://supabase.com) and create a new account
2. Create a new project
3. Wait for the project to be set up

### 2. Get Your Supabase Credentials

1. In your Supabase dashboard, go to Settings > API
2. Copy your Project URL and anon/public key
3. Update `lib/supabase_config.dart` with your credentials:

```dart
static const String supabaseUrl = 'https://your-project-id.supabase.co';
static const String supabaseAnonKey = 'your-anon-key';
```

### 3. Set Up the Database

1. In your Supabase dashboard, go to the SQL Editor
2. Run the SQL commands from `supabase_setup.sql` to create the users table and policies

### 4. Configure Authentication

1. In your Supabase dashboard, go to Authentication > Settings
2. Configure your site URL and redirect URLs for OAuth (if using Google sign-in)
3. For Google OAuth:
   - Go to Authentication > Providers
   - Enable Google provider
   - Add your Google OAuth credentials

### 5. Run the App

```bash
flutter pub get
flutter run
```

## Features

- User registration and login with email/password
- Google OAuth sign-in
- User profile management with farming details
- Soil NPK testing functionality (to be implemented)

## Project Structure

- `lib/models/` - Data models
- `lib/providers/` - State management
- `lib/services/` - Business logic and API calls
- `lib/screens/` - UI screens
- `supabase_setup.sql` - Database setup script