<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

 class CategoriaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('categories')->insert([
            'unid'=>Str::uuid(),
            'name'=>'Frutas',
            'slug'=>'frutas'
        ]);

        DB::table('categories')->insert([
            'unid'=>Str::uuid(),
            'name'=>'Creme e Geleias',
            'slug'=>'creme-e-geleias'
        ]);
    }  
}

