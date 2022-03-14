<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class ProdutoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('categories')->insert([
            'unid'=>Str::unid(),
            'category_id'=> 1 ,
            'name'=>'Abacaxi',
            'slug'=>'abacaxi',
            'price'=> 10.00
        ]);

        DB::table('categories')->insert([
            'unid'=>Str::unid(),
            'category-id'=> 1 ,
            'name'=>'Creme e Geleias',
            'slug'=>'creme-e-geleias',
            'price'=> 8.00
        ]);
    }
}
