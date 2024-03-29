# 1.	Выберите базовый образ (Д)
FROM ubuntu:latest
# 2.	Выполнить обновление apt-кеша (Д)
RUN apt-get update
# 3.	Обновить все пакеты в контейнере (Д)
RUN apt-get upgrade -y
# 4.	Установить веб сервер nginx (Д)
RUN apt-get install -y nginx
# 5.	Очистить скачанный apt-cache (Д)
RUN apt-get clean
# 6.	Удалить содержимое директории /var/www/ (Д)
RUN rm -rf /var/www/*
# 7.	Создать в директории /var/www/ директорию с именем вашего сайта и папку с картинками (my_project/img) (Д)
RUN mkdir -p /var/www/yury/
# 8.	Поместить из папки с докер файлом в директорию /var/www/ my_project файл index.html. Файл нужно создать рядом с Dockerfile и поместить туда какую-нибудь строку приветствия (Х,Д)
COPY index.html /var/www/yury
# 9.	Поместить из папки с докер файлом в директорию /var/www/my_project/img файл img.jpg (поместить туда какую-нибудь картинку). (Х,Д)
RUN mkdir -p /var/www/yury/img
COPY img.jpeg /var/www/yury/img
# 10.	Задать рекурсивно на папку /var/www/my_project права "владельцу - читать, писать, исполнять; группе - читать, исполнять, остальным - читать, исполнять" (Д)
RUN chmod -R 755 /var/www/yury
# 11.	С помощью команды useradd создать пользователя <ваше имя> (Д)
RUN useradd person
# 12.	С помощью команды groupadd создать группу <ваше имя> (Д)
RUN groupadd lab
# 13.	С помощью команды usermod поместить пользователя <ваше имя> в группу <ваше имя> (Д)
RUN usermod -a -G lab person
# 14.	Рекурсивно присвоить созданных пользователя и группу на папку /var/www/my_project (Д)
RUN chown -R person:lab /var/www/yury
# 15.	Воспользоваться конструкцией (sed -i 's/ЧТО ЗАМЕНИТЬ/НА ЧТО ЗАМЕНИТЬ/g' имя_файла) и заменить в файле /etc/nginx/sites-enabled/default следующую подстроку (/var/www/html) так, чтобы она соответствовала (/var/www/my_project) (Д)
RUN sed -i 's/\/var\/www\/html/\/var\/www\/yury/g' /etc/nginx/sites-enabled/default
# 17.	С помощью команды sed проделать операцию замены пользователя в файле, найденном в пункте 17 на вашего пользователя (Д)
RUN sed -i 's/www-data/person/g' /etc/nginx/nginx.conf
# 20.	Определите порт подключения. (Д)
EXPOSE 80
# 21.	Задайте в команды запуска веб-сервера. (Д)
CMD ["nginx","-g","daemon off;"]
