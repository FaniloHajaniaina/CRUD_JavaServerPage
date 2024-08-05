<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<title>Gestion Appartement</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
   table, th, td
{
    padding: 1rem;
    border-collapse: collapse;
    text-align: left;
}
main.table
{
    width: 70vw;
    height: 70vh;
    background-color: #fff5;
    backdrop-filter: blur(7px);
    box-shadow: 0, .4rem, .8rem, #0005;
    border-radius: .8rem;
    overflow: hidden;
    margin-top: 5rem;
}
.table_header
{
    width: 100%;
    height: 10%;
    background-color: #fff4;
    padding: .8rem 1rem;
}
.table_body
{
    width: 95%;
    max-height: calc(89% - 1.6rem);
    background-color: #fffb;
    margin: .8rem auto;
    border-radius: .6rem;
    overflow: auto;
}
.table_body::-webkit-scrollbar
{
    width: 0.5rem;
    height: 0.5reem;
}
.table_body::-webkit-scrollbar-thumb
{
    border-radius: .5rem;
    background-color: #0004;
    visibility: hidden;
}
.table_body:hover::-webkit-scrollbar-thumb
{
    visibility: visible;
}
table
{
    width: 100%;
}
thead th
{
    position: sticky;
    top: 0;
    left: 0;
    background-color: #d5d1defe;
}
tbody tr:nth-child(even)
{
    background-color: #0000000b;
}
tbody tr:hover
{
    background-color: #fff6;
}
.status-delivred
{
    padding: 0.5rem 1rem;
    background-color: #88d69c;
    color: white;
    border-radius: 0.5rem;
    text-decoration: none;
}
.status-cancelled
{
    
    padding: 0.5rem 1rem;
    background-color: #d893a3;
    color: white;
    border-radius: 0.5rem;
    text-decoration: none;
}
.table_header a {
        padding: 0.5rem 1rem;
        background-color: #2874A6;
        color: white;
        border-radius: 0.5rem;
        text-decoration: none;
        margin-top: 1rem;
    }

    .table_header a:hover {
        background-color: #5DADE2;
    }
@media(max-width: 1000px)
{
    td:not(:first-of-type){
        min-width: 12.1rem;
    }
}
em
   {
          color: #EBC473;
   }
label
{
     display: inline-block;
     justify-content: space-between;
     align-items: center;
     color: #424949 ;
     font-size: 1.2rem;
     margin-top: 0.35rem;
     margin-left: 5rem;
}
</style>
</head>
<body>
<header class="header">
     <a href="#" class="logo"><em>Gestion</em> Appartement</a>
     <label for="" class="icons"><i class='bx bx-menu'></i></label>
     <nav class="navbar">
          <a href="<%=request.getContextPath() %>/List">Acceuil</a>
          <a href="<%=request.getContextPath() %>/diagramme">Diagramme</a>
     </nav>
</header>
<div>
     <main class="table">
          <section class="table_header">
              <div>
                 <a href="<%=request.getContextPath() %>/new">Ajouter</a>
              </div>
          </section>
          <section class="table_body">
          <table class="table">
               <thead>
                    <tr>
                        <th scope="col">N° Appartement</th>
                        <th scope="col">Design</th>
                        <th scope="col">Loyer</th>
                        <th scope="col">OBS</th>
                        <th scope="col">Action</th>
                    </tr>
               </thead>
               <tbody class="table-group-divider">
                   <c:forEach var="apparte" items="${listApparte}">
                   <tr>
                      <td><c:out value="${apparte.numApp}"/></td>
                      <td><c:out value="${apparte.design}"/></td>
                      <td><c:out value="${apparte.loyer}"/></td>
                      <td>
                      <c:choose>
                          <c:when test="${apparte.loyer < 1000}">
                               Bas
                          </c:when>
                          <c:when test="${apparte.loyer >= 1000 && apparte.loyer <= 5000}">
                               Moyen
                          </c:when>
                          <c:otherwise>
                               Élevé
                          </c:otherwise>
                     </c:choose>
                     </td>                     
                      <td><a class="status-delivred" href="edit?id=<c:out value='${apparte.id}'/>">Modifier</a>
                          &nbsp;&nbsp;&nbsp;&nbsp; 
                          <a class="status-cancelled" href="#" onclick="confirmDelete('<c:out value='${apparte.id}'/>')">Supprimer</a>
                      </td>
                    </tr>
                    </c:forEach> 
               </tbody>           
          </table>
          </section>
       </main>
       <label>Loyer maximal : <c:out value="${maxLoyer}"/></label>
       <label>Loyer minimal : <c:out value="${minLoyer}"/></label>
       <label>Total des loyers : <c:out value="${totalLoyer}"/></label>
   </div>
   <script>
function confirmDelete(id) {
    Swal.fire({
        title: 'Êtes-vous sûr de vouloir supprimer cet élément ?',
        text: 'Cette action est irréversible !',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Oui, supprimer !',
        cancelButtonText: 'Annuler'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'delete?id=' + id;
        }
    });
}
</script>
</body>
</html>