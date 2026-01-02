<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;

class AdminAuthController extends Controller
{
    /**
     * Show the admin login form
     */
    public function showLogin()
    {
        if (Session::has('admin_logged_in')) {
            return redirect()->route('admin.dashboard');
        }
        return view('admin.login');
    }

    /**
     * Handle admin login
     */
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        $adminEmail = env('ADMIN_EMAIL');
        $adminPassword = env('ADMIN_PASSWORD');

        if ($request->email === $adminEmail && $request->password === $adminPassword) {
            Session::put('admin_logged_in', true);
            Session::put('admin_email', $adminEmail);
            
            return redirect()->route('admin.dashboard')->with('success', 'Welcome to Kilimo Admin Panel');
        }

        return back()->withErrors([
            'email' => 'Invalid credentials provided.',
        ])->withInput($request->only('email'));
    }

    /**
     * Handle admin logout
     */
    public function logout()
    {
        Session::forget('admin_logged_in');
        Session::forget('admin_email');
        Session::flush();

        return redirect()->route('admin.login')->with('success', 'Logged out successfully');
    }
}
