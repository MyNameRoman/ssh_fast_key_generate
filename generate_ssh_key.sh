#!/bin/bash

# Проверяем наличие аргументов
if [ -z "$1" ]; then
  echo "Использование: $0 <имя_ключа>"
  exit 1
fi

# Путь для сохранения ключей
KEY_NAME=$1
SSH_DIR="$HOME/.ssh"
KEY_PATH="$SSH_DIR/$KEY_NAME"

# Создание директории .ssh, если её нет
if [ ! -d "$SSH_DIR" ]; then
  mkdir -p "$SSH_DIR"
  chmod 700 "$SSH_DIR"
fi

# Генерация SSH-ключа
echo "Генерация SSH ключа с именем $KEY_NAME..."
ssh-keygen -t rsa -b 4096 -f "$KEY_PATH" -q -N ""

# Добавление приватного ключа в SSH-агент
echo "Добавляем приватный ключ в SSH-агент..."
eval "$(ssh-agent -s)"
ssh-add "$KEY_PATH"

# Показ публичного ключа
echo "Ваш публичный ключ:"
cat "${KEY_PATH}.pub"

echo "Готово! Приватный ключ сохранён в $KEY_PATH, публичный ключ в ${KEY_PATH}.pub."
