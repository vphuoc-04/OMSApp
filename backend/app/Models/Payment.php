<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    /** @use HasFactory<\Database\Factories\PaymentFactory> */
    use HasFactory;

    protected $fillable = [
        'id',
        'payment_code',
        'user_id',
        'cart_id',
        'amount',
        'customer_given',
        'change_due',
        'status',
        'payment_method',
        'currency',
        'transaction_id',
        'note',
        'payment_day'
    ];
}
