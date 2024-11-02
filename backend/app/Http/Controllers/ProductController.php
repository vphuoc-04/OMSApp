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
}
