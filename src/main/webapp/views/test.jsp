<%@ page import="java.util.*" %>
<!-- Import utility classes -->

<jsp:include page="header.jsp" />
<!-- Include header -->

<%
    // Get list data from request scope
    List<String> li = (List<String>) request.getAttribute("data");

    // Print list using JSP scriptlet
    if (li != null) {
        for (String s : li) {
            out.println(s + "<br>");
        }
    }
%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!-- Set content type -->

<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!-- JSTL core tag library -->

<h3>Names List</h3>

<!-- Display list using JSTL -->
<c:forEach items="${data}" var="name">
    <c:out value="${name}" /><br>
    <p>${name}</p>
</c:forEach>

<!-- Expression Language usage -->
<p>name is ${name}</p>
<p>roll is ${roll}</p>

<!-- JSP scriptlet to get single attribute -->
<%
    String name1 = (String) request.getAttribute("name");
%>

<hr>
name is : <%= name1 %> <br>

<!-- JSTL output -->
<c:out value="${name}" />

<!-- Multiply using JSTL EL -->
multiply by using the jstl
<c:out value="${20*3}" />

<!-- Set salary in session scope -->
<c:set var="salary" scope="session" value="${20000*2}" />

<p>Salary: <c:out value="${salary}" /></p>

<!-- Conditional JSTL -->
<c:choose>
    <c:when test="${salary <= 10000}">
        <p>Salary is very low</p>
    </c:when>
    <c:otherwise>
        <p>Salary is high</p>
    </c:otherwise>
</c:choose>

<%@ page import="java.time.LocalDateTime" %>
<!-- Import LocalDateTime -->

<!-- Display using EL (Expression Language) -->
<hr>
Roll Number : ${roll} <br>
Name : ${name} <br>
Date & Time : ${now} <br>

<hr>

<!-- Display using JSP -->
<%
    String imgName = (String) request.getAttribute("name");
    Integer imgRoll = (Integer) request.getAttribute("roll");
    LocalDateTime imgDateTime = (LocalDateTime) request.getAttribute("now");
%>

<hr>
Roll Number : <%= imgRoll %> <br>
Name : <%= imgName %> <br>
Date & Time : <%= imgDateTime %> <br>
