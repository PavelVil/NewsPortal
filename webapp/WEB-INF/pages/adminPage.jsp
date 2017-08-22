<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Geek News</title>

    <spring:url value="/resources/scripts/jquery-1.11.1.js" var="jquery_url" />
    <spring:url value="/resources/scripts/jquery-ui-1.10.4.custom.min.js"
                var="jquery_ui_url" />
    <spring:url value="/resources/styles/custom-theme/jquery-ui-1.10.4.custom.css"
                var="jquery_ui_theme_css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${jquery_ui_theme_css}" />
    <script src="${jquery_url}" type="text/javascript"><jsp:text/></script>
    <script src="${jquery_ui_url}" type="text/javascript"><jsp:text/></script>

    <!--CKEditor-->
    <spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor_url" />
    <spring:url value="/resources/ckeditor/adapters/jquery.js" var="ckeditor_jquery_url" />
    <script type="text/javascript" src="${ckeditor_url}"><jsp:text/></script>
    <script type="text/javascript" src="${ckeditor_jquery_url}"><jsp:text/></script>

    <spring:url value="/resources/css/bootstrap.css" var="bootstrap"/>
    <link href="${bootstrap}" rel="stylesheet" />

    <script type="text/javascript">
        $(function(){
            $("#newsContent").ckeditor(
                {
                    toolbar : 'Basic',
                    uiColor : '#CCCCCC'
                }
            );
        });
    </script>

    <style>
        input[type=file]{
            display: none;
        }
    </style>

</head>
<body>
<sec:authorize access="hasRole('ROLE_ADMIN')">
<%--Add/Update posts--%>
<h4>Добавить пост</h4>
<div>
<c:url var="addPostAction" value="/news/admin/addPost"/>
    <form:form action="${addPostAction}" commandName="post" enctype="multipart/form-data">
        <c:if test="${!empty post.title}">
            <div class="form-group">
                <form:label path="id">
                    <spring:message text="ID"/>
                </form:label>
                <form:input path="id" readonly="true" size="8" disabled="true"/>
                <form:hidden path="id"/>
                <img class="img-responsive men" src="/news/photo/${post.id}" alt="Фото отсутствует" />
            </div>
        </c:if>
        <div class="form-group">
            <form:label path="title">
                <spring:message text="Заголовок"/>
            </form:label>
            <form:input path="title"/>
            <form:errors path="title"/>
        </div>
        <div class="form-group">
            <form:label path="summary">
                <spring:message text="Краткое изложение"/>
            </form:label>
            <form:textarea path="summary"/>
            <form:errors path="summary"/>
        </div>
        <div class="form-group">
            <form:label path="body">
                <spring:message text="Текст новости"/>
            </form:label>
            <form:textarea cols="60" rows="8" path="body" id="newsContent"/>
            <form:errors path="body"/>
        </div>
        <div class="form-group">
                    <form:label path="category">
                    <spring:message text="Категория"/>
                    </form:label>
                <select name="categoryOnPost">
                    <c:if test="${!empty post.title}">
                        <option selected = "true">${post.category.name}</option>
                    </c:if>
                    <c:if test="${empty post.title}">
                   <c:forEach items="${categoryList}" var="category">
                        <option>${category.name}</option>
                    </c:forEach>
                    </c:if>
                </select>
        </div>
        <c:if test="${empty post.title}">
    <div class="form-group">
        <input type="file" name="file" id="post-photo">
        <label for="post-photo" class="btn">Выбрать фото</label>
    </div>
        </c:if>
        <c:if test="${!empty post.title}">
            <input type="file" name="file" id="post-photo-not-null">
            <label for="post-photo-not-null" class="btn">Обновить фото</label>
    </c:if>
        <c:if test="${empty post.title}">
            <input type="submit"
                   value="<spring:message text="Добавить пост"/>" class="btn"/>
        </c:if>
        <c:if test="${!empty post.title}">
            <input type="submit"
                   value="<spring:message text="Редактировать пост"/>" class="btn"/>
        </c:if>
        <c:if test="${empty post.title}">
            <input type="reset" value="Отмена" class="btn">
        </c:if>
        <c:if test="${!empty post.title}">
            <a href="/news/main" class="btn">Отмена</a>
        </c:if>
    </form:form>
</div>
<br>
<h3>Доступные категории</h3>
<c:forEach items="${categoryList}" var="category">
<ul class="list-group">
    <li class="list-group-item">${category.name}
        <a href="/news/admin/updateCategory/${category.id}">Редактировать</a>
        <a href="/news/admin/deleteCategory/${category.id}">Удалить</a></li>
</c:forEach>
<%--Add/Update category--%>
    <h4>Добавить категорию</h4>
<c:url var="addCategoryAction" value="/news/admin/addCategory"/>
<form:form action="${addCategoryAction}" commandName="category">
    <c:if test="${!empty category.name}">
        <div class="form-group">
            <form:label path="id">
                <spring:message text="ID"/>
            </form:label>
            <form:input path="id" readonly="true" size="8" disabled="true"/>
            <form:hidden path="id"/>
        </div>
    </c:if>
    <div class="form-group">
    <form:label path="name">
        <spring:message text="Название"/>
    </form:label>
    <form:input path="name"/>
    <form:errors path="name"/>
    </div>
    <c:if test="${empty category.name}">
    <input type="submit"
           value="<spring:message text="Добавить категорию"/>" class="btn"/>
    </c:if>
    <c:if test="${!empty category.name}">
    <input type="submit"
           value="<spring:message text="Редактировать категорию"/>" class="btn"/>
    </c:if>
    <c:if test="${empty category.name}">
    <input type="reset" value="Отмена" class="btn">
    </c:if>
    <c:if test="${!empty category.name}">
    <a href="/news/main" class="btn">Отмена</a>
    </c:if>
    </form:form>
    <%--All users--%>
    <table class="table table-striped">
        <th>Логин</th>
        <th>Доступен</th>
        <th>Редактировать</th>
        <th>Удалить</th>
        <c:forEach items="${userList}" var="user">
            <tr>
            <td>${user.userName}</td>
                <c:if test="${user.enabled}"><td>Да</td></c:if>
                <c:if test="${!user.enabled}"><td>Нет</td></c:if>
            <td><a href="/news/admin/updateUser/${user.userName}">Редактировать</a> </td>
                <td><a href="/news/admin/available/${user.userName}">Поменять доступность</a></td>
            <td><a href="/news/admin/deleteUser/${user.userName}">Удалить</a> </td>
            </tr>
        </c:forEach>
    </table>
    </sec:authorize>
</body>
</html>
