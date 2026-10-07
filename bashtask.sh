# 1. Приветствие пользователя
echo "=== 1. Приветствие ==="
read -p "Введите ваше имя: " username
echo "Привет, $username! Добро пожаловать."
echo ""

# 2. Калькулятор суммы
echo "=== 2. Калькулятор суммы ==="
read -p "Введите первое число: " num1
read -p "Введите второе число: " num2
# Простая проверка на числа
if [[ $num1 =~ ^[0-9]+$ ]] && [[ $num2 =~ ^[0-9]+$ ]]; then
    sum=$((num1 + num2))
    echo "Сумма чисел: $sum"
else
    echo "Ошибка: Введены не целые числа!"
fi
echo ""

# 3. Проверка четности числа
echo "=== 3. Проверка четности ==="
read -p "Введите число для проверки: " check_num
if [[ $check_num =~ ^[0-9]+$ ]]; then
    if [ $((check_num % 2)) -eq 0 ]; then
        echo "Число $check_num — ЧЕТНОЕ."
    else
        echo "Число $check_num — НЕЧЕТНОЕ."
    fi
else
    echo "Ошибка: Это не целое число!"
fi
echo ""

# 4. Создатель структуры проектов
echo "=== 4. Создатель структуры веб-проекта ==="
read -p "Введите название проекта (папки): " project_name
if [ -z "$project_name" ]; then
    project_name="my-project"
fi

mkdir -p "$project_name/css" "$project_name/js"
touch "$project_name/index.html"
touch "$project_name/css/style.css"
touch "$project_name/js/script.js"

echo "Структура '$project_name/' успешно создана!"
echo ""

# 5. Счетчик строк в файле
echo "=== 5. Счетчик строк ==="
read -p "Введите путь к файлу для подсчета строк (например, tools.sh): " filename
if [ -f "$filename" ]; then
    lines_count=$(wc -l < "$filename")
    echo "Файл '$filename' не найден."
fi
echo ""

# 6. Генератор паролей
echo "=== 6. Генератор паролей ==="
# Генерация 8 случайных символов из букв и цифр
password=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 8)
echo "Ваш случайный пароль (8 символов): $password"

# 7. Поиск файлов по расширению
echo "=== 7. Поиск файлов ==="
read -p "Введите расширение для поиска (например, sh, html, css): " ext
echo "Найденные файлы с расширением .$ext в текущей директории:"
find . -maxdepth 1 -type f -name "*.$ext"

