Запустить окружение с помощью brownie:
1) brownie console --network mainnet-fork
2) Задеплоить токен:
    - В консоли ввести `ElectionToken.deploy(25000 * 10**18, {'from': accounts[0]})`
    В результате должна произойти успешная транзакция. Пример вывода:
    ```
        Transaction sent: 0x9e12904e93aa89916f9059dd32c5e5cf1d9423e37b708a2f9599b92fb1af7b05
        Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 2
        ElectionToken.constructor confirmed   Block: 14766247   Gas used: 689842 (5.75%)
        ElectionToken deployed at: 0xE7eD6747FaC5360f88a2EFC03E00d25789F69291

        <ElectionToken Contract '0xE7eD6747FaC5360f88a2EFC03E00d25789F69291'>
    ```
    - Для удобства назначить переменную ET для задеплоенного токена:
    `ET = ElectionToken[0]`
    - Перевести токены между участниками 
    `ET.transfer(accounts[1], 7444 * 10**18, {'from': accounts[0]})`
    ```
        Transaction sent: 0x4b96bb005f16d3f1400f4a8e0c2b59782bdb91d4e25ee32130d0067d605525a6
        Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 3
        ElectionToken.transfer confirmed   Block: 14766248   Gas used: 51253 (0.43%)

        <Transaction '0x4b96bb005f16d3f1400f4a8e0c2b59782bdb91d4e25ee32130d0067d605525a6'>
        >>> ET.transfer(accounts[2], 2444 * 10**18, {'from': accounts[0]})
        Transaction sent: 0x5e88cbc3b0cffee82a97fce1e541c914b4523e1b0993f89d8721e0aeb395b4bc
        Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 4
        ElectionToken.transfer confirmed   Block: 14766249   Gas used: 51229 (0.43%)

        <Transaction '0x5e88cbc3b0cffee82a97fce1e541c914b4523e1b0993f89d8721e0aeb395b4bc'>
    ```

3) Задеплоить контракт голосования:
    - `Election.deploy(ET.address, {'from': accounts[0]})`
    ```
        Transaction sent: 0x1ca5a056a9879e573f32319d9cf804abe1b308a35d139c0750169cc69e52bc41
        Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 5
        Election.constructor confirmed   Block: 14766250   Gas used: 1034225 (8.62%)
        Election deployed at: 0x6b4BDe1086912A6Cb24ce3dB43b3466e6c72AFd3

        <Election Contract '0x6b4BDe1086912A6Cb24ce3dB43b3466e6c72AFd3'>
    ```
    - Для удобства назначить переменную контракту `EC = Election[0]`
4) Добавить элементы для голосования:
    - `EC.addCandidate("Rover", {'from': accounts[3]})`
    ```
        Transaction sent: 0x80cc0de2c521853d9dce5b1688d822626848637777274a69e566e4e12fe0c32e
        Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 0
        Election.addCandidate confirmed   Block: 14766251   Gas used: 75349 (0.63%)

        <Transaction '0x80cc0de2c521853d9dce5b1688d822626848637777274a69e566e4e12fe0c32e'>
        >>> EC.addCandidate("Wonderer", {'from': accounts[3]})
        Transaction sent: 0x97c95ce762e041243ad5aba4a996383d27d828d309764686b1096ce85ba5fb39
        Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 1
        Election.addCandidate confirmed   Block: 14766252   Gas used: 79585 (0.66%)

        <Transaction '0x97c95ce762e041243ad5aba4a996383d27d828d309764686b1096ce85ba5fb39'>
        >>> EC.addCandidate("Nomad", {'from': accounts[3]})
        Transaction sent: 0x392e0227238afb53df8cfbbb8fd503292a10a8dc8cc9bd7040028a7a71b1c88f
        Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 2
        Election.addCandidate confirmed   Block: 14766253   Gas used: 79549 (0.66%)

        <Transaction '0x392e0227238afb53df8cfbbb8fd503292a10a8dc8cc9bd7040028a7a71b1c88f'>
    ```
5) Открыть голосование:
    - `EC.startElection({'from': accounts[0]})`
6) Выставить свои голоса:
    - `EC.electCandidate(0, {'from': accounts[0]})`
    ```
        Transaction sent: 0xda314e38eaa3d31dfb6e8e657912a232b3af86fd13ef245fa85b1c64520a3bf2
        Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 7
        Election.electCandidate confirmed   Block: 14766255   Gas used: 61440 (0.51%)

        <Transaction '0xda314e38eaa3d31dfb6e8e657912a232b3af86fd13ef245fa85b1c64520a3bf2'>
        >>> EC.electCandidate(1, {'from': accounts[1]})
        Transaction sent: 0xd9d15cd9e2e67e40cde0d365185ef78bd1a036f4391f3cdf5fc10a2150c029a7
        Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 5
        Election.electCandidate confirmed   Block: 14766256   Gas used: 61452 (0.51%)

        <Transaction '0xd9d15cd9e2e67e40cde0d365185ef78bd1a036f4391f3cdf5fc10a2150c029a7'>
        >>> EC.electCandidate(2, {'from': accounts[2]})
        Transaction sent: 0xd359240fcd096e1675c25b73129fc3bddfc77695607d696b6f0e012fc70280a6
        Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 0
        Election.electCandidate confirmed   Block: 14766257   Gas used: 61452 (0.51%)

        <Transaction '0xd359240fcd096e1675c25b73129fc3bddfc77695607d696b6f0e012fc70280a6'>
    ```
7) Завершить голосование после окончания:
    - `EC.endElection({'from': accounts[0]})`

8) Получить победителя:
    - `EC.getWinner({'from': accounts[0]})`
    - `EC.seeWinner()`