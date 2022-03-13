<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB:: table ('products')->insert({
            'unid' =>  str ::unid(),
            'category_id' => 1,
            'name' => '\n',
            'slug' =>  '\n',
            'prince' => '\n'
                });
    }
}
