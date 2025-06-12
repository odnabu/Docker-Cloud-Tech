# Используем официальный образ Node.js в качестве базового:
FROM node:18-slim

# Указывыаем рабочую директорию:
WORKDIR /usr/src/app

# Копируем файл package.json в директорию, где Node.js ищет свои статические файлы:
COPY package*.json ./

# Запускаем приложение:
RUN npm install --only=production

# Копируем файл с кодом app.js в директорию, где Node.js ищет свои файлы:
COPY app.js ./

# Запускаем Node.js:
CMD ["npm", "start"]
