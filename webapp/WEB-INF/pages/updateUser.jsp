<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Geek News</title>
</head>
<body>
<sec:authorize access="hasRole('ROLE_ADMIN')">
<form:form action="/news/admin/updateUserInfo" commandName="user">
<input type="hidden" name="update" value="update" hidden="hidden">
<form:label path="userName">
    <spring:message text="LOGIN"/>
</form:label>
<form:input path="userName" readonly="true" size="8" disabled="true"/>
<form:hidden path="userName"/>

<form:label path="password">
    <spring:message text="PASSWORD"/>
</form:label>
<form:input path="password" readonly="true" size="8" disabled="true"/>
<form:hidden path="password"/>

    <form:checkbox path="enabled" checked="checked" hidden="hidden"/>

    <select name="role">
        <option value="ROLE_USER" selected="selected">ROLE_USER</option>
        <option value="ROLE_ADMIN">ROLE_ADMIN</option>
    </select>

    <input type="submit" value="Обновить">
</form:form>
</sec:authorize>
</body>
</html>
