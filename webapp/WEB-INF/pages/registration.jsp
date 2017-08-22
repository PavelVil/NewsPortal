<%--
  Created by IntelliJ IDEA.
  User: Pavel
  Date: 12.08.2017
  Time: 13:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Geek News</title>
    <spring:url value="/resources/css/bootstrap.css" var="bootstrap"/>
    <link href="${bootstrap}" rel="stylesheet" />
    <link href="/resources/css/signin.css" rel="stylesheet">
</head>
<body>
<div class="container">
<form:form action="/news/addUser" commandName="user" class="form-signin">
    <div class="form-group">
        <h2 class="form-signin-heading">Регистрация</h2>
        <form:label path="userName" class="sr-only">
            <spring:message text="Логин"/>
        </form:label>
        <form:input path="userName" class="form-control" placeholder="Логин"/>
        <form:errors path="userName"/>
    </div>
    <div class="form-group">
        <form:label path="password" class="sr-only">
            <spring:message text="Пароль"/>
        </form:label>
        <form:password path="password" class="form-control" placeholder="Пароль"/>
        <form:errors path="password"/>
    </div>
    <select name="role" hidden="hidden">
        <option value="ROLE_USER" selected="selected">ROLE_USER</option>
        <option value="ROLE_ADMIN">ROLE_ADMIN</option>
    </select>
    <form:checkbox path="enabled" checked="checked" hidden="hidden"/>
    <input type="submit" class="btn btn-lg btn-primary btn-block" value="Регистрация">
</form:form>
</div>
</body>
</html>
