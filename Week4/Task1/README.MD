# Ethereum marketplace

В терминале перейти в директорию проета и установить npm packages
   > npm install

## Запуск блокчейн окружения
1. Запустить в терминале ganache cli:
    > ganache-cli
2. Запустить truffle console:
    > truffle console

## Проверка работоспособности
1. Запустить тесты из консоли `truffle`:
    > test
2. Убедиться, что тесты проходят

## Задеплоить контракт (все действия в консоли `truffle` )
1. Выполнить команду:
    > migrate
2. > `marketplace = await Marketplace.deployed()`
3. > name = await marketplace.name()
4. Проверить, что имя установлено верно `name`. Результатом должно быть `'Ethereum Marketplace'`

## Запустить реакт приложение
1. Открыть еще одно окно терминала и перейти в директорию проекта
2. Выполнить `npm start`
3. Подключить метамаск к тестовой сети по адресу `localhost:8545`
4. Перевести эфир для тестового аккаунта в метамаске:
    В консоли `truffle` 
    > web3.eth.sendTransaction({to:'\<copied metamask address\>', from: accounts[0], value: web3.utils.toWei('20')})
4. Создать продукт а консоли траффл 
    > await marketplace.createProduct("Garmin", 123, {from: accounts[3]})
5. Перейти в веб приложение и произвести покупку с помощью интерфейса