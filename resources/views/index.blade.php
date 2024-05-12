<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
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
            <a href="index">Home</a>
            <a href="jadwal">Jadwal</a>
            <a href="data">Data</a>
        </div>

        <div class="admin">
            <p>Selamat Datang Admin!!</p>
        </div>

        <div class="dropdown">
           <span class="material-symbols-outlined">menu</span>
                <div class="dropdown-content">
                  <a href="gantipassword">Data Akun</a>
                  <a href="login">Log Out</a>
         </div>
</div>
</div>

<div class="content">
        <div>
            <h2>KALENDER</h2>
            <p>nanti isinya kalender jadwal pesan lapangan per minggu</p>
        </div>
        <div>
            <h2>Stok Barang</h2>
            <p>menampilkan stok barang</p>
        </div>
        <div>
            <h2>Lapangan 1</h2>
            <p>Menampilkan siapa yang main di lap 1</p>
        </div>
        <div>
            <h2>Lapangan 2</h2>
            <p>menampilkan siapa yang main di lap 2</p>
        </div>
    </div>
</body>
</html>