<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    /** @use HasFactory<\Database\Factories\CartFactory> */
    use HasFactory;

    protected $fillable = [
        'id',
        'user_id',
        'product_id',
        'name',
        'product_code',
        'price',
        'img',
        'quantity',
        'invoice_date',
    ];
}
