<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Top Destinations</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            max-width: 400px;
            width: 100%;
        }
        .login-header {
            background: linear-gradient(45deg, #2196F3, #21CBF3);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .login-header h1 {
            font-size: 2em;
            margin-bottom: 10px;
        }
        .login-form {
            padding: 40px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        .form-group input {
            width: 100%;
            padding: 15px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        .form-group input:focus {
            outline: none;
            border-color: #2196F3;
        }
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .remember-me input[type="checkbox"] {
            width: auto;
        }
        .forgot-link {
            color: #2196F3;
            text-decoration: none;
            font-size: 14px;
        }
        .forgot-link:hover {
            text-decoration: underline;
        }
        .login-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(45deg, #2196F3, #21CBF3);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            cursor: pointer;
            transition: transform 0.3s;
            margin-bottom: 20px;
        }
        .login-btn:hover {
            transform: translateY(-2px);
        }
        .signup-link {
            text-align: center;
            color: #666;
        }
        .signup-link a {
            color: #2196F3;
            text-decoration: none;
            font-weight: bold;
        }
        .signup-link a:hover {
            text-decoration: underline;
        }
        .social-login {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
        .social-login p {
            color: #666;
            margin-bottom: 15px;
        }
        .social-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        .social-btn {
            padding: 10px 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: white;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .social-btn:hover {
            background: #f8f9fa;
            transform: translateY(-2px);
        }
        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1><i class="fa fa-user"></i> Login</h1>
            <p>Welcome back to Top Destinations</p>
        </div>

        <div class="login-form">
            <%
                String error = request.getParameter("error");
                if (error != null && error.equals("true")) {
            %>
                <div class="error-message">
                    Invalid username or password. Please try again.
                </div>
            <%
                }
            %>

            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>

                <div class="remember-forgot">
                    <div class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">Remember me</label>
                    </div>
                    <a href="#" class="forgot-link">Forgot password?</a>
                </div>

                <button type="submit" class="login-btn">
                    <i class="fa fa-sign-in"></i> Login
                </button>
            </form>

            <div class="signup-link">
                Don't have an account? <a href="signup.jsp">Sign up here</a>
            </div>

            <div class="social-login">
                <p>Or login with</p>
                <div class="social-buttons">
                    <button class="social-btn">
                        <i class="fa fa-google"></i> Google
                    </button>
                    <button class="social-btn">
                        <i class="fa fa-facebook"></i> Facebook
                    </button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
