<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="{{ asset('css/style.css') }}" rel="stylesheet" type="text/css" >
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
</head>
<body>
<div class="top-bar">
        <div class="leftside">
            <p>Badminton Jaya<p>
        </div>
        
        <div class="menu">
            <ul>
            <a href="#">Home</a>
            <a href="#">Jadwal</a>
            <a href="#">Data</a>
        </div>
</div>

<div class="login">
    <p>Login</p>
    <form action="postlogin" method="POST">
    {{ csrf_field() }}
    <div class="input-group">
        <label for="username">Username :</label>
        <input type="text" id="username" name="email" required>
    </div>

    <div class="input-group">
        <label for="password">Password :</label>
        <input type="password" id="password" name="password" required>
    </div>
    
    <button type="submit">Login</button>
</form>

</div>
</body>
</html>