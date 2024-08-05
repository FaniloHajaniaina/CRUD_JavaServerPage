<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestion Appartement</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
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
       min-height: 100vh
   }
   .wrapper
   {
       width: 750px;
       background: rgba(255,255,255, .1);
       border: 2px solide rgba(255,255,255, .2);
       box-shadow: 0 0 10px rgba(0,0,0, .2)
        backdrop-filter: blur(100px);
       border-radius: 10px;
       color: #fff;
       padding: 40px 35px 55px;
       margin: 0 10px;
   }
  .wrapper h1 
  {
       font-size: 36px;
       text-align: center;
       margin-bottom: 20px;
  }
  .wrapper .input-box 
  {
       display: box;
       justify-content: space-between;
       flex-wrap: wrap;
       background: stateblue;
       margin-left: 0px;
  }
  .input-box .input-field 
  {
       position: relative;
       width: 100%;
       height: 40px;
       margin: 13px 0;
  }
  .input-box .input-field input 
  {
       width: 100%;
       height: 100%;
       background: #fff;
       border: 2px solid rgba(255,255,255, .2);
       font-size: 16px;
       color: #616A6B ;
       border-radius: 6px;
       padding: 15px 15px 15px 40px;
  }
  .input-box .input-field input::placeholder {
    color: #333;     
     opacity: 0.6;
}

  .wrapper .btn 
  {
        width: 100%;
        height: 45px;
        background: #1E8449;
        border: none;
        outline: none;
        border-radius: 6px;
        box-shadow: 0 0 10px rgba(0,0,0, .1);
        cursor: pointer;
        font-size: 16px;
        color: #fff;
        font-weight: 600;
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
<div class="wrapper">
      <c:if test="${apparte != null}">
           <form action="update" method="post">
      </c:if>
      <c:if test="${apparte == null}">
           <form action="insert" method="post">
      </c:if>
          <caption>
              <h1>
                 <c:if test="${apparte != null}">
                      Modification Appartement 
                 </c:if>
                 <c:if test="${apparte == null}">
                      Nouveau Appartement 
                 </c:if>
              </h1>
          </caption>
          <c:if test="${apparte != null}">
                <input type="hidden" name="id" value="<c:out value='${apparte.id}'/>"/>
           </c:if>
          <div class="input-box">
               <div class="input-field">
                    <input Type="text" placeholder="N° Appartement" name="numApp" value="<c:out value='${apparte.numApp}'/> "  required>
               </div>
               <div class="input-field">
                    <input Type="text" name="design" value="<c:out value='${apparte.design}'/> " placeholder="Design" required>
               </div>
               <div class="input-field">
                    <input Type="text" name="loyer" value="<c:out value='${apparte.loyer}'/> " placeholder="Loyer" required>
               </div>
          </div>
          <button type="submit" class="btn" id="submitBtn">Enregistrer</button>
      </form>
</div>
<script>
document.getElementById("submitBtn").addEventListener("click", function(event) {
    event.preventDefault(); 
    
    var action = "${apparte != null ? 'Modifier' : 'Ajouter'}";

    Swal.fire({
        title: 'Succès!',
        text: "L'appartement a été " + action + " avec succès!",
        icon: 'success',
        confirmButtonText: 'OK'
    }).then(function() {
        document.querySelector('form').submit();
    });
});
</script>
</body>
</html>