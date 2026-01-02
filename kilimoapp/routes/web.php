<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminAuthController;
use App\Http\Controllers\AdminDashboardController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\PostController;

// Redirect root to admin login
Route::get('/', function () {
    return redirect()->route('admin.login');
});

// Admin Authentication Routes
Route::prefix('admin')->group(function () {
    // Public routes (login)
    Route::get('/login', [AdminAuthController::class, 'showLogin'])->name('admin.login');
    Route::post('/login', [AdminAuthController::class, 'login'])->name('admin.login.submit');
    
    // Protected routes (require authentication)
    Route::middleware(['admin.auth'])->group(function () {
        Route::get('/dashboard', [AdminDashboardController::class, 'index'])->name('admin.dashboard');
        Route::post('/logout', [AdminAuthController::class, 'logout'])->name('admin.logout');
        
        // User Management
        Route::prefix('users')->group(function () {
            Route::get('/', [UserController::class, 'index'])->name('admin.users.index');
            Route::get('/{id}', [UserController::class, 'show'])->name('admin.users.show');
            Route::delete('/{id}', [UserController::class, 'destroy'])->name('admin.users.destroy');
        });

        // Post Management
        Route::prefix('posts')->group(function () {
            Route::get('/', [PostController::class, 'index'])->name('admin.posts.index');
            Route::get('/create', [PostController::class, 'create'])->name('admin.posts.create');
            Route::post('/', [PostController::class, 'store'])->name('admin.posts.store');
            Route::get('/{id}/edit', [PostController::class, 'edit'])->name('admin.posts.edit');
            Route::put('/{id}', [PostController::class, 'update'])->name('admin.posts.update');
            Route::delete('/{id}', [PostController::class, 'destroy'])->name('admin.posts.destroy');
        });
    });
});
