// @strict-types
#Область ПрограммныйИнтерфейс
// Определяет, интегрирована ли в конфигурацию подсистема автотестирования.
// 
// Возвращаемое значение:
//  Булево - Истина, если подсистема интегрирована.
Функция ЕстьПодсистемаАвтоТестирование() Экспорт
	Результат = Ложь;
	Если Метаданные.Подсистемы.Найти("АвтоТестирование") <> Неопределено Тогда
		Результат = Истина;
	КонецЕсли;
	Возврат Результат;	
КонецФункции
#КонецОбласти