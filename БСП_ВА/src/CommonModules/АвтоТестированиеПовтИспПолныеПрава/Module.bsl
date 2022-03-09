//@strict-types
#Область СлужебныйПрограммныйИнтерфейс
// Проверяет, что объект входит в БСП или одну из ее подсистем.
// Параметры:
//  ПолноеИмяМетаданных - Строка - Полное имя метаданных проверяемого объекта
// 
// Возвращаемое значение:
//  Булево - Исключить регистр для тестирования по подсистеме
Функция ОбъектВходитВБСП(ПолноеИмяМетаданных) Экспорт
	
	
	МетаданныеОбъекта = Метаданные.НайтиПоПолномуИмени(ПолноеИмяМетаданных);
	
	ВходитВБСП = Ложь;
	ПодсистемыБСП = ПодсистемыВходящиеВСтандартные();
	Для Каждого Подсистема Из ПодсистемыБСП Цикл
		Если Подсистема.Состав.Содержит(МетаданныеОбъекта) Тогда
			ВходитВБСП = Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат ВходитВБСП;
КонецФункции

// Подсистемы, входящие в БСП. Если подсистема есть в возвращаемом результате - значит она входит в БСП.
// 
// Возвращаемое значение:
//  Массив из ОбъектМетаданныхПодсистема - Подсистемы входящие в стандартные
Функция ПодсистемыВходящиеВСтандартные()
	СписокПодсистемБСП = Новый Массив;
	ПодсистемаБСП = Метаданные.Подсистемы.СтандартныеПодсистемы;

	СписокПодсистемБСП.Добавить(ПодсистемаБСП);
	ДополнитьСписокПодсистемПодчиненными(СписокПодсистемБСП, ПодсистемаБСП);
	
	Возврат СписокПодсистемБСП;
КонецФункции

// Дополнить список подсистем подчиненными.
// 
// Параметры:
//  СписокПодсистем - Массив - Дополняемый список подсистем
//  РодительскаяПодсистема - ОбъектМетаданныхПодсистема -  Родительская подсистема
Процедура ДополнитьСписокПодсистемПодчиненными(СписокПодсистем, РодительскаяПодсистема)
	Для Каждого ПодчиненнаяПодсистема Из РодительскаяПодсистема.Подсистемы Цикл
		СписокПодсистем.Добавить(ПодчиненнаяПодсистема);
		ДополнитьСписокПодсистемПодчиненными(СписокПодсистем, ПодчиненнаяПодсистема)
	КонецЦикла;
КонецПроцедуры

// Описание объекта по имени метаданных.
// 
// Параметры:
//  ИмяМетаданных - Строка - Имя метаданных
// 
// Возвращаемое значение:
//  Структура - Описание объекта по имени метаданных:
// * ИмяМенеджера - Строка -
// * ТипМетаданных - ПеречислениеСсылка.ТипыМетаданныхТестирование -
Функция ОписаниеОбъектаПоИмениМетаданных(ИмяМетаданных) Экспорт
	Результат = Новый Структура();
	Результат.Вставить("ИмяМенеджера", "");
	Результат.Вставить("ТипМетаданных", Перечисления.ТипыМетаданныхТестирование.ПустаяСсылка());
	
	ПозицияРазделителя = СтрНайти(ИмяМетаданных, ".");
	Если ПозицияРазделителя < 2	Или ПозицияРазделителя = СтрДлина(ИмяМетаданных) Тогда
		ВызватьИсключение "Неизвестная структура имени объекта метаданных: " + ИмяМетаданных;
	КонецЕсли;

	ИмяМенеджера = "";
	ТипМетаданных = Перечисления.ТипыМетаданныхТестирование.ПустаяСсылка();
	ИмяТипа = Лев(ИмяМетаданных, ПозицияРазделителя - 1);  
	Если ИмяТипа = "Документ" Тогда
		ТипМетаданных = Перечисления.ТипыМетаданныхТестирование.Документ;
	ИначеЕсли ИмяТипа = "Справочник" Тогда
		ТипМетаданных = Перечисления.ТипыМетаданныхТестирование.Справочник;
	ИначеЕсли ИмяТипа = "БизнесПроцесс" Тогда
		ТипМетаданных = Перечисления.ТипыМетаданныхТестирование.БизнесПроцесс;
	ИначеЕсли ИмяТипа = "Задача" Тогда
		ТипМетаданных = Перечисления.ТипыМетаданныхТестирование.Задача;
	ИначеЕсли ИмяТипа = "ПланВидовХарактеристик" Тогда
		ТипМетаданных = Перечисления.ТипыМетаданныхТестирование.ПланВидовХарактеристик;
	
	Иначе
		ВызватьИсключение "Неизвестный или неподдерживаемый тип объекта метаданных: " + ИмяТипа;
	КонецЕсли;
	Результат.ТипМетаданных = ТипМетаданных;
	
	ИмяМенеджера = Сред(ИмяМетаданных, ПозицияРазделителя + 1);
	Результат.ИмяМенеджера = ИмяМенеджера;
	
	Возврат Результат;
КонецФункции
#КонецОбласти