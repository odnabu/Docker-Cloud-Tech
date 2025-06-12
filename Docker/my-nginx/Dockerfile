# Используем официальный образ NGINX в качестве базового
FROM nginx:latest

# Копируем наш файл index.html в директорию, где NGINX ищет свои статические файлы
COPY index.html /usr/share/nginx/html/

# Указываем, что контейнер будет слушать на порту 80
EXPOSE 80
#NGINX поумолчанию запускаетсяс командой CMD["nginx","-g","daemonoff;"]
