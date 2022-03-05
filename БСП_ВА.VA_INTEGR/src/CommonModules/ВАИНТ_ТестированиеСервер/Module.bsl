//@strict-types
#Область СлужебныйПрограммныйИнтерфейс
// Проверяет наличие интегрированной в конфигурацию библиотеки тестирования.
// 
// Возвращаемое значение:
//  Булево - Истина, если библиотека тестирования интегрирована в конфигурацию.
Функция ЕстьБиблиотекаТестирование() Экспорт
	ЕстьБиблиотека = Ложь;
	Если Метаданные.Подсистемы.Найти("АвтоТестирование") <> Неопределено Тогда
		ЕстьБиблиотека = Истина;
	КонецЕсли;
	Возврат ЕстьБиблиотека;
КонецФункции

// Удаление объектов, созданных при тестировании.
Процедура УдалитьОбъектыСозданныеПриТестировании() Экспорт
	Если Не ВАИНТ_ТестированиеСервер.ЕстьБиблиотекаТестирование() Тогда
		ВызватьИсключение "Операция возможна только при интеграции библиотеки тестирования в конфигурацию. Библиотека отсутствует."
	КонецЕсли;
	
	ОбъектыТестирования = АвтоТестированиеСервер.ОбъектыСозданныеПриТестировании();
	Пока ОбъектыТестирования.Следующий() Цикл
		ОписаниеОбъекта = ОписаниеОбъектаПоИмениМетаданных(ОбъектыТестирования.ИмяТипа);
		ТипМетаданных = ОписаниеОбъекта.ТипМетаданных;
		ИдентификаторОбъекта = Новый УникальныйИдентификатор(ОбъектыТестирования.УникальныйИдентификатор);
		Если ТипМетаданных = Перечисления.ВАИНТ_ТипыМетаданных.Документ Тогда
			ОбъектСсылка = Документы[ОписаниеОбъекта.ИмяМенеджера].ПолучитьСсылку(ИдентификаторОбъекта);
			Если ЗначениеЗаполнено(ОбъектСсылка) Тогда
				ДокументОбъект = ОбъектСсылка.ПолучитьОбъект();
				Если ЗначениеЗаполнено(ДокументОбъект) Тогда
					ДокументОбъект.Записать(РежимЗаписиДокумента.ОтменаПроведения);
					ДокументОбъект.УстановитьПометкуУдаления(Истина);
					ДокументОбъект.Удалить();
				КонецЕсли;
			КонецЕсли;
		ИначеЕсли ТипМетаданных = Перечисления.ВАИНТ_ТипыМетаданных.Справочник Тогда
			СправочникСсылка = Справочники[ОписаниеОбъекта.ИмяМенеджера].ПолучитьСсылку(ИдентификаторОбъекта);
			Если ЗначениеЗаполнено(СправочникСсылка) Тогда
				СправочникОбъект = СправочникСсылка.ПолучитьОбъект();
				Если ЗначениеЗаполнено(СправочникОбъект) Тогда
					СправочникОбъект.УстановитьПометкуУдаления(Истина);
					СправочникОбъект.Удалить();
				КонецЕсли;
			КонецЕсли;	
		ИначеЕсли ТипМетаданных = Перечисления.ВАИНТ_ТипыМетаданных.БизнесПроцесс Тогда
			БПСсылка = БизнесПроцессы[ОписаниеОбъекта.ИмяМенеджера].ПолучитьСсылку(ИдентификаторОбъекта);
			Если ЗначениеЗаполнено(БПСсылка) Тогда
				БПОбъект = БПСсылка.ПолучитьОбъект();
				Если ЗначениеЗаполнено(БПОбъект) Тогда
					БПОбъект.УстановитьПометкуУдаления(Истина);
					БПОбъект.Удалить();
				КонецЕсли;
			КонецЕсли;
		ИначеЕсли ТипМетаданных = Перечисления.ВАИНТ_ТипыМетаданных.Задача Тогда
			ЗадачаСсылка = Задачи[ОписаниеОбъекта.ИмяМенеджера].ПолучитьСсылку(ИдентификаторОбъекта);
			Если ЗначениеЗаполнено(ЗадачаСсылка) Тогда
				ЗадачаОбъект = ЗадачаСсылка.ПолучитьОбъект();
				ЗадачаОбъект.УстановитьПометкуУдаления(Истина);
				ЗадачаОбъект.Удалить();
			КонецЕсли;
		ИначеЕсли ТипМетаданных = Перечисления.ВАИНТ_ТипыМетаданных.ПланВидовХарактеристик Тогда
			ПВХСсылка = ПланыВидовХарактеристик[ОписаниеОбъекта.ИмяМенеджера].ПолучитьСсылку(ИдентификаторОбъекта);
			Если ЗначениеЗаполнено(ПВХСсылка) Тогда
				ПВХОбъект = ПВХСсылка.ПолучитьОбъект();
				ПВХОбъект.УстановитьПометкуУдаления(Истина);
				ПВХОбъект.Удалить();
			КонецЕсли;	
			
		Иначе
			ВызватьИсключение "Неизвестный или неподдерживаемый тип объекта метаданных: " + Строка(ТипМетаданных);
		КонецЕсли;
		НомерЗаписи = ОбъектыТестирования.НомерЗаписи;
		АвтоТестированиеСервер.УдалитьРегистрациюСозданногоОбъектаТестирования(НомерЗаписи, ИдентификаторОбъекта);
	КонецЦикла;	
