
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

// контекст фреймворка Vanessa-Behavior
&НаКлиенте
Перем Ванесса;

// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
&НаКлиенте
Перем Контекст Экспорт;

// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
&НаКлиенте
Перем КонтекстСохраняемый Экспорт;

// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
&НаКлиенте
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;

	ВсеТесты = Новый Массив;

//	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, Снипет, ИмяПроцедуры, ПредставлениеТеста, ОписаниеШага, ТипШага, Транзакция, Параметр);
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, "ЯОткрываюОсновнуюФормуСправочника(Парам01)", "ЯОткрываюОсновнуюФормуСправочника", "Дано Я открываю основную форму справочника ""ИмяСправочника""", ОписаниеШага("ЯОткрываюОсновнуюФормуСправочника"), "Навигационные ссылки");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, "ЯОткрываюОсновнуюФормуСпискаСправочника(Парам01)", "ЯОткрываюОсновнуюФормуСпискаСправочника", "Дано Я открываю основную форму списка справочника ""Справочник1""", "Открывает основную форму списка справочника по его имени в метаданных", "Навигационные ссылки");

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, "ЯОткрываюОсновнуюФормуДокумента(Парам01)", "ЯОткрываюОсновнуюФормуДокумента", "Дано Я открываю основную форму документа ""ИмяДокумента""", ОписаниеШага("ЯОткрываюОсновнуюФормуДокумента"), "Навигационные ссылки");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, "ЯОткрываюОсновнуюФормуСпискаДокумента(Парам01)", "ЯОткрываюОсновнуюФормуСпискаДокумента", "Дано Я открываю основную форму списка документа ""Документ1""", "Открывает основную форму списка документа по его имени в метаданных", "Навигационные ссылки");

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, "ЯОткрываюОсновнуюФормуОбработки(Парам01)", "ЯОткрываюОсновнуюФормуОбработки", "Дано Я открываю основную форму обработки ""Обработка1""", "Открывает форму обработки по её имени в метаданных", "Навигационные ссылки");
	
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, "ЯОткрываюОсновнуюФормуОтчета(Парам01)", "ЯОткрываюОсновнуюФормуОтчета", "Дано Я открываю основную форму отчета ""Отчет1""", "Открывает форму отчета по его имени в метаданных", "Навигационные ссылки");
	
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, "ЯОткрываюОсновнуюФормуРегистраСведений(Парам01)", "ЯОткрываюОсновнуюФормуРегистраСведений", "Дано Я открываю основную форму регистра сведений ""РегистрСведений1""", "Открывает основную форму регистра сведений по его имени в метаданных", "Навигационные ссылки");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, "ЯОткрываюОсновнуюФормуСпискаРегистраСведений(Парам01)", "ЯОткрываюОсновнуюФормуРегистраСведений", "Дано Я открываю основную форму регистра сведений ""РегистрСведений1""", "Открывает основную форму регистра сведений по его имени в метаданных", "Интерфейс.Формы");
	
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, "ЯОткрываюОсновнуюФормуРегистраНакопления(Парам01)", "ЯОткрываюОсновнуюФормуРегистраНакопления", "Дано Я открываю основную форму регистра накопления ""РегистрНакопления1""", "Открывает основную форму регистра накопления по его имени в метаданных", "Навигационные ссылки");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, "ЯОткрываюОсновнуюФормуСпискаРегистраНакопления(Парам01)", "ЯОткрываюОсновнуюФормуРегистраНакопления", "Дано Я открываю основную форму регистра накопления ""РегистрНакопления1""", "Открывает основную форму регистра накопления по его имени в метаданных", "Навигационные ссылки");

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, "ЯВыполняюКомандуКомандногоИнтерфейса(Парам01)", "ЯВыполняюКомандуКомандногоИнтерфейса", "Дано Я выполняю команду командного интерфейса ""ИмяКоманды""", ОписаниеШага("ЯВыполняюКомандуКомандногоИнтерфейса"), "Навигационные ссылки");
	
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, "ЯОткрываюНавигационнуюСсылку(Парам01)", "ЯОткрываюНавигационнуюСсылку", "Дано Я открываю навигационную ссылку ""e1cib/data/Справочник.Справочник1?ref=ad018df0619b11d5458a440b8c472f30""", "Открывает навигационную ссылку. Аналог Shift+F11", "Навигационные ссылки");

	Возврат ВсеТесты;

КонецФункции

// Служебная функция.
&НаСервере
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции

