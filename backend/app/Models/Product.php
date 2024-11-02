<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    /** @use HasFactory<\Database\Factories\ProductFactory> */
    use HasFactory;
    protected $fillable = [
        'added_by',
        'product_code',
        'name',
        'description',
        'img',
        'quantity',
        'price',
        'original_price',
        'category_id',
        'status',
        'weight',
        'length',
        'width',
        'height',
        'attributes',
        'date_added',
        'expiry_date',
        'spiciness_level',
    ];

    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }
}
