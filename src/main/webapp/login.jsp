<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />

<html>
<head>
    <title>Main Page</title>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet" />

</head>
<body>
<div class="min-h-screen flex justify-center flex-col items-center" >

    <form action="login" method="POST">
        <div>
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div>
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div>
            <button type="submit">Login</button>
        </div>


    </form>


</div>

<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>