КонецПроцедуры

Функция УдалитьНовыеЗаписиНезависимыхРегистровСведений()
//	ИмяРегистраСведений = Источник.ДополнительныеСвойства.ИмяРегистра;

//	ПараметрыОтбора = ЗначениеИзСтрокиВнутр(Источник.ДополнительныеСвойства.ПараметрыОтбораСтрокой); // Структура -
//
//
//	
//	НаборЗаписей = РегистрыСведений[ИмяРегистраСведений].СоздатьНаборЗаписей();
//	
//	Для Каждого ПараметрОтбора Из ПараметрыОтбора Цикл
//		НаборЗаписей.Отбор[ПараметрОтбора.Ключ].Установить(ПараметрОтбора.Значение, Истина);
//	КонецЦикла;
		
КонецФункции
#КонецОбласти
 
#Область СлужебныйПрограммныйИнтерфейс
// Описание объекта по имени формы.
// 
// Параметры:
//  ИмяФормы - Строка - Имя формы
// 
// Возвращаемое значение:
//  Структура - Описание объекта по имени формы:
// * ТипВладельца - Строка -
// * ИмяВладельца - Строка -
// * Формы - Массив из Строка - массив имен форм.
Функция ОписаниеОбъектаПоИмениФормы(ИмяФормы) Экспорт
	КонечнаяПозиция = СтрНайти(ИмяФормы, ".Форма.");
	ИмяВладельца = Лев(ИмяФормы, КонечнаяПозиция-1);
	КонечнаяПозиция = СтрНайти(ИмяФормы, ".");
	ТипОбъекта = Лев(ИмяФормы, КонечнаяПозиция-1);
	ОбъектВладелец = Метаданные.НайтиПоПолномуИмени(ИмяВладельца);
	Результат = Новый Структура("ТипВладельца, ИмяВладельца, Формы",ТипОбъекта, ОбъектВладелец.Имя, Новый Массив);

	
	Для Каждого ФормаЭлемента Из ОбъектВладелец.Формы Цикл 
		Результат.Формы.Добавить(ФормаЭлемента.Имя); 
	КонецЦикла;
	Возврат Результат;
КонецФункции

