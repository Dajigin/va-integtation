#language: ru

@tree

Функционал: Приемочные тесты релиза 1.0.1.123 от 20.06.2019

Как Тестировщик я хочу
проверить что приемочные тесты для релиза 1.0.1.123 выполняются
чтобы убедиться, что вся новая функциональность, заявленная в релизе 1.0.1.123, реализована

Сценарий: #ISS000070. В случае, если в поле "Вид товара" указано значение "Услуга", поле "Количество" становится равным 0 и недоступным для изменения.
	Дано я подключаю TestClient "Администратор" логин "Администратор" пароль ""
	И я закрыл все окна клиентского приложения
	
Сценарий: #ISS000072. Переименовать наимнование раздела "ОС, переданные в аренду нашей организации" в "ОС, арендуемые нашей организацией"
	Дано я подключаю TestClient "Администратор" логин "Администратор" пароль ""
	И я закрыл все окна клиентского приложения

Сценарий: #ISS000073. Скрыть вид "Иная ошибка 
	Дано я подключаю TestClient "Администратор" логин "Администратор" пароль ""
	И я закрыл все окна клиентского приложения
