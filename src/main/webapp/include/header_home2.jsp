<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
  .carousel-inner img {
    width: 100%;
    height: 100%;
  }
</style>
<!-- <div id="demo" data-ride="carousel" class="carousel slide jumbotron text-center" style="margin-bottom:0; height:160px; padding:40px 0 0;"> -->
<div id="demo" data-ride="carousel" class="carousel slide jumbotron text-center" style="margin-bottom:0; height:220px; padding:0px;">
  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
    <li data-target="#demo" data-slide-to="1"></li>
    <li data-target="#demo" data-slide-to="2"></li>
  </ul>
  <!-- <h1>길동이 JSP 프로젝트</h1>
  <p>(본 프로젝트는 반응형으로 제작되었습니다.)</p> -->
  
  <!-- The slideshow -->
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="images/61.jpg" alt="Los Angeles" width="1100" height="500">
    </div>
    <div class="carousel-item">
      <img src="images/62.jpg" alt="Chicago" width="1100" height="500">
    </div>
    <div class="carousel-item">
      <img src="images/63.jpg" alt="New York" width="1100" height="500">
    </div>
  </div>
  
  <!-- Left and right controls -->
  <a class="carousel-control-prev" href="#demo" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#demo" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
</div>