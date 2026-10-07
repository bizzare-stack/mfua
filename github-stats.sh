
# Цветовые коды ANSI
RESET="\033[0m"
BOLD="\033[1m"
YELLOW="\033[33m"
GREEN="\033[32m"
RED="\033[31m"
CYAN="\033[36m"

# Проверка наличия утилит curl и jq
for cmd in curl jq; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${RED}Ошибка:${RESET} Утилита ${BOLD}$cmd${RESET} не установлена. Установите её (sudo apt install $cmd)."
        exit 1
    fi
done

# Проверка аргумента командной строки
REPO=$1
if [ -z "$REPO" ]; then
    echo -e "${RED}Ошибка:${RESET} Не указан репозиторий!"
    echo -e "Использование: $0 имя_автора/имя_репозитория"
    echo -e "Пример: $0 tensorflow/tensorflow"
    exit 1
fi

# Запрос к GitHub API
API_URL="https://github.com"
RESPONSE=$(curl -s -w "\n%{http_code}" "$API_URL")

# Разделение тела ответа и HTTP-статуса
HTTP_BODY=$(echo "$RESPONSE" | sed '$d')
HTTP_STATUS=$(echo "$RESPONSE" | tail -n1)

# Обработка ошибок API
if [ "$HTTP_STATUS" -ne 200 ]; then
    echo -e "${RED}Ошибка при обращении к GitHub API (Статус: $HTTP_STATUS)${RESET}"
    MESSAGE=$(echo "$HTTP_BODY" | jq -r '.message' 2>/dev/null)
    if [ "$MESSAGE" = "Not Found" ]; then
        echo -e "Репозиторий ${BOLD}$REPO${RESET} не найден. Проверьте правильность написания."
    else
        echo -e "Сообщение от API: $MESSAGE"
    fi
    exit 1
fi

# Парсинг данных с помощью jq
NAME=$(echo "$HTTP_BODY" | jq -r '.full_name')
STARS=$(echo "$HTTP_BODY" | jq -r '.stargazers_count')
FORKS=$(echo "$HTTP_BODY" | jq -r '.forks_count')
ISSUES=$(echo "$HTTP_BODY" | jq -r '.open_issues_count')
OWNER=$(echo "$HTTP_BODY" | jq -r '.owner.login')
UPDATED_AT=$(echo "$HTTP_BODY" | jq -r '.updated_at')
# Форматирование чисел с запятыми (например, 182,347)
format_num() {
    echo "$1" | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'
}

STARS_FMT=$(format_num "$STARS")
FORKS_FMT=$(format_num "$FORKS")
ISSUES_FMT=$(format_num "$ISSUES")

# Логика цвета для Issues
if [ "$ISSUES" -gt 100 ]; then
    COLOR_ISSUES=$RED
else
    COLOR_ISSUES=$YELLOW
fi

# Вывод красивой карточки в терминал
echo -e "${CYAN}╔════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}║${RESET}   ~@ ${BOLD}GitHub Repository Analyzer${RESET}            ${CYAN}║${RESET}"
echo -e "${CYAN}╚════════════════════════════════════════╝${RESET}"
echo ""
echo -e " M-& ${BOLD}Репозиторий:${RESET} $NAME"
echo -e "⭐ ${YELLOW}Звёзды:${RESET}       ${BOLD}${YELLOW}$STARS_FMT${RESET}  (⭐)"
echo -e " ~@ ${GREEN}Форки:${RESET}        ${BOLD}${GREEN}$FORKS_FMT${RESET}   ( ~@)"
echo -e " ~[ ${COLOR_ISSUES}Open Issues:${RESET}  ${BOLD}${COLOR_ISSUES}$ISSUES_FMT${RESET}    ( ~[)"
echo -e " M-$ ${BOLD}Автор:${RESET}        $OWNER"
echo -e " ~J ${BOLD}Активность:${RESET}   Обновлён: $UPDATED_AT"