// Описание объекта по имени метаданных.
// 
// Параметры:
//  ИмяМетаданных - Строка - Имя метаданных
// 
// Возвращаемое значение:
//  Структура - Описание объекта по имени метаданных:
// * ИмяМенеджера - Строка -
// * ТипМетаданных - ПеречислениеСсылка.ВАИНТ_ТипыМетаданных -
Функция ОписаниеОбъектаПоИмениМетаданных(ИмяМетаданных) Экспорт
	Результат = Новый Структура();
	Результат.Вставить("ИмяМенеджера", "");
	Результат.Вставить("ТипМетаданных", Перечисления.ВАИНТ_ТипыМетаданных.ПустаяСсылка());
	
	ПозицияРазделителя = СтрНайти(ИмяМетаданных, ".");
	Если ПозицияРазделителя < 2	Или ПозицияРазделителя = СтрДлина(ИмяМетаданных) Тогда
		ВызватьИсключение "Неизвестная структура имени объекта метаданных: " + ИмяМетаданных;
	КонецЕсли;

	ИмяМенеджера = "";
	ТипМетаданных = Перечисления.ВАИНТ_ТипыМетаданных.ПустаяСсылка();
	ИмяТипа = Лев(ИмяМетаданных, ПозицияРазделителя - 1);  
	Если ИмяТипа = "Документ" Тогда
		ТипМетаданных = Перечисления.ВАИНТ_ТипыМетаданных.Документ;
	ИначеЕсли ИмяТипа = "Справочник" Тогда
		ТипМетаданных = Перечисления.ВАИНТ_ТипыМетаданных.Справочник;
	ИначеЕсли ИмяТипа = "БизнесПроцесс" Тогда
		ТипМетаданных = Перечисления.ВАИНТ_ТипыМетаданных.БизнесПроцесс;
	ИначеЕсли ИмяТипа = "Задача" Тогда
		ТипМетаданных = Перечисления.ВАИНТ_ТипыМетаданных.Задача;
	ИначеЕсли ИмяТипа = "ПланВидовХарактеристик" Тогда
		ТипМетаданных = Перечисления.ВАИНТ_ТипыМетаданных.ПланВидовХарактеристик;
	
	Иначе
		ВызватьИсключение "Неизвестный или неподдерживаемый тип объекта метаданных: " + ИмяТипа;
	КонецЕсли;
	Результат.ТипМетаданных = ТипМетаданных;
	
	ИмяМенеджера = Сред(ИмяМетаданных, ПозицияРазделителя + 1);
	Результат.ИмяМенеджера = ИмяМенеджера;
	
	Возврат Результат;
КонецФункции

// Преобразует соответствие в дерево значений
// 
// Параметры:
// 	ПреобразуемоеСоответствие - Соответствие
// 	* Ключ - Строка
// 	* Значение - Структура
// 		** ПодчиненныеЭлементы - Соответствие
// 	Дерево - ДеревоЗначений - дерево, которое формируется по структуре соответствия.
//  ДобавитьКорень - Булево - если истина до будет дополнительно добавлен корень.
Процедура СоответствиеВДеревоЗначений(ПреобразуемоеСоответствие, Дерево, ДобавитьКорень = Ложь) Экспорт
	Если ДобавитьКорень Тогда
		СтрокаКорня = Дерево.Строки.Добавить();
		СоответствиеВДеревоЗначений(ПреобразуемоеСоответствие, СтрокаКорня, Ложь);
		Возврат;
	КонецЕсли;
	Если ПреобразуемоеСоответствие.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	Для Каждого КлючИЗначение Из ПреобразуемоеСоответствие Цикл
		СтруктураЭлемента = КлючИЗначение.Значение; 
		НоваяСтрока = Дерево.Строки.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, СтруктураЭлемента);
		СоответствиеВДеревоЗначений(СтруктураЭлемента.ПодчиненныеЭлементы, НоваяСтрока);
	КонецЦикла; 
КонецПроцедуры
#КонецОбласти
