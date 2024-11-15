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
        // Xác thực dữ liệu đầu vào
        $validated = $request->validate([
            'product_id' => 'required|exists:products,id',   // Kiểm tra nếu sản phẩm tồn tại
            'name' => 'required|string|max:255',               // Kiểm tra tên sản phẩm
            'price' => 'required|numeric',                     // Kiểm tra giá trị là số
            'quantity' => 'required|integer|min:1',            // Kiểm tra số lượng sản phẩm phải là số và >= 1
        ]);

        // Kiểm tra xác thực người dùng
        $user = Auth::user();

        // Nếu không có người dùng đăng nhập
        if (!$user) {
            return response()->json(['message' => 'User not logged in'], 401);
        }

        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        $existingCartItem = Cart::where('user_id', $user->id)
                                ->where('product_id', $request->product_id)
                                ->first();

        // Nếu sản phẩm đã có trong giỏ hàng
        if ($existingCartItem) {
            // Cập nhật số lượng sản phẩm
            $existingCartItem->quantity += $request->quantity;
            $existingCartItem->save();

            return response()->json([
                'message' => 'Product quantity updated in cart',
                'cartItem' => $existingCartItem
            ], 200);
        }

        // Thêm sản phẩm mới vào giỏ hàng
        $cartItem = Cart::create([
            'user_id' => $user->id,
            'product_id' => $request->product_id,
            'name' => $request->name,
            'price' => $request->price,
            'quantity' => $request->quantity,
            'invoice_date' => now(),
        ]);

        return response()->json([
            'message' => 'Product added to cart',
            'cartItem' => $cartItem
        ], 201);
    }

}