Функция ОписаниеШага(Имя)
	Если Имя = "ЯОткрываюОсновнуюФормуСправочника" Тогда
		Описание = "Требуется написать возврат описание из макета";
	Иначе
		Описание = "";
	КонецЕсли;

	Возврат Описание;

КонецФункции

// Служебная функция для подключения библиотеки создания fixtures.
&НаКлиенте
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции

///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

// Процедура выполняется перед началом каждого сценария
&НаКлиенте
Процедура ПередНачаломСценария() Экспорт
	Возврат;
КонецПроцедуры

// Процедура выполняется перед окончанием каждого сценария
&НаКлиенте
Процедура ПередОкончаниемСценария() Экспорт
	Возврат;
КонецПроцедуры

///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

// Дано Я открываю основную форму обработки "ВыполнитьПроизвольноеВыражение"
// @ЯОткрываюОсновнуюФормуОбработки(Парам01)
//
&НаКлиенте
Процедура ЯОткрываюОсновнуюФормуОбработки(Знач ИмяОбъекта) Экспорт

	ИмяОбъекта = Ванесса.ПолучитьЗначениеИзКонтекстаЕслиЭтоВозможно(ИмяОбъекта);
	АктивноеОкно = Ванесса.ПолучитьГлавноеОкноИзТестовоеПриложение();
	АктивноеОкно.ВыполнитьКоманду("e1cib/app/Обработка." + ИмяОбъекта);
	Ванесса.ОбработатьСменуАктивногоОкна();
КонецПроцедуры

// Дано Я открываю основную форму отчета "ВыполнитьПроизвольноеВыражение"
// @ЯОткрываюОсновнуюФормуОтчета(Парам01)
//
&НаКлиенте
Процедура ЯОткрываюОсновнуюФормуОтчета(Знач ИмяОбъекта) Экспорт
//ИмяОбъекта = Ванесса.ПолучитьЗначениеИзКонтекстаЕслиЭтоВозможно(ИмяОбъекта);
	АктивноеОкно = Ванесса.ПолучитьГлавноеОкноИзТестовоеПриложение();
	АктивноеОкно.ВыполнитьКоманду("e1cib/app/Отчет." + ИмяОбъекта);
	Ванесса.ОбработатьСменуАктивногоОкна();
КонецПроцедуры

// Дано Я открываю основную форму справочника "Справочник1"
//
&НаКлиенте
Процедура ЯОткрываюОсновнуюФормуСправочника(Знач ИмяОбъекта) Экспорт

	АктивноеОкно = Ванесса.ПолучитьГлавноеОкноИзТестовоеПриложение();
	АктивноеОкно.ВыполнитьКоманду("e1cib/data/Справочник." + ИмяОбъекта);
	Ванесса.ОбработатьСменуАктивногоОкна();

КонецПроцедуры

// Дано Я открываю основную форму списка справочника "Справочник1"
//
&НаКлиенте
Процедура ЯОткрываюОсновнуюФормуСпискаСправочника(Знач ИмяОбъекта) Экспорт

	АктивноеОкно = Ванесса.ПолучитьГлавноеОкноИзТестовоеПриложение();
	АктивноеОкно.ВыполнитьКоманду("e1cib/list/Справочник." + ИмяОбъекта);
	Ванесса.ОбработатьСменуАктивногоОкна();

КонецПроцедуры

// Дано Я открываю основную форму списка справочника "ИмяДокумента"
//
&НаКлиенте
Процедура ЯОткрываюОсновнуюФормуДокумента(Знач ИмяОбъекта) Экспорт

	АктивноеОкно = Ванесса.ПолучитьГлавноеОкноИзТестовоеПриложение();
	АктивноеОкно.ВыполнитьКоманду("e1cib/data/Документа." + ИмяОбъекта);
	Ванесса.ОбработатьСменуАктивногоОкна();

КонецПроцедуры

// Дано Я открываю основную форму списка документа "Документ1"
// @ЯОткрываюОсновнуюФормуСпискаДокумента(Парам01)
//
&НаКлиенте
Процедура ЯОткрываюОсновнуюФормуСпискаДокумента(Знач ИмяОбъекта) Экспорт
//ИмяОбъекта = Ванесса.ПолучитьЗначениеИзКонтекстаЕслиЭтоВозможно(ИмяОбъекта);
	АктивноеОкно = Ванесса.ПолучитьГлавноеОкноИзТестовоеПриложение();
	АктивноеОкно.ВыполнитьКоманду("e1cib/list/Документ." + ИмяОбъекта);
	Ванесса.ОбработатьСменуАктивногоОкна();
