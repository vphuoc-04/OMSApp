<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use App\Models\Payment;
use App\Models\Cart;

class PaymentController extends Controller
{
    public function processPayment(Request $request) {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not logged in.',
            ], 401);
        }

        $validatedData = $request->validate([
            'customer_given' => 'required|numeric|min:0',
            'total_price' => 'required|numeric|min:0',
            'payment_method' => 'required|string',
        ]);

        $totalCartPrice = $validatedData['total_price'];
        $customerGivenAmount = $validatedData['customer_given'];
        $paymentMethod = $validatedData['payment_method'];

        if ($customerGivenAmount < $totalCartPrice) {
            return response()->json([
                'success' => false,
                'message' => 'Insufficient amount. Please enter a valid amount.',
            ], 400);
        }

        try {
            $changeDue = $customerGivenAmount - $totalCartPrice;

            $payment = Payment::create([
                'payment_code' => Str::uuid()->toString(),
                'user_id' => $user->id,
                'cart_id' => Cart::where('user_id', $user->id)->pluck('id')->first(),
                'amount' => $totalCartPrice,
                'customer_given' => $customerGivenAmount,
                'change_due' => $changeDue,
                'status' => 'completed',
                'payment_method' => $paymentMethod,
                'currency' => 'VND',
                'transaction_id' => Str::uuid()->toString(),
                'note' => $request->input('note', ''),
                'payment_day' => now(),
            ]);

            Cart::where('user_id', $user->id)->delete();

            return response()->json([
                'success' => true,
                'message' => 'Payment successful.',
                'change_due' => $changeDue,
                'payment' => $payment,
            ]);
        }
        catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Payment failed. Please try again.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
