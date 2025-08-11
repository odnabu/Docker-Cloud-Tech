Docker & Cloud Tech, Veretennikov Viktar  
11.08.2025

### <div style="color: #008000">Домашнее задание 6: Exploring AWS. Account and Services overview, AWS CLi, Boto 3</div>    
1. При помощи <a style="color: #8A2BE2;">aws cli</a> создайте <a style="color: #008faf;">security group</a>: 
   - с Вашим именем и Вашей группой (например --group-name 20240915-andrew-sg),
   - описанием ("Security Group for MySQL and HTTPS and SSH”),
   - скопируйте id только что созданной sg, например, sg-092d4ec2208cc14a6.
2. При помощи <a style="color: #8A2BE2;">aws cli</a> добавьте правила входящего (inbound) трафика 
для портов 3306 (с комментарием mysql) и 443 (с комментарием https) 
для 0.0.0.0: (для всех адресов) --cidr 0.0.0.0/0.
3. В AWS Management Console (UI) - найдите свою security group и добавьте еще одно правило: 
порт 22 (SSH) для вашего IP-адреса.
   - В поле Type выберите SSH (порт 22 будет добавлен автоматически). 
   - В поле Source выберите опцию My IP — это автоматически подставит ваш текущий IP-адрес.
   - Добавьте описание в поле Description (опционально, например, “SSH My IP”). 
4. Пришлите результат выполнения команды (не забудьте указать id именно Вашей security group! ):
```
    aws ec2 describe-security-groups --group-ids sg-092d4ec2208cc14a6 --query 'SecurityGroups[*].IpPermissions' --output json]
```
5. Пришлите команды, использованные для создания security group и правил (из п. 1 и 2).
6. Удалите Вашу security group с inbound и outbound правилами.




<div style="font: bold normal 110% sans-serif; color: #8A2BE2; white-space: pre; border-top: 2px dotted #008000; padding: 5px;"></div>  

### <span style="color: #008000">Источники</span>  
<span style="color: #606060">Видео - урок от 25.06.2025</span> [<fodont color="#696969">[1 - ▶  Video 6]</font>](#v1).  
1. ▶ Video 6 "Docker 6: Exploring AWS. Account and Services overview, AWS CLi, Boto 3" (25.06.2025): 
<a id="v1">https://player.vimeo.com/video/1096215468?h=569c717c1f</a>.    
2. Presentation <a id="p1">Docker_WD_5-Clouds_AWS-20_06.pdf</a> со слайда <b style="color: darkred">89</b> 
с заданием "Создание ec2 сервера".   
3. Conspectus <a id="c1">Docker_WD_LfS5-Clouds_AWS-20_06.pdf</a> со страницы <b style="color: darkred">26</b> 
с заданием "Создание ec2 сервера".  
4. Presentation <a id="p2">Docker_WD_6-Exploring_AWS-25_06.pdf</a>.   
5. Conspectus <a id="c1">Docker_WD_LfS6-Exploring_AWS-25_06.pdf</a>  
6. Пример решения <a id="p2">Docker_WD_7-IaC_AWS_Services-25_06-25_06.pdf</a>.
7. Руководство по оформлению Markdown файлов: https://gist.github.com/Jekins/2bf2d0638163f1294637.

<div style="font: bold normal 110% sans-serif; color: #8A2BE2; white-space: pre; border-top: 2px dotted #008000; padding: 5px; margin: 40px 0 40px 0"></div>




<div style="font: bold normal 110% sans-serif; color: #8A2BE2; white-space: pre; border: 2px outset #8A2BE2; margin: 60px 0 40px 0; padding: 5px 0 5px 25px;">ДЕЙСТВИЯ</div>

## <a id="s1" style="color: #008000">1. Создание ec2 сервера в aws cli в терминале PyCharm</a>  
Пример решения см. <font color="#696969">Docker_WD_7-IaC_AWS_Services-25_06-25_06.pdf, слайд 77</font>.  
Пример "Создание ec2 сервера"  см. [<font color="#696969">[2, слайд 89]</font>](#p1) и в 
[<font color="#696969">[3, с. 26]</font>](#c1), и видео [<font color="#696969">[1 - ▶  Video 6, 0:03:40]</font>](#v1)).  
Также в задании, которе делал Женя, тоже все начиналось с создания ec2 сервера, см. [<font color="#696969">[1 - ▶  Video 6, 1:07:50]</font>](#v1)).

Немного терминологии.
1. <a style="color: #8A2BE2;">Amazon EC2 - Elastic Compute Cloud</a>
   - Описание: Предоставляет масштабируемые вычислительные мощности в облаке. Можно арендовать виртуальный сервер 
   на любое количество времени. 
   - Особенности: Различные типы виртуальных серверов - инстансов (например, общие, оптимизированные 
   для вычислений), возможность автоскалирования, поддержка различных операционных систем. 
   - Применение: Запуск виртуальных серверов для веб-приложений, больших данных, машинного обучения 
   и многого другого. 
   - Аналоги: 
     - GCP: Google Compute Engine (GCE). 
     - Azure: Azure Virtual Machines (VMs).
2. <a style="color: #8A2BE2;">aws cli</a> — AWS CLI (Command Line Interface) — это инструмент для работы с 
Amazon Web Services через терминал ([Что такое AWS CLI](https://chatgpt.com/s/t_6876ae53f9648191a7726d9fd1356895)). 
С помощью него можно управлять облачной инфраструктурой AWS: создавать, настраивать и удалять ресурсы 
(серверы, базы, хранилища и т.п.) — прямо из командной строки.

<div style="font: small-caps 120% sans-serif; color: #008000; padding: 0 15px 0 0;">▣ &nbsp;&nbsp; Пошаговое выполнение в ТЕРМИНАЛЕ Pycharm</div>
<p>
<b style="color: #F00000; border: 2px solid #6B0000; display: inline-block; padding: 10px; margin: 0 10px 0 0;"> NB ! </b> <b style="color: red;">НЕ</b> для отчета - просто для себя!

Весь процесс от входа до удаления `security group` в примере решения от [Chat](https://chatgpt.com/s/t_6899f85db40c8191b8a86cb6ba6fab02).


### **ШАГ 0 — Вход в AWS**

1. Перейди по ссылке (или просто на [https://signin.aws.amazon.com](https://signin.aws.amazon.com)).
2. Введи свой **логин (email)** и **пароль**.
3. Если есть выбор региона — выбери `eu-north-1` (__Frankfurt__) в правом верхнем углу консоли.

---

### **ШАГ 1 — Создаем Security Group через AWS CLI**
**В терминале** (например, в PyCharm или PowerShell):
```bash
aws ec2 create-security-group \
    --group-name 111124-olga-od \
    --description "Security Group for MySQL and HTTPS and SSH" \
    --region eu-north-1
```
💡 После выполнения этой команды AWS вернет JSON с ID новой security group. Например:
```json
{
    "GroupId": "sg-092d4ec2208cc14a6"
}
```
Скопируй этот `GroupId` — он нам нужен в следующих шагах.

---

### **ШАГ 2 — Добавляем inbound-правила через AWS CLI**
**Открываем порты 3306 (MySQL) и 443 (HTTPS) для всех адресов:**
```bash
aws ec2 authorize-security-group-ingress \
    --group-id sg-092d4ec2208cc14a6 \
    --protocol tcp \
    --port 3306 \
    --cidr 0.0.0.0/0 \
    --region eu-north-1

aws ec2 authorize-security-group-ingress \
    --group-id sg-092d4ec2208cc14a6 \
    --protocol tcp \
    --port 443 \
    --cidr 0.0.0.0/0 \
    --region eu-north-1
```

---

### **ШАГ 3 — Добавляем SSH доступ для своего IP в AWS Management Console**

1. В AWS Console в верхнем поиске введи `EC2` и зайди в раздел **EC2**.
2. В меню слева выбери **Security Groups**.
3. Найди свою группу по имени `111124-olga-od` и нажми на неё.
4. Перейди во вкладку **Inbound rules** → нажми **Edit inbound rules**.
5. Нажми **Add rule**:

   * **Type:** `SSH`
   * **Port Range:** (автоматически будет `22`)
   * **Source:** выбери `My IP` (AWS подставит твой текущий внешний IP)
   * **Description:** `SSH My IP` (опционально)
6. Нажми **Save rules**.

---

### **ШАГ 4 — Проверяем конфигурацию**
В терминале выполни:
```bash
aws ec2 describe-security-groups \
    --group-ids sg-092d4ec2208cc14a6 \
    --query 'SecurityGroups[*].IpPermissions' \
    --output json \
    --region eu-north-1
```

---

### **ШАГ 5 — Все команды из п.1 и п.2**

```bash
# Создание security group
aws ec2 create-security-group \
    --group-name 111124-olga-od \
    --description "Security Group for MySQL and HTTPS and SSH" \
    --region eu-north-1

# Открытие порта 3306 (MySQL)
aws ec2 authorize-security-group-ingress \
    --group-id sg-092d4ec2208cc14a6 \
    --protocol tcp \
    --port 3306 \
    --cidr 0.0.0.0/0 \
    --region eu-north-1

# Открытие порта 443 (HTTPS)
aws ec2 authorize-security-group-ingress \
    --group-id sg-092d4ec2208cc14a6 \
    --protocol tcp \
    --port 443 \
    --cidr 0.0.0.0/0 \
    --region eu-north-1
```

---

### **ШАГ 6 — Удаляем security group**
Сначала удали все inbound и outbound правила, потом саму группу.
```bash
aws ec2 delete-security-group \
    --group-id sg-092d4ec2208cc14a6 \
    --region eu-north-1
```
💡 Если AWS скажет, что группа используется — значит, она прикреплена к какому-то инстансу, нужно сначала отвязать.

<div style="font: bold normal 110% sans-serif; color: #8A2BE2; white-space: pre; border-top: 2px dotted #008000; padding: 5px; margin: 40px 0 40px 0"></div>






## <a id="s2" style="color: #008000">2. Пошаговая инструкция в AWS Console (на САЙТЕ) с РЕЗУЛЬТАТАМИ</a>  

<b style="color: #F00000; border: 2px solid #6B0000; display: inline-block; padding: 10px; margin: 0 10px 0 0;"> NB ! </b> И ПОЧЕМУ Я НЕ СДЕАЛА этого РАНЬШЕ!!!!  

Делаем всё **только через AWS Management Console** (веб-интерфейс), без AWS CLI в терминале.

### <a id="s2.1" style="color: #008000">2.1. Шаг 1 — Вход в AWS Console</a>

1. Перейди по ссылке: https://aws.amazon.com/console/.

<img src="figs/img.png" width="600" style="margin: 0 0 0 40px"/>

2. Введи свой **логин (Username)** и **пароль (Password)**.
3. Нажми кнопку **"Sign in"**.

---

### <a id="s2.2" style="color: #008000">2.2. Шаг 2 — Создание Security Group</a>  

1. После входа в консоль в поисковой строке сверху (где "Search") напиши **EC2** и нажми **Enter**.

<img src="figs/img_1.png" width="400" style="margin: 0 0 0 40px"/>

2. В меню слева выбери **Security Groups**.

<img src="figs/img_2.png" width="400" style="margin: 0 0 0 40px"/>

3. Нажми **Create security group** (кнопка вверху справа).

<img src="figs/img_3.png" width="700" style="margin: 0 0 0 40px"/>

4. Заполни поля:

   * **Security group name**: например `111124-olga-od`
   * **Description**: `Security Group for MySQL and HTTPS and SSH`
   * **VPC**: выбери тот, что по умолчанию (`default`) — если не знаешь, оставь как есть.

<img src="figs/img_4.png" width="800" style="margin: 0 0 0 40px"/>

5. Пока правила не добавляем, просто пролистываем вниз и нажимаем **Create security group**.

<img src="figs/img_5.png" width="800" style="margin: 0 0 0 40px"/>

6. После создания скопируй **Group ID** (выглядит как `sg-xxxxxxxxxxxxxxxxx`) — он пригодится.  

__sg-04a47168edaac3a78 - 111124-olga-od__

<img src="figs/img_6.png" width="800" style="margin: 0 0 0 40px"/>

---

### <a id="s2.3" style="color: #008000">2.3. Шаг 3 — Добавление правил для портов 3306 и 443 (MySQL и HTTPS)</a>

1. На странице со списком security groups кликни на **имя** своей группы (`111124-olga-od`).

<img src="figs/img_7.png" width="800" style="margin: 0 0 0 40px"/>

2. Перейди во вкладку **Inbound rules**.

<img src="figs/img_8.png" width="800" style="margin: 0 0 0 40px"/>

3. Нажми **Edit inbound rules** → **Add rule**:

<img src="figs/img_9.png" width="800" style="margin: 0 0 0 40px"/>

<img src="figs/img_10.png" width="800" style="margin: 0 0 0 40px"/>

   * **Type**: выбери **MySQL/Aurora** (порт 3306 заполнится автоматически)
   * **Source**: выбери **Anywhere-IPv4 (0.0.0.0/0)**
   * В поле **Description** впиши: `mysql`.

<img src="figs/img_11.png" width="800" style="margin: 0 0 0 40px"/>

4. Ещё раз **Add rule**:

   * **Type**: выбери **HTTPS** (порт 443 заполнится автоматически)
   * **Source**: выбери **Anywhere-IPv4 (0.0.0.0/0)**
   * В поле **Description** впиши: `https`.
   
<img src="figs/img_12.png" width="800" style="margin: 0 0 0 40px"/>

5. Нажми **Save rules**.

<img src="figs/img_13.png" width="800" style="margin: 0 0 0 40px"/>

---

### <a id="s2.3" style="color: #008000">2.4. Шаг 4 — Добавление правила для SSH (порт 22) с твоего IP</a>

1. Всё ещё в **Inbound rules** нажми **Edit inbound rules** → **Add rule**.

<img src="figs/img_14.png" width="800" style="margin: 0 0 0 40px"/>

<img src="figs/img_15.png" width="800" style="margin: 0 0 0 40px"/>

2. **Type**: выбери **SSH** (порт 22 автоматически подставится).
3. **Source**: выбери **My IP** (система сама определит твой текущий IP).
4. В **Description** впиши: `SSH My IP`.
5. Нажми **Save rules**.

<img src="figs/img_16.png" width="800" style="margin: 0 0 0 40px"/>

---

### <a id="s2.3" style="color: #008000">2.5. Шаг 5 — Проверка правил</a>

1. Открой вкладку **Inbound rules** — там должно быть 3 правила:

   * MySQL/Aurora — 0.0.0.0/0 — mysql
   * HTTPS — 0.0.0.0/0 — https
   * SSH — твой IP — SSH My IP

<img src="figs/img_17.png" width="800" style="margin: 0 0 0 40px"/>

---

### <a id="s2.3" style="color: #008000">2.6. Шаг 6 — Удаление Security Group</a>

1. Вернись в список **Security Groups**.
2. Поставь галочку напротив своей группы.

<img src="figs/img_18.png" width="800" style="margin: 0 0 0 40px"/>

3. Нажми **Actions → Delete security group**.

<img src="figs/img_19.png" width="800" style="margin: 0 0 0 40px"/>

4. Подтверди удаление.

<img src="figs/img_20.png" width="800" style="margin: 0 0 0 40px"/>

<img src="figs/img_21.png" width="800" style="margin: 0 0 0 40px"/>

<div style="font: bold normal 110% sans-serif; color: #8A2BE2; white-space: pre; border-top: 2px dotted #008000; padding: 5px;"></div>  





## <a id="s3" style="color: #008000">3. GitHub</a>
Ссылка на комментарии по ДЗ <a>description_hw06.md</a> со скриншотами: .  

Ссылка на папку с ДЗ <a>hw_06</a>: .  

---
<div style="font: bold normal 110% sans-serif; color: #8A2BE2; white-space: pre; border-top: 2px dotted #8A2BE2; padding: 5px; margin: 40px 0 40px 0"></div>

[//]: # (Строка с отступами сверху и снизу --- <div style="margin: 40px 0 40px 0">Текст</div>)

[//]: # (Подзаголовок Фиол--- <div style="font: small-caps 120% sans-serif; color: #8A2BE2; padding: 0 15px 0 0;">▣ &nbsp;&nbsp; Выполните запросы:</div>  )

[//]: # (ссылка на источник --- [<font color="#696969">[1 ▶ V-13, \__:__]</font>]\(#__\).  )

[//]: # (<span style="color: #8A2BE2; margin: 20px 40px; padding: 5px; background: #000000;">▣ ⚜️ ☑️ ✔️ 🟪 ■ ※ ⁂ ⁙ ⁘ ⨠  ■ ◲◳ ◆ ◇ ◈ ◀ ▶ ◁ ▷ ▹ ▼ ▲ ▽ △ ▢ ₪₪₪</span>  ) 

[//]: # (🔷🔹 🟩 ❇️♾️⚜️✳️❎✅☑️✔️🟪🔳🔲  )
[//]: # (■ ⁜ ※ ⁂ ⁙ ⁘ ⫷ ⫸ ⩕ ⨠ ⨝ ⋘ ⋙ ∵ ∴ ∶ ∷ ■ ◪ ◩ ◲ ◳ ◆ ◇ ◈ ▼ ▽ ◀ ▶ ◁ ▷ ▹ ▲ △ ▢ ₪₪₪  )


[//]: # (NB! --- <div style="color: #F00000; margin: 40px 20px 20px 0;">)

[//]: # (<span style="border: 2px solid #6B0000; padding: 10px;"> NB ! </span>)

[//]: # (</div>)


[//]: # (Пробел  ---  &nbsp;&nbsp; spaces)
[//]: # (Линия-разделитель с отступами --- <div style="font: bold normal 110% sans-serif; color: #8A2BE2; white-space: pre; border-top: 2px dotted #008000; padding: 5px;"></div>)


[//]: # (<div style="margin: 20px 20px 20px 0;">)

[//]: # (<b style="color: #F00000; border: 2px solid #6B0000; padding: 10px; margin: 10px 10px 10px 0;"> NB ! </b>)

[//]: # (Сначала <span style="color: red">открыть страницу</span>)

[//]: # (<span style="font: bold 130% sans-serif; color: deepskyblue; background: black; padding: 5px;">Docker Desktop!</span>)

[//]: # (</div>)

