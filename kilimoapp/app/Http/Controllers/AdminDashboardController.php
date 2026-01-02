<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class AdminDashboardController extends Controller
{
    private function getSupabaseUrl()
    {
        return env('SUPABASE_URL') . '/rest/v1/users';
    }

    private function getHeaders()
    {
        return [
            'apikey' => env('SUPABASE_SERVICE_KEY'),
            'Authorization' => 'Bearer ' . env('SUPABASE_SERVICE_KEY'),
            'Content-Type' => 'application/json',
        ];
    }

    /**
     * Show the admin dashboard
     */
    public function index()
    {
        // Get all users from Supabase
        $response = Http::withHeaders($this->getHeaders())
            ->get($this->getSupabaseUrl() . '?order=created_at.desc');

        $totalUsers = 0;
        $recentUsers = collect();

        if ($response->successful()) {
            $data = $response->json();
            
            // Handle both array and single object responses
            if (!is_array($data)) {
                $data = [$data];
            }
            
            $allUsers = collect($data)->map(function ($user) {
                // Convert timestamps
                if (isset($user['created_at']) && is_numeric($user['created_at'])) {
                    $user['created_at'] = date('Y-m-d H:i:s', $user['created_at'] / 1000);
                }
                if (isset($user['updated_at']) && is_numeric($user['updated_at'])) {
                    $user['updated_at'] = date('Y-m-d H:i:s', $user['updated_at'] / 1000);
                }
                return (object) $user;
            });

            $totalUsers = $allUsers->count();
            $recentUsers = $allUsers->take(10);
        }

        return view('admin.dashboard', compact('totalUsers', 'recentUsers'));
    }
}
