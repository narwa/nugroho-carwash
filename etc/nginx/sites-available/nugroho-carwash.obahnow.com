server {
    listen 80;
    listen [::]:80;
    server_name nugroho-carwash.obahnow.com www.nugroho-carwash.obahnow.com;

    # Security Headers
    add_header X-Frame-Options "DENY" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    add_header Content-Security-Policy "default-src 'self'; script-src 'self' https://cdn.jsdelivr.net; style-src 'self' https://cdn.jsdelivr.net 'unsafe-inline'; img-src 'self' data: https://www.google.com; font-src 'self' https://fonts.gstatic.com; frame-src 'self' https://www.google.com; connect-src 'self' https://wa.me; form-action 'self' https://wa.me;" always;
    add_header Permissions-Policy "geolocation=(), midi=(), sync-xhr=(), microphone=(), camera=(), magnetometer=(), gyroscope=(), fullscreen=(self), payment=()" always;
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

    location / {
        proxy_pass https://nugroho-carwash.netlify.app;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # Enable WebSocket support if needed
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    # SSL configuration would go here if you add certificates
    # listen 443 ssl;
    # ssl_certificate /path/to/cert.pem;
    # ssl_certificate_key /path/to/key.pem;
    # include /etc/letsencrypt/options-ssl-nginx.conf;
}

# Redirect HTTP to HTTPS (uncomment after SSL setup)
# server {
#     listen 80;
#     server_name nugroho-carwash.obahnow.com www.nugroho-carwash.obahnow.com;
#     return 301 https://$host$request_uri;
# }