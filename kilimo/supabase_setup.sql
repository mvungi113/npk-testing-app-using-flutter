-- Create users table in Supabase
-- Run this SQL in your Supabase SQL editor

CREATE TABLE IF NOT EXISTS users (
  uid TEXT PRIMARY KEY,
  full_name TEXT,
  email TEXT UNIQUE NOT NULL,
  profile_image_url TEXT,
  phone_number TEXT,
  date_of_birth BIGINT,
  gender TEXT,
  country TEXT,
  region TEXT,
  created_at BIGINT DEFAULT EXTRACT(EPOCH FROM NOW()) * 1000,
  updated_at BIGINT DEFAULT EXTRACT(EPOCH FROM NOW()) * 1000
);

-- Enable Row Level Security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Create policy for users to read their own data
CREATE POLICY "Users can view own profile" ON users
  FOR SELECT USING (auth.uid()::text = uid);

-- Create policy for users to update their own data
CREATE POLICY "Users can update own profile" ON users
  FOR UPDATE USING (auth.uid()::text = uid);

-- Create policy for users to insert their own data
CREATE POLICY "Users can insert own profile" ON users
  FOR INSERT WITH CHECK (auth.uid()::text = uid);

-- Create policy for authenticated users to read all users (for admin purposes)
CREATE POLICY "Authenticated users can view all profiles" ON users
  FOR SELECT USING (auth.role() = 'authenticated');