<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class UserController extends Controller
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
            'Prefer' => 'return=representation'
        ];
    }

    /**
     * Display a listing of users
     */
    public function index()
    {
        $response = Http::withHeaders($this->getHeaders())
            ->get($this->getSupabaseUrl() . '?order=created_at.desc');

        if ($response->successful()) {
            $data = $response->json();
            
            // Handle both array and single object responses
            if (!is_array($data)) {
                $data = [$data];
            }
            
            $users = collect($data)->map(function ($user) {
                // Convert timestamps from milliseconds to readable format
                if (isset($user['created_at']) && is_numeric($user['created_at'])) {
                    $user['created_at'] = date('Y-m-d H:i:s', $user['created_at'] / 1000);
                }
                if (isset($user['updated_at']) && is_numeric($user['updated_at'])) {
                    $user['updated_at'] = date('Y-m-d H:i:s', $user['updated_at'] / 1000);
                }
                return (object) $user;
            });

            return view('admin.users.index', compact('users'));
        }

        return view('admin.users.index', ['users' => collect()]);
    }

    /**
     * Display the specified user
     */
    public function show($id)
    {
        $response = Http::withHeaders($this->getHeaders())
            ->get($this->getSupabaseUrl() . '?uid=eq.' . $id);

        if ($response->successful() && count($response->json()) > 0) {
            $user = $response->json()[0];
            
            // Convert timestamps
            $user['created_at'] = isset($user['created_at']) 
                ? date('Y-m-d H:i:s', $user['created_at'] / 1000) 
                : null;
            $user['updated_at'] = isset($user['updated_at']) 
                ? date('Y-m-d H:i:s', $user['updated_at'] / 1000) 
                : null;
            
            $user = (object) $user;
            return view('admin.users.show', compact('user'));
        }

        return redirect()->route('admin.users.index')
            ->with('error', 'User not found');
    }

    /**
     * Remove the specified user
     */
    public function destroy($id)
    {
        $response = Http::withHeaders($this->getHeaders())
            ->delete($this->getSupabaseUrl() . '?uid=eq.' . $id);

        if ($response->successful()) {
            return redirect()->route('admin.users.index')
                ->with('success', 'User deleted successfully');
        }

        return redirect()->route('admin.users.index')
            ->with('error', 'Failed to delete user');
    }
}
