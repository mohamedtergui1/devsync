<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
</head>
<body>
<h2>Login</h2>
<form action="login" method="POST">
  <label for="username">Username (or Email):</label>
  <input type="text" id="username" name="username" required><br><br>
  <label for="password">Password:</label>
  <input type="password" id="password" name="password" required><br><br>
  <button type="submit">Login</button>
</form>

<%-- If there's an error message, display it --%>
<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
<% if (errorMessage != null) { %>
<p style="color: red;"><%= errorMessage %></p>
<% } %>

</body>
</html>
