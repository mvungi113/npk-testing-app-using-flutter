@extends('layouts.app')

@section('title', 'User Details - Kilimo Admin')

@section('content')
<div class="min-h-screen bg-gray-100">
    <!-- Navigation -->
    <nav class="bg-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center space-x-8">
                    <a href="{{ route('admin.dashboard') }}" class="text-2xl font-bold text-green-600">Kilimo Admin</a>
                    <a href="{{ route('admin.users.index') }}" class="text-gray-700 hover:text-green-600 font-medium">Users</a>
                </div>
                <div class="flex items-center space-x-4">
                    <span class="text-gray-700">{{ session('admin_email') }}</span>
                    <form method="POST" action="{{ route('admin.logout') }}">
                        @csrf
                        <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg">
                            Logout
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="mb-4">
            <a href="{{ route('admin.users.index') }}" class="text-blue-600 hover:text-blue-800">← Back to Users</a>
        </div>

        <div class="bg-white rounded-lg shadow overflow-hidden">
            <div class="px-6 py-4 bg-green-600">
                <h2 class="text-2xl font-semibold text-white">User Details</h2>
            </div>

            <div class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                        <p class="text-gray-900">{{ $user->full_name ?? 'N/A' }}</p>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                        <p class="text-gray-900">{{ $user->email }}</p>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Phone Number</label>
                        <p class="text-gray-900">{{ $user->phone_number ?? 'N/A' }}</p>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Gender</label>
                        <p class="text-gray-900">{{ $user->gender ?? 'N/A' }}</p>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Country</label>
                        <p class="text-gray-900">{{ $user->country ?? 'N/A' }}</p>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Region</label>
                        <p class="text-gray-900">{{ $user->region ?? 'N/A' }}</p>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Date of Birth</label>
                        <p class="text-gray-900">{{ $user->date_of_birth ? date('Y-m-d', $user->date_of_birth / 1000) : 'N/A' }}</p>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">User ID</label>
                        <p class="text-gray-900 text-sm">{{ $user->uid }}</p>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Registered At</label>
                        <p class="text-gray-900">{{ date('Y-m-d H:i:s', $user->created_at / 1000) }}</p>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Last Updated</label>
                        <p class="text-gray-900">{{ date('Y-m-d H:i:s', $user->updated_at / 1000) }}</p>
                    </div>
                </div>

                @if($user->profile_image_url)
                    <div class="mt-6">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Profile Image</label>
                        <img src="{{ $user->profile_image_url }}" alt="Profile" class="w-32 h-32 rounded-full object-cover">
                    </div>
                @endif

                <div class="mt-8 flex space-x-4">
                    <form method="POST" action="{{ route('admin.users.destroy', $user->uid) }}" onsubmit="return confirm('Are you sure you want to delete this user? This action cannot be undone.');">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="bg-red-600 hover:bg-red-700 text-white px-6 py-2 rounded-lg">
                            Delete User
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
