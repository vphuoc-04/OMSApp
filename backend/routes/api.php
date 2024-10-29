<?php

use Illuminate\Support\Facades\Route;

// Auth
use App\Http\Controllers\AuthController;

// User
use App\Http\Controllers\UserController;

// Auth api
Route::post('/login', [AuthController::class, 'login']);

// User api
Route::get('/user/{id}', [UserController::class, 'getUserById']);
Route::post('/user/{id}/upload-avatar', [UserController::class, 'updateAvatar']);
Route::delete('/user/{id}/delete-avatar', [UserController::class, 'deleteAvatar']);
