
&НаСервере
Функция ПолучитьМакетОбработкиСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета); 
КонецФункции	 

&НаКлиенте
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетОбработкиСервер(ИмяМакета); 
КонецФункции	 

&НаСервереБезКонтекста
Функция ТекстСообщенийПользователю(МакетПереводСообщений)
	ЗначенияПереводов = Новый Соответствие;
	
	Для Ккк = 2 По МакетПереводСообщений.ВысотаТаблицы Цикл
		ЗначениеСтрокиПоиска = МакетПереводСообщений.Область(Ккк,1,Ккк,1).Текст;
		Если Не ЗначениеЗаполнено(ЗначениеСтрокиПоиска) Тогда
			Продолжить;
		КонецЕсли;	 
		
		ЗначениеПеревода = МакетПереводСообщений.Область(Ккк,2,Ккк,2).Текст;
		
		ЗначенияПереводов.Вставить(ЗначениеСтрокиПоиска,ЗначениеПеревода)
	КонецЦикла;	
	
	Возврат ЗначенияПереводов;
КонецФункции	 


&НаСервере
Функция ДанныеПереводаСообщенийСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Попытка
		Макет = ОбъектСервер.ПолучитьМакет(ИмяМакета); 
		Возврат ТекстСообщенийПользователю(Макет); 
	Исключение
		Возврат Новый Соответствие; 
	КонецПопытки;
КонецФункции	 

&НаКлиенте
Функция ДанныеПереводаСообщений(ВерсияПоставки,Ванесса) Экспорт
	ИмяМакета = ТекущийЯзык();
	Если НЕ Ванесса.ЭтоТонкийКлиент Тогда
		Если ТипЗнч(ИмяМакета) = Тип("ОбъектМетаданных") Тогда
			ИмяМакета = ИмяМакета.КодЯзыка;
		КонецЕсли;	 
	КонецЕсли;	 
	
	Если Нрег(ИмяМакета) = "ru" Тогда
		Возврат Новый Соответствие; 
	КонецЕсли;	 
	
	Если ВерсияПоставки = "single" Тогда
		ИмяМакета = "Локализация_Messages_" + ИмяМакета;
	КонецЕсли;	 
	
	Возврат ДанныеПереводаСообщенийСервер(ИмяМакета);
КонецФункции	 