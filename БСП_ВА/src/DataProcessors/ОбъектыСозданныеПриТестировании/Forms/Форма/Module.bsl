// @strict-types
#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ОбновитьСписокИдентификаторовТестов();
	ОбновитьПараметрыАвтоТестирования();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура ОбновитьДанныеФормы(Команда)
	ОбновитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОбновитьНаСервере()
	Элементы.Объекты.Обновить();
	Элементы.ЗаписиРегистров.Обновить();
	ОбновитьСписокИдентификаторовТестов();
	ОбновитьПараметрыАвтоТестирования();
КонецПроцедуры

&НаКлиенте
Процедура УдалитьВсеОбъекты(Команда)
	ЗавершениеВопросаУдалитьОбъекты = Новый ОписаниеОповещения("УдалитьОбъектыЗавершение", ЭтотОбъект, Неопределено);
	ПоказатьВопрос(ЗавершениеВопросаУдалитьОбъекты,"Все объекты, созданые при тестировании, будут удалены.Продолжить?"
					, РежимДиалогаВопрос.ДаНет);
КонецПроцедуры

&НаКлиенте
Процедура УдалитьОбъектыТеста(Команда)
	Если Не ЗначениеЗаполнено(ИдентификаторТеста) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Укажите идентификатор теста.", , ИдентификаторТеста);
		Возврат;
	КонецЕсли;
	ЗавершениеВопросаУдалитьОбъекты = Новый ОписаниеОповещения("УдалитьОбъектыЗавершение", ЭтотОбъект, ИдентификаторТеста);
	ПоказатьВопрос(ЗавершениеВопросаУдалитьОбъекты,"Все объекты, созданые при тестировании, будут удалены.Продолжить?"
					, РежимДиалогаВопрос.ДаНет);
КонецПроцедуры

// Параметры:
//  РезультатВопроса - КодВозвратаДиалога - Результат вопроса.
//  ИдентификаторТеста -Строка, Неопределено - Идентификатор теста. Если Неопределено - удаляются все объекты, созданные при тестировании.
&НаКлиенте
Процедура УдалитьОбъектыЗавершение(РезультатВопроса, ИдентификаторТеста) Экспорт
	Если РезультатВопроса <>  КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	АвтоТестированиеВызовСервера.УдалитьОбъектыСозданныеПриТестировании(ИдентификаторТеста);
	
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Удаление завершено.");
	ОбновитьНаСервере();	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаСервере
Процедура ОбновитьСписокИдентификаторовТестов()

	ИдентификаторыТестов.Очистить();
	ИдентификаторыМассив = АвтоТестированиеСервер.ИдентификаторыВыполненныхТестов();
	ИдентификаторыТестов.ЗагрузитьЗначения(ИдентификаторыМассив);
	
	Элементы.ИдентификаторТеста.СписокВыбора.Очистить();
	Элементы.ИдентификаторТеста.СписокВыбора.ЗагрузитьЗначения(ИдентификаторыМассив);
	ИдентификаторТеста = "";
КонецПроцедуры

&НаСервере
Процедура ОбновитьПараметрыАвтоТестирования()
	ЛогироватьОбъектыАвтоТестирования = ПараметрыСеанса.ЛогироватьОбъектыАвтоТестирования;
	АвтоТестыВыполняются = ПараметрыСеанса.АвтоТестыВыполняются;
	ИдентификаторВыполняемогоТеста = ПараметрыСеанса.ИдентификаторВыполняемогоТеста;
КонецПроцедуры
#КонецОбласти
