<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<html lang="en"> <!--<![endif]-->
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<head>
    <meta charset="utf-8" />
    <title>Страница не найдена</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <!-- Template CSS -->

    <!-- Responsive CSS -->
    <spring:url value="/resources/css/respons.css" var="res"/>
    <link href="${res}" rel="stylesheet" />
    <spring:url value="/resources/css/style404.css" var="style404"/>
    <link href="${style404}" rel="stylesheet" />
    <link href="/resources/images/favicon.ico" rel="shortcut icon" />
    <!-- Google Fonts -->
    <link href='https://fonts.googleapis.com/css?family=Raleway:300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>

</head>
<body>

    <!-- Load page -->
    <div class="animationload">
        <div class="loader">
        </div>
    </div>
    <!-- End load page -->

    <!-- Content Wrapper -->
    <div id="wrapper">
        <div class="container">
            <!-- Switcher -->
            <div class="switcher">
                <input id="sw" type="checkbox" class="switcher-value">
                <label for="sw" class="sw_btn"></label>
                <div class="bg"></div>
                <div class="text"><span class="text-l">On</span><span class="text-d">Off</span><br />light</div>
            </div>
            <!-- End Switcher -->

            <!-- Dark version -->
            <div id="dark" class="row text-center">
                <div class="info">
                    <img src="/resources/images/404.png" alt="404 error" />
                </div>
            </div>
            <!-- End Dark version -->

            <!-- Light version -->
            <div id="light" class="row text-center">
                <!-- Info -->
                <div class="info">
                    <img src="/resources/images/404.gif" alt="404 error" />
                    <h4>Похоже, что такой страницы не существует.</h4>
                    <a href="/news/main" class="btn">На главную</a>
                    <%--<a href="#" class="btn btn-brown">Contact</a>--%>
                </div>
                <!-- end Info -->
            </div>
            <!-- End Light version -->

        </div>
        <!-- end container -->
    </div>
    <!-- end Content Wrapper -->

    <!-- Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="/resources/js/modernizr.custom.js" type="text/javascript"></script>
    <script src="/resources/s/jquery.nicescroll.min.js" type="text/javascript"></script>
    <script src="/resources/js/scripts.js" type="text/javascript"></script>


</body>
</html>