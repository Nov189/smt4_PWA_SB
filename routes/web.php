<?php

use App\Http\Controllers\LoginController;
use App\Http\Controllers\RegisterController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/index', [HomeController::class, 'index']);
Route::get('/jadwal', [HomeController::class, 'calendar']);
Route::get('/login', [LoginController::class, 'login']);
Route::get('/gantipassword', [HomeController::class, 'gantipassword']);
Route::post('/postlogin', [LoginController::class, 'postlogin']);
Route::get('/register', [RegisterController::class, 'register']);
Route::post('/simpanregister', [RegisterController::class, 'simpanregister']);