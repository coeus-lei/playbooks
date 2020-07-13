server {
	listen       80;
	server_name  ssl-example.com;
	access_log  ./logs/ssl-exapmle.access.log  main;
	rewrite ^(.*)$ https://$host$1 permanent;
}
server {
	listen      443 ssl http2 default_server;
	ssl on;
    ssl_certificate      /usr/local/nginx/conf/ssl/wgle5.com/c8979709781fdced.crt;
    ssl_certificate_key  /usr/local/nginx/conf/ssl/wgle5.com/wgle5.com.key;
	server_name  ssl-example.com;
    location ~ /test {
        root /usr/local/nginx/conf/html/main;
        index index.html;
    }
	include ./vhosts/example/ssl_template.txt;
}