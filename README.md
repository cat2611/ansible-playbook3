# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
Ответ: Выход: some_fact = 12

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
Ответ: Значение изменилось с 12 на "all default fact"

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
Ответ: 
    ubuntu (группа deb): "deb"
    centos7 (группа el): "el"

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
Ответ: 
some_fact: "deb default fact"
some_fact: "el default fact"

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

Ответ: 
TASK [Print fact] *************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
Ответ: 

Файлы зашифрованы с паролем `netology`:
- `group_vars/deb/examp.yml` 
- `group_vars/el/examp.yml`

$ANSIBLE_VAULT;1.1;AES256
35303764336433333333303338343838663139306162303436313831383635633466396663656534
6263363432613663613031386365373733396162393366300a666662383037353563633934373665
33653738636332386537393233336265663539386666616161343664633037343636383333663237
3166316366373934310a346238386162383637383936393065633564646335363938303936316234
66313834333939343631613363316439633531666564363564623236386663656266

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
Ответ: 

Playbook запрашивает пароль и успешно расшифровывает переменные.

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

=== Плагины подключения ===
ansible.builtin.local          execute on controller                       
ansible.builtin.paramiko_ssh   Run tasks via Python SSH (paramiko)         
ansible.builtin.psrp           Run tasks over Microsoft PowerShell Remoting...
ansible.builtin.ssh            connect via SSH client binary               
ansible.builtin.winrm          Run tasks over Microsoft's WinRM            
ansible.netcommon.grpc         Provides a persistent connection using the g...
ansible.netcommon.httpapi      Use httpapi to run command on network applia...
ansible.netcommon.libssh       Run tasks using libssh for ssh connection   
ansible.netcommon.netconf      Provides a persistent connection using the n...
ansible.netcommon.network_cli  Use network_cli to run command on network ap...
ansible.netcommon.persistent   Use a persistent unix socket for connection 
community.aws.aws_ssm          connect to EC2 instances via AWS Systems Man...
community.docker.docker        Run tasks in docker containers              
community.docker.docker_api    Run tasks in docker containers              
community.docker.nsenter       execute on host running controller container
community.general.chroot       Interact with local chroot                  
community.general.funcd        Use funcd to connect to target              
community.general.incus        Run tasks in Incus instances via the Incus C...
community.general.iocage       Run tasks in iocage jails                   
community.general.jail         Run tasks in jails            

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
Ответ: 
В `inventory/prod.yml` добавлена группа `local` с хостов `localhost`.

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
Ответ: 
Все хосты получили корректные значения из соответствующих group_vars:
- **localhost**: `"all default fact"` (из `group_vars/all/examp.yml`, не шифровано)
- **ubuntu**: `"deb default fact"` (из `group_vars/deb/examp.yml`, шифровано)
- **centos7**: `"el default fact"` (из `group_vars/el/examp.yml`, шифровано)

12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

13. Предоставьте скриншоты результатов запуска команд.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

---

### Как оформить решение задания

Приложите ссылку на ваше решение в поле «Ссылка на решение» и нажмите «Отправить решение»
---