КонецПроцедуры

&НаКлиенте
Процедура ЯОткрываюОсновнуюФормуРегистраНакопления(Знач ИмяОбъекта) Экспорт
//ИмяОбъекта = Ванесса.ПолучитьЗначениеИзКонтекстаЕслиЭтоВозможно(ИмяОбъекта);
	АктивноеОкно = Ванесса.ПолучитьГлавноеОкноИзТестовоеПриложение();
	АктивноеОкно.ВыполнитьКоманду("e1cib/data/РегистрНакопления." + ИмяОбъекта);
	Ванесса.ОбработатьСменуАктивногоОкна();
КонецПроцедуры

// Дано Я открываю основную форму регистра накопления "РегистрНакопления1"
// @ЯОткрываюОсновнуюФормуРегистраНакопления(Парам01)
//
&НаКлиенте
Процедура ЯОткрываюОсновнуюФормуСпискаРегистраНакопления(Знач ИмяОбъекта) Экспорт
//ИмяОбъекта = Ванесса.ПолучитьЗначениеИзКонтекстаЕслиЭтоВозможно(ИмяОбъекта);
	АктивноеОкно = Ванесса.ПолучитьГлавноеОкноИзТестовоеПриложение();
	АктивноеОкно.ВыполнитьКоманду("e1cib/list/РегистрНакопления." + ИмяОбъекта);
	Ванесса.ОбработатьСменуАктивногоОкна();
КонецПроцедуры

&НаКлиенте
Процедура ЯОткрываюОсновнуюФормуРегистраСведений(Знач ИмяОбъекта) Экспорт
//ИмяОбъекта = Ванесса.ПолучитьЗначениеИзКонтекстаЕслиЭтоВозможно(ИмяОбъекта);
	АктивноеОкно = Ванесса.ПолучитьГлавноеОкноИзТестовоеПриложение();
	АктивноеОкно.ВыполнитьКоманду("e1cib/data/РегистрСведений." + ИмяОбъекта);
	Ванесса.ОбработатьСменуАктивногоОкна();
КонецПроцедуры

// Дано Я открываю основную форму регистра накопления "РегистрСведений1"
// @ЯОткрываюОсновнуюФормуРегистраСведений(Парам01)
//
&НаКлиенте
Процедура ЯОткрываюОсновнуюФормуСпискаРегистраСведений(Знач ИмяОбъекта) Экспорт
//ИмяОбъекта = Ванесса.ПолучитьЗначениеИзКонтекстаЕслиЭтоВозможно(ИмяОбъекта);
	АктивноеОкно = Ванесса.ПолучитьГлавноеОкноИзТестовоеПриложение();
	АктивноеОкно.ВыполнитьКоманду("e1cib/list/РегистрСведений." + ИмяОбъекта);
	Ванесса.ОбработатьСменуАктивногоОкна();
КонецПроцедуры

&НаКлиенте
Процедура ЯВыполняюКомандуКомандногоИнтерфейса(Знач ИмяКоманды) Экспорт

	АктивноеОкно = Ванесса.ПолучитьГлавноеОкноИзТестовоеПриложение();
	АктивноеОкно.ВыполнитьКоманду("e1cib/command/" + ИмяКоманды);
	Ванесса.ОбработатьСменуАктивногоОкна();

КонецПроцедуры

// Дано Я открываю навигационную ссылку "e1cib/data/Справочник.Справочник1?ref=ad018df0619b11d5458a440b8c472f30"
// @ЯОткрываюНавигационнуюСсылку(Парам01)
//
&НаКлиенте
Процедура ЯОткрываюНавигационнуюСсылку(Знач Стр) Экспорт
	Стр = Ванесса.ПолучитьЗначениеИзКонтекстаЕслиЭтоВозможно(Стр);
	КоличествоПопыток = Ванесса.ЗначениеКоличествоПопытокВыполненияДействия();
	ОписаниеОшибки = "";
	Для Ккк = 1 По КоличествоПопыток Цикл
		Попытка
			АктивноеОкно = Ванесса.ПолучитьГлавноеОкноИзТестовоеПриложение();
			АктивноеОкно.ВыполнитьКоманду(Стр);
			Ванесса.ОбработатьСменуАктивногоОкна();
			Возврат;
		Исключение
			ОписаниеОшибки = ОписаниеОшибки();
			Ванесса.Sleep(1);
		КонецПопытки;
	КонецЦикла;

	ВызватьИсключение ОписаниеОшибки;
КонецПроцедуры
