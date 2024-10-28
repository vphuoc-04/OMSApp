<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function getUserById($id) {
        $user = User::find($id);

        if ($user) {
            return response()->json([
                'id' => $user->id,
                'img' => $user->img,
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
}
