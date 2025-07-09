_10_06_les03_docker  

## ВАЖНО - последовательность действий  

1. Запустить Docker Desktop! 
2. Название папки с приложением было как в командах кодов:  
   См. Docker_WD_LfS3-10_06.pdf, с. 8.  

Создать папку в проекте:
```
mkdir my-nginx
```
Перейти в папку с Dockerfile:
```
cd my-nginx
```
Потом собирать image (NB! на __точку__ в конце команды):
```
docker build -t my-nginx .
```
где "my-nginx" -- имя ПРИЛОЖЕНИЯ.  

И запустить контейнер:
```
docker run -d -p 8080:80 --name my-running-nginx my-nginx
```
где "my-running-nginx" -- имя КОНТЕЙНЕРА в Docker.


3. Запустить контейнер из Docker Desktop ---> откроется веб-страница.
4. ПЕРЕГРУЗИТЬ (обновить) страницу в БРАУЗЕРЕ!
5. Остановить контейнер:
```
docker stop my-running-nginx
```


---
index.html
```html
<!DOCTYPE html>
<html>
<head>
    <title>Hello ICH!</title>
</head>
<body>
    <h1>Success! The NGINX server is working!</h1>
</body>
</html>
```
---
Dockerfile

```dockerfile
# Используем официальный образ NGINX в качестве базового
FROM nginx:latest
# Копируем наш файл index.html в директорию, где NGINX ищет свои статические файлы
COPY index.html /usr/share/nginx/html/
# Указываем, что контейнер будет слушать на порту 80
EXPOSE 80
#NGINXпоумолчаниюзапускаетсяскомандойCMD["nginx","-g","daemonoff;"]
```

