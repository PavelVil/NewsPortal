<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Geek News</title>
    <spring:url value="/resources/css/bootstrap.css" var="bootstrap"/>
    <link href="${bootstrap}" rel="stylesheet" />
    <link href="/resources/css/grid.css" rel="stylesheet">
</head>
<body>
<div class="container">
<spring:url var="loginUrl" value="/j_spring_security_check" />
<spring:url var="logoutUrl" value="/j_spring_security_logout" />

    <div class="masthead">
        <h3 class="text-muted">Geek News</h3>
        <nav>
        <ul class="nav navbar-nav">
            <li><a href="/news/main">Главная</a></li>
            <c:if test="${!empty categoryList}">
                <c:forEach items="${categoryList}" var="category">
                    <li><a href="/news/category/${category.id}">${category.name}</a> </li>
                </c:forEach>
            </c:if>
        </ul>
            <div id="navbar" class="navbar-collapse collapse">
                <%--Autorization form--%>
                <sec:authorize access="isAnonymous()">
                <form class="form-inline" action="${loginUrl}" method="post">
                    <div class="form-group">
                        <label class="sr-only" for="exampleInputEmail3">Логин</label>
                        <input type="text" name="j_username" class="form-control" id="exampleInputEmail3" placeholder="Email">
                    </div>
                    <div class="form-group">
                        <label class="sr-only" for="exampleInputPassword3">Пароль</label>
                        <input type="password" name="j_password" class="form-control" id="exampleInputPassword3" placeholder="Password">
                    </div>
                    <div class="checkbox">
                        <label>
                            <input  id="remember_me"  name="remember-me-param" type="checkbox"/> Запомнить
                        </label>
                    </div>
                    <button type="submit" class="btn btn-success">Войти</button>
                    <a href="/news/registration" class="btn btn-info">Регистрация</a>
                    <c:if test="${message ne null}">${message}</c:if>
                </form>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">Добро пожаловать,
                    <sec:authentication property="principal.username" />
                <a href="${logoutUrl}" class="btn btn-danger">Выйти</a>
                </sec:authorize>
            </div>
        </nav>
    </div>

    <div class="jumbotron">
        <%--<h1></h1>--%>
        <img src="http://cgccomicsblog.com/wp-content/uploads/2013/08/cropped-marvel.jpg" width="960" height="200"/>
        <p class="lead">Добро пожаловать на Geek News! Здесь вы сможете узнать последние новости из мира кино, комиксов, а так же ближайшие гиг-события!</p>
    </div>

    <%--Post list--%>
    <div class="row">

    <c:forEach items="${postList}" var="post">
    <%--<div class="col-md-3 team-grid-left">--%>
        <div class="col-xs-12 col-md-6">

            <c:if test="${empty post.photo}">
        <img class="img-responsive men" src="http://globens.net/upload/no_photo.png" width="400" height="250" alt="Фото отсутствует" />
        </c:if>
        <c:if test="${!empty post.photo}">
            <img class="img-responsive men" src="/news/photo/${post.id}" width="400" height="250" alt="Фото отсутствует" />
        </c:if>
        <h4>${post.title}</h4>
        <p>${post.summary}</p>
        <%--<div class="arrow-para">--%>
            <div class="col-xs-12 col-md-6">
            <p><a class="btn btn-primary" href="/news/post/${post.id}" role="button">Читать &raquo;</a>
        </div>
        </div>
    </c:forEach>
    </div>
        <%--Pagination--%>
    <div class="pagination">
        <ul class="pagination">
            <c:url value="/news/main" var="prev">
                <c:param name="page" value="${page-1}"/>
            </c:url>
            <c:if test="${page > 1}">
                <li class="page-item"><a href="<c:out value="${prev}" />" class="pn prev">Назад</a></li>
            </c:if>
            <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                <c:choose>
                    <c:when test="${page == i.index}">
                        <c:url value="/news/main" var="url"/>
                        <li class="page-item"><a href='<c:out value="${url}"/>'>${i.index}</a></li>
                    </c:when>
                    <c:otherwise>
                        <c:url value="/news/main" var="url">
                            <c:param name="page" value="${i.index}"/>
                        </c:url>
                        <li class="page-item"><a href='<c:out value="${url}" />'>${i.index}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:url value="/news/main" var="next">
                <c:param name="page" value="${page + 1}"/>
            </c:url>
            <c:if test="${page + 1 <= maxPages}">
                <li class="page-item"><a href='<c:out value="${next}" />' class="pn next">Вперед</a></li>
            </c:if>
        </ul>
    </div>

</div>
</body>
</html>
