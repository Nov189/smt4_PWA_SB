<?php

namespace App\Http\Controllers;
use Str;
use Illuminate\Http\Request;
use App\Models\User;
class RegisterController extends Controller
{
    public function register()
    {
        return view('register');
    }
    public function simpanregister(Request $request)
    {
        // dd($request->all());
        User::create([
            'name' => $request->name,
            'email'=> $request->email,
            'password' => bcrypt($request->password),
            'remember_token'=> Str::random(60),
        ]);
    }
}
