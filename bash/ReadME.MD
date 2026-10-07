## Git_analyzer
### Установка скрипта [git_analyzer](/scripting/git_analyzer.sh) 

Для установки потребуется утилита `curl`

И для использования скрипта нужно наделить его правами с помощью `chmod`
```shell
curl -O https://raw.githubusercontent.com/demoh544/mfua/refs/heads/main/scripting/git_analyzer.sh
chmod +x git_analyzer.sh
```
### Возможности
Скрипт [git_analyzer](/bash/github-stats.sh) способен анализировать гит репозиторий и выводить его параметры такие как
- Название репозитория
- Звезды
- Форки
- Open Issues
- Автор 
- Активность
### Пример 

Запуск скрипта
```bash
bash git_analyzer.sh ~/путь_до_репозитория
```
Вывод скрипта

![Вывод](/images/mibombo.png)

## Простые скрипты
### script1
Вы вводите свое имя и скрипт его выдает

![Вывод](/images/taskone.png)
### script2
Выводит сумму двух чисел

![Вывод](/images/tasktwo.png)
### script3
Вы вводите число а скрипт выводит четное оно или нет

![Вывод](/images/taskthree.png)
### script4
Создает структуру веб-приложения

![Вывод](/images/taskfour.png)
### script5 
Вы вводите файл а скрипт выводит количество строк в файле

![Вывод](/images/taskfive.png)
### script6 
Создает простой пароль из восьми символов

![Вывод](/images/tasksix.png)
### script7 
Вы вводите расширение файла а скрипт выдает все файлы с этим расширением

![Вывод](/images/taskseven.png)