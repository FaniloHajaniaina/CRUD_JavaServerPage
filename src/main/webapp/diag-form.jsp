<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestion Appartement</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
<style>
* {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: sans-serif;
   }
   body 
   {
       min-height: 100vh;
       background: linear-gradient(#72B2E4, #92E1E2) ;
       display: flex;
       justify-content: center;
       align-items: center;
   }
   .header
   {
       position: fixed;
       top: 0;
       left: 0;
       width: 100%;
       padding: 1.3rem 10%;
       background: rgba(0,0,0, .1);
       backdrop-filter: blur(50px);
       display: flex;
       justify-content: space-between;
       align-items: center;
       z-index: 100;
   }
   .logo
   {
       font-size: 2rem;
       color: #4D5656;
       text-decoration: none;
       font-weight: 700;
   }
   .navbar a
   {
       font-size: 1.15rem;
       color: #212F3C;
       text-decoration: none;
       font-weight: 500;
       margin-left: 2.5rem;
   }
   .navbar a:hover
   {
       color: #fff;
       font-size: 1.20rem;
   }
   .icons 
   {
       position: absolute;
       font-size: 2.8rem;
       right: 5%;
       color: #fff;
       cursor: pointer;
       display: none;
   }
   
   @media (max-width: 992px) {
       .header {
            padding: 1.3rem 5%;
       }
   }
   
   @media (max-width: 768px) {
       .icons {
            display: inline-flex;
       }
       
       .navbar {
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            height: 17.7rem;
            background: rgba(0,0,0, .1);
            backdrop-filter: blur(50px);
       }
       
       .navbar a {
            display: block;
            font-size: 1.1rem;
            margin: 1.5rem 0;
       }
   }
   em
   {
          color: #EBC473;
   }
 main.board {
    display: inline;
}
.blockDroite {
    width: 50%;
    display: inline;
}
.blockGauche {
    width: 50%;
    display: inline-block;
    margin-left: 4rem;
    margin-top: 3rem;
}
.blockDroite {
    width: 30%;
    display: inline-block;
    margin-left: 50rem;
    margin-top:-28rem;
}
canvas {
    width: 100%;
    height: 70vh;
    background-color: #fff5;
    backdrop-filter: blur(7px);
    box-shadow: 0, .4rem, .8rem, #0005;
    border-radius: .8rem;
    overflow: hidden;
    margin-top: 5rem;
}
</style>
</head>
<body>
<header class="header">
     <a href="#" class="logo"><em>Gestion</em> Appartement</a>
     <label for="" class="icons"><i class='bx bx-menu'></i></label>
     <nav class="navbar">
          <a href="<%=request.getContextPath() %>/List">Acceuil</a>
          <a href="<%=request.getContextPath() %>/List">Diagramme</a>
     </nav>
</header> 
<div>
    <main class="board">
         <div class="blockGauche"><canvas id="myChart"></canvas></div>         
         <div class="blockDroite"><canvas id="pieChart"></canvas></div>
    </main>
</div>
<script>
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Loyer maximal', 'Loyer minimal', 'Total des loyers'],
            datasets: [{
                label: 'Loyers',
                data: [<%= request.getAttribute("maxLoyer") %>, <%= request.getAttribute("minLoyer") %>, <%= request.getAttribute("totalLoyer") %>],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    
    var pieCtx = document.getElementById('pieChart').getContext('2d');
    var pieChart = new Chart(pieCtx, {
        type: 'pie',
        data: {
        	labels: ['Loyer maximal', 'Loyer minimal', 'Total des loyers'],
            datasets: [{
                label: 'Loyers',
                data: [<%= request.getAttribute("maxLoyer") %>, <%= request.getAttribute("minLoyer") %>, <%= request.getAttribute("totalLoyer") %>],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
   </script>
</body>
</html>