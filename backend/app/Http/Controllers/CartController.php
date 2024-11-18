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

        $quantity = $request->quantity;
        $price = $request->price;

        $finalPrice = $price * $quantity;

        $cartItem = Cart::create([
            'user_id' => $user->id,
            'product_id' => $request->product_id,
            'name' => $request->name,
            'price' => $finalPrice,
            'img' => $request->img,
            'quantity' => $quantity,
            'invoice_date' => now(),
        ]);

        return response()->json([
            'message' => 'Product added to cart',
            'cartItem' => $cartItem
        ], 201);
    }

    // Get data cart
    public function getDataCart(Request $request) {
        $user = Auth::user();

        if (!$user) {
            return response()->json(['message' => 'User not logged in'], 401);
        }

        $cart = Cart::where('user_id', $user->id)->get();

        return response()->json($cart, 200);
    }

    // Delete data cart
    public function deleteDataCart (Request $request, $id) {
        $user = Auth::user();

        if (!$user) {
            return response()->json(['message' => 'User not logged in'], 401);
        }

        $cartItem = Cart::where('id', $id)
            ->where('user_id', $user->id)
            ->first();

        if (!$cartItem) {
            return response()->json(['message' => 'Cart item not found'], 404);
        }

        try {
            $cartItem->delete();
            return response()->json(['message' => 'Cart item deleted successfully'], 200);
        }
        catch (\Exception $e) {
            return response()->json(['message' => 'Fail to delete cart item', 'error' => $e->getMessage()], 500);
        }
    }

    // Change quantity product in cart
    public function changeQuantityProductCart(Request $request, $id) {
        try {
            $user = Auth::user();

            if (!$user) {
                return response()->json(['message' => 'User not logged in'], 401);
            }

            $request->validate([
                'quantity' => 'required|integer|min:1',
            ]);

            $quantity = $request->input('quantity');

            $cartItem = Cart::where('user_id', $user->id)->where('id', $id)->first();

            if (!$cartItem) {
                return response()->json(['message' => 'Cart item not found'], 404);
            }

            $currentPrice = $cartItem->price;

            $currentQuantity = $cartItem->quantity;

            $unitPrice = $currentPrice / $currentQuantity;

            $newPrice = $unitPrice * $quantity;

            $cartItem->quantity = $quantity;

            $cartItem->price = $newPrice;

            $cartItem->save();

            return response()->json(['message' => 'Cart item quantity updated successfully', 'cart_item' => $cartItem], 200);

        }
        catch (\Exception $e) {
            return response()->json([
                'message' => 'An error occurred while updating the cart item.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
