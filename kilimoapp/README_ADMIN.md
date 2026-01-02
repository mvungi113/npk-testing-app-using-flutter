# Kilimo Admin Panel - Laravel Backend

This is the admin panel for the Kilimo application, built with Laravel and connected to Supabase.

## Features

- ✅ Secure admin authentication with credentials in .env
- ✅ User management (view, delete users)
- ✅ Dashboard with statistics
- ✅ Connected to Supabase PostgreSQL database
- ✅ Responsive design with Tailwind CSS

## Setup Instructions

### 1. Install Dependencies

```bash
composer install
```

### 2. Configure Environment

Update your `.env` file with your Supabase credentials:

```env
# Supabase Database Configuration
DB_CONNECTION=pgsql
DB_HOST=your-project-ref.supabase.co
DB_PORT=5432
DB_DATABASE=postgres
DB_USERNAME=postgres
DB_PASSWORD=your-supabase-password

# Admin Credentials (Change these to your desired credentials)
ADMIN_EMAIL=admin@kilimo.com
ADMIN_PASSWORD=your-secure-password-here
```

**Important**: Replace the following:
- `your-project-ref.supabase.co` with your Supabase project URL
- `your-supabase-password` with your Supabase database password
- `admin@kilimo.com` with your desired admin email
- `your-secure-password-here` with a strong password for admin login

### 3. Run Migrations

Since you're using an existing Supabase database, no migrations are needed. The app will connect to your existing `users` table.

### 4. Start the Development Server

```bash
php artisan serve
```

The admin panel will be available at: `http://localhost:8000`

## Usage

### Login

1. Navigate to `http://localhost:8000`
2. You'll be redirected to the login page
3. Enter the admin credentials you set in `.env`:
   - Email: The value of `ADMIN_EMAIL`
   - Password: The value of `ADMIN_PASSWORD`

### Dashboard

After logging in, you'll see:
- Total users count
- Recent users list
- Quick action buttons

### User Management

- **View All Users**: Click "Manage Users" to see all registered users
- **View User Details**: Click "View" next to any user
- **Delete User**: Click "Delete" to remove a user (with confirmation)

## Security Features

1. **Environment Variables**: Admin credentials are stored in `.env` file
2. **Session-based Authentication**: Uses Laravel sessions
3. **Middleware Protection**: All admin routes are protected with custom middleware
4. **CSRF Protection**: All forms include CSRF tokens

## Important Notes

- **Never commit your `.env` file** to version control
- Change default admin credentials immediately after first login
- The app connects directly to your Supabase database
- User data is read-only from the Flutter app's Supabase tables

## Routes

- `/` - Redirects to admin login
- `/admin/login` - Admin login page
- `/admin/dashboard` - Admin dashboard (protected)
- `/admin/users` - User management (protected)
- `/admin/users/{id}` - View user details (protected)
- `/admin/logout` - Logout

## Technologies Used

- Laravel 11
- Tailwind CSS (via CDN)
- PostgreSQL (Supabase)
- Blade Templates

## Future Enhancements

- [ ] Post management (create, edit, delete posts)
- [ ] Advanced user filtering and search
- [ ] Analytics and reports
- [ ] Email notifications
- [ ] Role-based access control
