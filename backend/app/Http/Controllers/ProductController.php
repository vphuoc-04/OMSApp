<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    public function getAllProduct(Request $request) {
        $product = Product::all();

        return response()->json($product);
    }

    public function getProductsByCategory($categoryId) {
        $products = Product::where('category_id', $categoryId)->get();
        return response()->json($products);
    }
}
