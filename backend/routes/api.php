<?php

use Illuminate\Support\Facades\Route;

// Auth
use App\Http\Controllers\AuthController;

// User
use App\Http\Controllers\UserController;

// Product
use App\Http\Controllers\ProductController;

// Cart
use App\Http\Controllers\CartController;

// Auth api
Route::post('/login', [AuthController::class, 'login']);

// User api
Route::get('/user/{id}', [UserController::class, 'getUserById']);
Route::post('/user/{id}/upload-avatar', [UserController::class, 'updateAvatar']);
Route::delete('/user/{id}/delete-avatar', [UserController::class, 'deleteAvatar']);

// Product api
Route::get('/product/all', [ProductController::class,  'getAllProduct']);
Route::get('/product/category/{categoryId}', [ProductController::class, 'getProductsByCategory']);
Route::get('/product/search', [ProductController::class, 'searchProduct']);

// Cart api
Route::middleware('auth:sanctum')->group(function () {
    Route::get('cart/data', [CartController::class, 'getDataCart']);
    Route::post('cart/add', [CartController::class, 'addToCart']);
    Route::delete('cart/delete/{id}', [CartController::class, 'deleteDataCart']);
    Route::put('cart/change/quantity/{id}', [CartController::class, 'changeQuantityProductCart']);
});


