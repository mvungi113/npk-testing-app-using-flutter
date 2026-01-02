<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Str;

class PostController extends Controller
{
    private function getSupabaseUrl()
    {
        return env('SUPABASE_URL') . '/rest/v1/posts';
    }

    private function getStorageUrl()
    {
        return env('SUPABASE_URL') . '/storage/v1/object/post-images/';
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
     * Display a listing of posts
     */
    public function index()
    {
        $response = Http::withHeaders($this->getHeaders())
            ->get($this->getSupabaseUrl() . '?order=created_at.desc');

        $posts = collect();
        
        if ($response->successful()) {
            $data = $response->json();
            
            if (!is_array($data)) {
                $data = [$data];
            }
            
            $posts = collect($data)->map(function ($post) {
                if (isset($post['created_at']) && is_numeric($post['created_at'])) {
                    $post['created_at'] = date('Y-m-d H:i:s', $post['created_at'] / 1000);
                }
                if (isset($post['updated_at']) && is_numeric($post['updated_at'])) {
                    $post['updated_at'] = date('Y-m-d H:i:s', $post['updated_at'] / 1000);
                }
                return (object) $post;
            });
        }

        return view('admin.posts.index', compact('posts'));
    }

    /**
     * Show the form for creating a new post
     */
    public function create()
    {
        $categories = [
            'farming_tips' => 'Farming Tips',
            'crop_diseases' => 'Crop Diseases',
            'market_prices' => 'Market Prices',
            'weather' => 'Weather Updates',
            'news' => 'Agriculture News',
            'fertilizers' => 'Fertilizers & NPK',
            'pest_control' => 'Pest Control'
        ];

        return view('admin.posts.create', compact('categories'));
    }

    /**
     * Store a newly created post
     */
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
            'category' => 'required|string',
            'status' => 'required|in:published,draft',
            'image' => 'nullable|image|max:2048' // 2MB max
        ]);

        $imageUrl = null;

        // Upload image to Supabase Storage if provided
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $filename = time() . '_' . Str::slug(pathinfo($image->getClientOriginalName(), PATHINFO_FILENAME)) . '.' . $image->getClientOriginalExtension();
            
            $uploadResponse = Http::withHeaders([
                'apikey' => env('SUPABASE_SERVICE_KEY'),
                'Authorization' => 'Bearer ' . env('SUPABASE_SERVICE_KEY'),
            ])->withBody(file_get_contents($image->getRealPath()), $image->getMimeType())
              ->post(env('SUPABASE_URL') . '/storage/v1/object/post-images/' . $filename);

            if ($uploadResponse->successful()) {
                $imageUrl = env('SUPABASE_URL') . '/storage/v1/object/public/post-images/' . $filename;
            }
        }

        $timestamp = round(microtime(true) * 1000);

        $postData = [
            'title' => $request->title,
            'content' => $request->content,
            'category' => $request->category,
            'image_url' => $imageUrl,
            'status' => $request->status,
            'views_count' => 0,
            'created_at' => $timestamp,
            'updated_at' => $timestamp
        ];

        $response = Http::withHeaders($this->getHeaders())
            ->post($this->getSupabaseUrl(), $postData);

        if ($response->successful()) {
            return redirect()->route('admin.posts.index')
                ->with('success', 'Post created successfully');
        }

        return back()->with('error', 'Failed to create post')->withInput();
    }

    /**
     * Show the form for editing the specified post
     */
    public function edit($id)
    {
        $response = Http::withHeaders($this->getHeaders())
            ->get($this->getSupabaseUrl() . '?id=eq.' . $id);

        if ($response->successful() && count($response->json()) > 0) {
            $post = (object) $response->json()[0];
            
            $categories = [
                'farming_tips' => 'Farming Tips',
                'crop_diseases' => 'Crop Diseases',
                'market_prices' => 'Market Prices',
                'weather' => 'Weather Updates',
                'news' => 'Agriculture News',
                'fertilizers' => 'Fertilizers & NPK',
                'pest_control' => 'Pest Control'
            ];

            return view('admin.posts.edit', compact('post', 'categories'));
        }

        return redirect()->route('admin.posts.index')
            ->with('error', 'Post not found');
    }

    /**
     * Update the specified post
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
            'category' => 'required|string',
            'status' => 'required|in:published,draft',
            'image' => 'nullable|image|max:2048'
        ]);

        $imageUrl = $request->current_image_url;

        // Upload new image if provided
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $filename = time() . '_' . Str::slug(pathinfo($image->getClientOriginalName(), PATHINFO_FILENAME)) . '.' . $image->getClientOriginalExtension();
            
            $uploadResponse = Http::withHeaders([
                'apikey' => env('SUPABASE_SERVICE_KEY'),
                'Authorization' => 'Bearer ' . env('SUPABASE_SERVICE_KEY'),
            ])->withBody(file_get_contents($image->getRealPath()), $image->getMimeType())
              ->post(env('SUPABASE_URL') . '/storage/v1/object/post-images/' . $filename);

            if ($uploadResponse->successful()) {
                $imageUrl = env('SUPABASE_URL') . '/storage/v1/object/public/post-images/' . $filename;
            }
        }

        $postData = [
            'title' => $request->title,
            'content' => $request->content,
            'category' => $request->category,
            'image_url' => $imageUrl,
            'status' => $request->status,
            'updated_at' => round(microtime(true) * 1000)
        ];

        $response = Http::withHeaders($this->getHeaders())
            ->patch($this->getSupabaseUrl() . '?id=eq.' . $id, $postData);

        if ($response->successful()) {
            return redirect()->route('admin.posts.index')
                ->with('success', 'Post updated successfully');
        }

        return back()->with('error', 'Failed to update post')->withInput();
    }

    /**
     * Remove the specified post
     */
    public function destroy($id)
    {
        $response = Http::withHeaders($this->getHeaders())
            ->delete($this->getSupabaseUrl() . '?id=eq.' . $id);

        if ($response->successful()) {
            return redirect()->route('admin.posts.index')
                ->with('success', 'Post deleted successfully');
        }

        return redirect()->route('admin.posts.index')
            ->with('error', 'Failed to delete post');
    }
}
