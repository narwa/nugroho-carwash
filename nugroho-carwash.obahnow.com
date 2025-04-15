server {
    server_name nugroho-carwash.obahnow.com www.nugroho-carwash.obahnow.com;

    location / {
        # Force IPv4 for upstream connection
        resolver 8.8.8.8 ipv6=off;
        
        # Specify IPv4 proxy pass
        proxy_pass https://nugroho-carwash.netlify.app$request_uri;
        
        # Existing headers
        proxy_set_header Host 'nugroho-carwash.netlify.app';
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Add error handling
        proxy_next_upstream error timeout http_500 http_502 http_503 http_504;
        proxy_next_upstream_tries 2;
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;

        # Existing WebSocket support
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    # SSL configuration (managed by Certbot)
    listen [::]:443 ssl ipv6only=on;
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/nugroho-carwash.obahnow.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/nugroho-carwash.obahnow.com/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
}

# Redirect HTTP to HTTPS
server {
    listen 80;
    listen [::]:80;
    server_name nugroho-carwash.obahnow.com www.nugroho-carwash.obahnow.com;
    
    # Remove the if condition and 404 return, replace with direct 301 redirect
    return 301 https://$host$request_uri;
}