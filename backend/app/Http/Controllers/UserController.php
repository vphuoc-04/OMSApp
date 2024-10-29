<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    // Get user data
    public function getUserById($id) {
        $user = User::find($id);

        $avatar = $user->img ? (filter_var($user->img, FILTER_VALIDATE_URL) ? $user->img : asset('storage/' . $user->img)) : null;

        if ($user) {
            return response()->json([
                'id' => $user->id,
                'img' => $avatar,
                'firstname' => $user->firstname,
                'lastname' => $user->lastname,
                'name' => $user->name,
                'birth' => $user->birth,
                'email' => $user->email,
                'phone' => $user->phone,
                'job_title' => $user->job_title,
            ], 200);
        }
        else {
            return response()->json([
                'status' => 'error',
                'message' => 'User not found'
            ], 404);
        }
    }

    // Update user avatar
    public function updateAvatar(Request $request, $id) {
        $validator = Validator::make($request->all(), [
            'avatar' => 'required|image|mimes:jpg,jpeg,png|max:20480'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => $validator->errors()
            ], 400);
        }

        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User not found'
            ], 404);
        }

        if ($request->hasFile('avatar')) {
            if ($user->img) {
                Storage::delete($user->img);
            }

            $path = $request->file('avatar')->store('manager/avatars', 'public');
            $user->img = $path;

            $user->save();

            return response()->json([
                'status' => 'success',
                'message' => 'Avatar uploaded successfully',
                'img' => asset('storage/' . $user->img)
            ], 200);
        }
        return response()->json([
            'status' => 'error',
            'message' => 'No file uploaded'
        ], 400);
    }

    // Delete user avatar
    public function deleteAvatar(Request $request, $id) {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User not found'
            ], 404);
        }

        $defaultAvatar = env('SEEDER_IMG');

        if ($user->img) {
            $imgPath = str_replace('storage/', '', $user->img);

            if (Storage::disk('public')->exists($imgPath)) {
                if (Storage::disk('public')->delete($imgPath)) {
                    $user->img = $defaultAvatar;
                    $user->save();
                    return response()->json([
                        'status' => 'success',
                        'message' => 'Avatar deleted successfully, reset to default.',
                        'img' => $defaultAvatar
                    ], 200);
                }
                else {
                    return response()->json([
                        'status' => 'error',
                        'message' => 'Failed to delete image from storage.'
                    ], 500);
                }
            }
            else {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Image does not exist in storage.'
                ], 404);
            }
        }

        return response()->json([
            'status' => 'info',
            'message' => 'No avatar to delete, reset to default.'
        ], 200);
    }
}
