<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Geek News</title>
    <link rel="stylesheet" href="http://bootstraptema.ru/plugins/2015/bootstrap3/bootstrap.min.css" />
    <link rel="stylesheet" href="http://bootstraptema.ru/plugins/font-awesome/4-4-0/font-awesome.min.css" />
    <link rel="stylesheet" href="/resources/css/comments.css"/>

    <c:url var="addComment" value="/news/post/addComment"/>

    <sec:authorize access="isAuthenticated()">
    <c:set var="username"><sec:authentication property="principal.username" /></c:set>
    </sec:authorize>

    <spring:url value="/resources/scripts/jquery-1.11.1.js" var="jquery_url" />
    <spring:url value="/resources/scripts/jquery-ui-1.10.4.custom.min.js"
                var="jquery_ui_url" />
    <spring:url value="/resources/styles/custom-theme/jquery-ui-1.10.4.custom.css"
                var="jquery_ui_theme_css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${jquery_ui_theme_css}" />
    <script src="${jquery_url}" type="text/javascript"><jsp:text/></script>
    <script src="${jquery_ui_url}" type="text/javascript"><jsp:text/></script>

    <script>
    $(document).ready(function() {
    $("#addButton").click(function () {
        var myComment = {
            comment : $("#commentFromForm").val(),
            username: $("#usernameFromCommentFrom").val(),
            postId :$("#postIdFromCommentForm").val()
    };
    $.ajax({
        type: 'POST',
        url: "addComment",
        contentType: 'application/json',
        data: JSON.stringify(myComment),
    success:function(response){
        location.reload();
        $("#commentFromForm").val('');
        },
    error:function (xhr, ajaxOptions, thrownError){
        alert(thrownError);
    }
            });
        });
    });
    </script>
</head>
<body>
<div class="container">
    <%--Main menu--%>
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

    <%--Post--%>

    <h2 class="text-center">${post.title}</h2>
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <img class="img-responsive men" src="/news/photo/${post.id}" alt="Фото отсутствует" />
            <p style="line-height:2">${post.body}</p>
            <sec:authorize access="hasRole('ROLE_ADMIN')">
            <a href="/news/admin/updatePost/${post.id}" class="btn btn-info">Редактировать</a>
            <a href="/news/admin/deletePost/${post.id}" class="btn btn-danger">Удалить</a>
            </sec:authorize>
    <div class="clearfix"></div>
        </div>
    </div>


    <%--Add comment--%>
    <section class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="panel">
                    <div class="panel-body">
                        <sec:authorize access="isAuthenticated()">
                            <form action="" method="POST">
                            <textarea name="comment" id="commentFromForm" class="form-control" rows="2" placeholder="Добавьте Ваш комментарий"></textarea>
                            <input type="text" name="username" id="usernameFromCommentFrom" value="<sec:authentication property="principal.username"/>" hidden="hidden" >
                            <input type="number" name="postId" id="postIdFromCommentForm" value="${post.id}" hidden="hidden">
                        <div class="mar-top clearfix">
                                <input type="button" value="Добавить" id="addButton" class="btn btn-sm btn-primary pull-right"/>
                        </div>
                            </form>
                        </sec:authorize>
                    </div>
                </div>
            </div>

            <%--All comments--%>
            <div class="panel">
                <div class="panel-body">
                    <c:if test="${!empty commentList}">
            <c:forEach items="${commentList}" var="comment">
                  <p><img class="img-circle img-sm" alt="Профиль пользователя" src="http://bootstraptema.ru/snippets/icons/2016/mia/1.png"></p>
                  <div class="media-body">
                          <i>${comment.user.userName}</i>
                                <p class="text-muted text-sm">${comment.createDate}</p>
                      </div>
                      <p>${comment.comment}</p>
                <sec:authorize access="isAuthenticated()">
                        <c:if test="${username.equals(comment.user.userName)}">
                            <a href="/news/post/${post.id}/deleteComment/${comment.id}" class="btn btn-danger">Удалить</a>
                        </c:if>
                </sec:authorize>
                    </c:forEach>
                    </c:if>
                    <c:if test="${empty commentList}">
                        <p>На данный момент коментарии к этой новости отсутствуют</p>
                    </c:if>
                </div>
            </div>
        </div>
    </section>
</div>

</body>
</html>