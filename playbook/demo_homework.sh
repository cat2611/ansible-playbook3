#!/bin/bash
echo "=== Демонстрация выполнения домашнего задания ==="

echo -e "\n1. Проверка подключения к хостам:"
ansible -i inventory/prod.yml all -m ping

echo -e "\n2. Первый запуск playbook (значения по умолчанию):"
ansible-playbook -i inventory/prod.yml site.yml

echo -e "\n3. Проверка текущих значений переменных:"
echo "group_vars/deb/examp.yml:"
head -n 2 group_vars/deb/examp.yml
echo "group_vars/el/examp.yml:"
head -n 2 group_vars/el/examp.yml

echo -e "\n4. Запуск с зашифрованными переменными:"
echo "Запускаем ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass"
echo "Пароль: netology"
