<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Shop Application</title>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .error-container { max-width: 600px; margin: 0 auto; }
        .error-title { color: #d32f2f; font-size: 24px; margin-bottom: 20px; }
        .error-message { background: #ffebee; padding: 20px; border-radius: 4px; }
        .back-link { margin-top: 20px; }
        .back-link a { color: #1976d2; text-decoration: none; }
    </style>
</head>
<body>
    <div class="error-container">
        <h1 class="error-title">Application Error</h1>
        <div class="error-message">
            <p>The application encountered an error. This might be due to:</p>
            <ul>
                <li>Database connection issues</li>
                <li>Missing database setup</li>
                <li>Configuration problems</li>
            </ul>
            <p><strong>To fix this:</strong></p>
            <ol>
                <li>Make sure MySQL is running on localhost:3306</li>
                <li>Create a database named 'shopee'</li>
                <li>Run the database migrations</li>
            </ol>
        </div>
        <div class="back-link">
            <a href="/">← Back to Home</a>
        </div>
    </div>
</body>
</html>