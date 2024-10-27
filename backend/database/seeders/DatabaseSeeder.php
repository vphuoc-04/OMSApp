<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Carbon\Carbon;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        User::factory()->create([
            'img' => env('SEEDER_IMG'),
            'firstname' => env('SEEDER_FIRSTNAME'),
            'lastname' => env('SEEDER_LASTNAME'),
            'name' => env('SEEDER_NAME'),
            'birth' => Carbon::parse(env('SEEDER_BIRTH')),
            'email' => env('SEEDER_EMAIL'),
            'phone' => env('SEEDER_PHONE'),
            'job_title' => env('SEEDER_JOB_TITLE'),
            'password' => Hash::make(env('SEEDER_PASSWORD')),
        ]);
    }
}
