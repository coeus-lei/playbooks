server {
    listen      80;
    server_name  example.com;

    access_log  ./logs/example.com.access.log  main;

    location / {
        proxy_set_header Host $host:80;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Via "nginx";

            if ($ip_block_apiopen = 1) {
                proxy_pass http://ali;
                break;
            }
            return 403;

        }
    include ./vhosts/common.txt;
}