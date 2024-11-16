<?php

namespace App\Http\Controllers;

use App\Models\Cart;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CartController extends Controller
{
    // Add to cart
    public function addToCart(Request $request) {
        $user = Auth::user();

        if (!$user) {
            return response()->json(['message' => 'User not logged in'], 401);
        }

        if (empty($request->user_id)) {
            return response()->json(['message' => 'User ID is missing'], 400);
        }

        $cartItem = Cart::create([
            'user_id' => $user->id,
            'product_id' => $request->product_id,
            'name' => $request->name,
            'price' => $request->price,
            'img' => $request->img,
            'invoice_date' => now(),
        ]);

        return response()->json([
            'message' => 'Product added to cart',
            'cartItem' => $cartItem
        ], 201);
    }

    // Get data cart
    public function getDataCart(Request $request) {
        $cart = Cart::all();

        return response()->json($cart);
    }
}
