FROM fedora:latest

RUN dnf install -y nginx && dnf clean all

COPY html/ /usr/share/nginx/html/

CMD ["nginx", "-g", "daemon off;"]
