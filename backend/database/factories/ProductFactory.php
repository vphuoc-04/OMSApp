<?php

namespace Database\Factories;

use App\Models\Product;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    protected $model = Product::class;

    public function definition(): array
    {
        return [
            'added_by' => null,
            'product_code' => strtoupper(Str::random(10)),
            'name' => $this->faker->words(3, true),
            'description' => $this->faker->sentence(),
            'img' => $this->faker->imageUrl(640, 480, 'food', true),
            'quantity' => $this->faker->numberBetween(1, 100),
            'price' => $this->faker->randomFloat(2, 5, 100),
            'original_price' => $this->faker->randomFloat(2, 5, 100),
            'category_id' => $this->faker->numberBetween(1, 5),
            'status' => $this->faker->randomElement(['available', 'out_of_stock', 'discontinued']),
            'weight' => $this->faker->randomFloat(2, 0.1, 5),
            'length' => $this->faker->randomFloat(2, 1, 100),
            'width' => $this->faker->randomFloat(2, 1, 100),
            'height' => $this->faker->randomFloat(2, 1, 100),
            'attributes' => json_encode(['spicy' => $this->faker->boolean(), 'vegan' => $this->faker->boolean()]),
            'date_added' => $this->faker->date(),
            'expiry_date' => $this->faker->dateTimeBetween('+1 week', '+1 year'),
            'spiciness_level' => $this->faker->numberBetween(0, 10),
        ];
    }
}
