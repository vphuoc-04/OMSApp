<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login (Request $request) {
		
        $credentials = $request->only('name', 'password');
		
        if (Auth::attempt($credentials)) {
            $user = Auth::user();
			
            $token = $user->createToken('auth_token')->plainTextToken;
			
            return response()->json(['message' => 'Login Successfully', 'token' => $token], 200);
        }
        else {
            return response()->json(['message' => 'Login Failed!'], 401);
        }
    }
}