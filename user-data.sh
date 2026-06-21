#!/bin/bash
yum update -y
yum install nginx -y
systemctl start nginx
systemctl enable nginx

# Get instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Create the HTML file
cat > /usr/share/nginx/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Resume – Cloud Engineer</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            max-width: 700px;
            width: 100%;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            transition: transform 0.3s ease;
        }
        .card:hover { transform: translateY(-5px); }
        h1 { color: #333; margin-bottom: 5px; }
        .badge {
            background: #667eea;
            color: white;
            padding: 5px 15px;
            border-radius: 30px;
            font-size: 0.8rem;
            display: inline-block;
            margin-bottom: 20px;
        }
        .section { margin: 20px 0; }
        .section h3 { color: #667eea; border-bottom: 2px solid #667eea; padding-bottom: 5px; }
        ul { padding-left: 20px; margin-top: 10px; }
        li { margin: 5px 0; }
        .footer { margin-top: 20px; font-size: 0.7rem; color: #999; text-align: center; }
        .counter {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            margin-top: 20px;
            font-weight: bold;
        }
        .counter span {
            color: #667eea;
            font-size: 1.5em;
        }
        .instance-info {
            background: #e9ecef;
            padding: 10px;
            border-radius: 8px;
            margin: 10px 0;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="card">
        <div class="badge">🚀 Cloud Engineer</div>
        <h1>Your Name</h1>
        <p>Email: your.email@example.com | GitHub: github.com/yourusername</p>
        <hr style="margin: 20px 0;">

        <div class="section">
            <h3>📋 Summary</h3>
            <p>Cloud Engineer with hands-on experience in AWS, Docker, and Linux. Passionate about building scalable, highly available systems.</p>
        </div>

        <div class="section">
            <h3>🛠️ Skills</h3>
            <ul>
                <li>AWS (EC2, S3, RDS, VPC, IAM, ALB, Auto Scaling)</li>
                <li>Docker &amp; Docker Compose</li>
                <li>Linux &amp; Bash Scripting</li>
                <li>Git &amp; GitHub</li>
            </ul>
        </div>

        <div class="section">
            <h3>📜 Certifications</h3>
            <ul>
                <li>AWS Cloud Practitioner (In Progress)</li>
            </ul>
        </div>

        <div class="instance-info">
            <p>🖥️ <strong>Instance ID:</strong> <span id="instance-id"></span></p>
            <p>📍 <strong>Availability Zone:</strong> <span id="az"></span></p>
        </div>

        <div class="counter">
            🌟 You are visitor number <span id="count">0</span>
        </div>

        <div class="footer">
            Deployed on AWS EC2 with Auto Scaling &amp; Load Balancer
        </div>
    </div>

    <script>
        let count = Math.floor(Math.random() * 100);
        document.getElementById('count').innerText = count;
    </script>
</body>
</html>
EOF

# Insert instance metadata into the HTML
sed -i "s|<span id=\"instance-id\"></span>|<span id=\"instance-id\">$INSTANCE_ID</span>|g" /usr/share/nginx/html/index.html
sed -i "s|<span id=\"az\"></span>|<span id=\"az\">$AZ</span>|g" /usr/share/nginx/html/index.html