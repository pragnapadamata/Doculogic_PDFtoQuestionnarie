<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Top Destinations</title>
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
        .signup-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            max-width: 450px;
            width: 100%;
        }
        .signup-header {
            background: linear-gradient(45deg, #4CAF50, #45a049);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .signup-header h1 {
            font-size: 2em;
            margin-bottom: 10px;
        }
        .signup-form {
            padding: 40px;
        }
        .form-group {
            margin-bottom: 20px;
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
            border-color: #4CAF50;
        }
        .password-strength {
            height: 5px;
            background: #ddd;
            border-radius: 3px;
            margin-top: 5px;
            overflow: hidden;
        }
        .password-strength-bar {
            height: 100%;
            width: 0;
            transition: width 0.3s, background-color 0.3s;
        }
        .strength-weak {
            background: #f44336;
            width: 33%;
        }
        .strength-medium {
            background: #ff9800;
            width: 66%;
        }
        .strength-strong {
            background: #4CAF50;
            width: 100%;
        }
        .terms-checkbox {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 25px;
        }
        .terms-checkbox input[type="checkbox"] {
            width: auto;
            margin-top: 3px;
        }
        .terms-checkbox label {
            font-size: 14px;
            color: #666;
            line-height: 1.4;
        }
        .terms-checkbox a {
            color: #4CAF50;
            text-decoration: none;
        }
        .terms-checkbox a:hover {
            text-decoration: underline;
        }
        .signup-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(45deg, #4CAF50, #45a049);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            cursor: pointer;
            transition: transform 0.3s;
            margin-bottom: 20px;
        }
        .signup-btn:hover {
            transform: translateY(-2px);
        }
        .login-link {
            text-align: center;
            color: #666;
        }
        .login-link a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
        .social-signup {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
        .social-signup p {
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
        .success-message {
            background: #e8f5e8;
            color: #2e7d32;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <div class="signup-header">
            <h1><i class="fa fa-user-plus"></i> Sign Up</h1>
            <p>Create your account with Top Destinations</p>
        </div>

        <div class="signup-form">
            <%
                String error = request.getParameter("error");
                String success = request.getParameter("success");
                
                if (error != null && error.equals("true")) {
            %>
                <div class="error-message">
                    Username already exists. Please choose a different username.
                </div>
            <%
                }
                
                if (success != null && success.equals("true")) {
            %>
                <div class="success-message">
                    Account created successfully! Please login to continue.
                </div>
            <%
                }
            %>

            <form action="SignupServlet" method="post">
                <div class="form-group">
                    <label for="fullname">Full Name</label>
                    <input type="text" id="fullname" name="fullname" required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required oninput="checkPasswordStrength(this.value)">
                    <div class="password-strength">
                        <div class="password-strength-bar" id="passwordStrength"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" placeholder="+91 98765 43210">
                </div>

                <div class="terms-checkbox">
                    <input type="checkbox" id="terms" name="terms" required>
                    <label for="terms">
                        I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
                    </label>
                </div>

                <button type="submit" class="signup-btn">
                    <i class="fa fa-user-plus"></i> Create Account
                </button>
            </form>

            <div class="login-link">
                Already have an account? <a href="login.jsp">Login here</a>
            </div>

            <div class="social-signup">
                <p>Or sign up with</p>
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

    <script>
        function checkPasswordStrength(password) {
            const strengthBar = document.getElementById('passwordStrength');
            let strength = 0;
            
            if (password.length >= 8) strength++;
            if (password.match(/[a-z]/) && password.match(/[A-Z]/)) strength++;
            if (password.match(/[0-9]/)) strength++;
            if (password.match(/[^a-zA-Z0-9]/)) strength++;
            
            strengthBar.className = 'password-strength-bar';
            
            if (password.length === 0) {
                strengthBar.style.width = '0';
            } else if (strength <= 1) {
                strengthBar.classList.add('strength-weak');
            } else if (strength === 2) {
                strengthBar.classList.add('strength-medium');
            } else {
                strengthBar.classList.add('strength-strong');
            }
        }

        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match. Please try again.');
                return false;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long.');
                return false;
            }
        });
    </script>
</body>
</html>
