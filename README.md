# devops-lab9 Bredikhin Illia 4CS-31


## Як запустити це завдання 

1. Запустити setup-скрипт

        ./run-instance.sh

2. Підключаємся до instance і заодно відкриваємо ssh tunnel

        ssh -i MyKey.pem ubuntu@ip -L 5566:127.0.0.1:2375

---

## Що робить скрипт

- Оновлює пакети системи
- Встановлює Docker (docker.io)
- Вимикає docker.socket
- Створює override-конфігурацію для Docker service
- Налаштовує Docker на прослуховування:
  - Unix socket
  - TCP 127.0.0.1:2375
- Перезавантажує systemd
- Вмикає та запускає Docker service
- Додає користувача ubuntu до групи docker

---

## Як перевірити результат (Success criteria)

1. Перевірити, що Docker запущений

        systemctl status docker

Очікуваний результат:
active (running)

2. Перевірити, що docker.socket вимкнений (вимикаємо docker.socket для того щоб докер слухав твій порт)

        systemctl status docker.socket

Очікуваний результат:
inactive (dead) або disabled

3. Перевірити параметри запуску Docker

        ps aux | grep dockerd

Очікуваний результат:
dockerd запущений з параметрами:
--host=unix:///var/run/docker.sock
--host=tcp://127.0.0.1:2375

Команда повинна виконуватись без помилки permission denied.

## Перевіряємо чи тунель слухає порт

        sudo ss -tlnp | grep dockerd

## Після всіх перевірок будуємо docker image

        docker -H localhost:5566 build -t mynginx ./docker

## Стартуємо контейнер 

        docker -H tcp://127.0.0.1:5566 run -d -p 80:80 mynginx

## Переходимо на нашу сторінку в браузер щоб побачити нашу html сторінку

        http://ip

---

## Очікуваний результат

- Docker встановлений та запущений
- Docker daemon працює через Unix socket і TCP
- docker.socket вимкнений
- Користувач ubuntu має доступ до Docker без sudo
- Docker готовий до локальних та автоматизованих підключень
- Через ip instance ми в браузері бачимо html сторінку
