//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

// Делает отключение модуля
&НаКлиенте
Функция ОтключениеМодуля() Экспорт

	Ванесса = Неопределено;
	Контекст = Неопределено;
	КонтекстСохраняемый = Неопределено;

КонецФункции

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВКонстантеУказанСуществующийФайл(Парам01)","ВКонстантеУказанСуществующийФайл","Дано в Константе ""ПутьКVanessaAutomation"" указан существующий файл");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВПолеСИменемЯУказываюПутьКСлужебнойФиче(Парам01,Парам02)","ВПолеСИменемЯУказываюПутьКСлужебнойФиче","И В поле с именем ""КаталогФичСлужебный"" я указываю путь к служебной фиче ""ПростаяФичаДляПроверкиРаботыВыполненияСценарияTestClient""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯДобавляюВБиблиотекиСтрокуССтандартнойБиблиотекой(Парам01)","ЯДобавляюВБиблиотекиСтрокуССтандартнойБиблиотекой","И я добавляю в библиотеки строку с стандартной библиотекой ""Пауза""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВПолеСИменемЯУказываюЗначениеРеквизитаОбъектаОбработки(Парам01,Парам02)","ВПолеСИменемЯУказываюЗначениеРеквизитаОбъектаОбработки","И В поле с именем ""КаталогИнструментовСлужебный"" я указываю значение реквизита объекта обработки ""КаталогИнструментов""");
	

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	Контекст.Вставить("ИнтервалВыполненияШагаДо",Ванесса.Объект.ИнтервалВыполненияШага);
	Ванесса.Объект.ИнтервалВыполненияШага = 2.5;
	//Ванесса.Объект.ИнтервалВыполненияШага = 0.1;
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	Ванесса.Объект.ИнтервалВыполненияШага = Контекст.ИнтервалВыполненияШагаДо;
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаСервереБезКонтекста
Функция ПолучитьЗначениеКонстантыСервер(ИмяКонстанты)
	Возврат Константы[ИмяКонстанты].Получить();
КонецФункции	

&НаКлиенте
//И в Константе "ПутьКVanessaAutomation" указан существующий файл
//@ВКонстантеУказанСуществующийФайл(Парам01)
Процедура ВКонстантеУказанСуществующийФайл(ИмяКонстанты) Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ЗначениеКонстанты = ПолучитьЗначениеКонстантыСервер(ИмяКонстанты);
	
	Если ЗначениеКонстанты = "TestEmbeddedSingle" Тогда
		Возврат;
	КонецЕсли;	 
	
	Если СокрЛП(ЗначениеКонстанты) = "" Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Константа %1 не заполнена.");
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",ИмяКонстанты);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
	
	Если НЕ Ванесса.ФайлСуществуетКомандаСистемы(ЗначениеКонстанты) Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Файл <%1> не существует.");
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",ЗначениеКонстанты);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
КонецПроцедуры



&НаКлиенте
//И В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ПростаяФичаДляПроверкиРаботыВыполненияСценария"
//@ВПолеСИменемЯУказываюПутьКСлужебнойФиче(Парам01,Парам02)
Процедура ВПолеСИменемЯУказываюПутьКСлужебнойФиче(ИмяПоля,ИмяФичи) Экспорт
	//Ванесса.ПосмотретьЗначение(КонтекстСохраняемый,Истина);
	ПутьКФиче = Ванесса.Объект.КаталогИнструментов + "\features\Support\Templates\" + ИмяФичи + ".feature";
	Если не ЗначениеЗаполнено(ИмяФичи) Тогда
		ПутьКФиче = Ванесса.Объект.КаталогИнструментов + "\features\Support\Templates";
	КонецЕсли;	
	
	ЭлементФормы = Ванесса.НайтиРеквизитОткрытойФормыПоЗаголовку(ИмяПоля,Истина);
	ЭлементФормы.ВвестиТекст(ПутьКФиче);
	
	//Ванесса.Шаг("И В открытой форме в поле с именем """ + ИмяПоля + """ я ввожу текст """ + ПутьКФиче + """");
	
КонецПроцедуры


&НаКлиенте
//И я добавляю в библиотеки строку с стандартной библиотекой "Пауза"
//@ЯДобавляюВБиблиотекиСтрокуССтандартнойБиблиотекой(Парам01)
Процедура ЯДобавляюВБиблиотекиСтрокуССтандартнойБиблиотекой(ИмяСтандартнойБиблиотеки) Экспорт
	ИмяБиблиотеки = Ванесса.Объект.КаталогИнструментов + "\features\Libraries\" + ИмяСтандартнойБиблиотеки;
	Если ИмяСтандартнойБиблиотеки = "Libraries" Тогда
		ИмяБиблиотеки = Ванесса.Объект.КаталогИнструментов + "\features\Libraries\";
	КонецЕсли;	 
	
	Если Прав(ИмяБиблиотеки,1) <> "\" Тогда
		ИмяБиблиотеки = ИмяБиблиотеки + "\"; //чтобы проэкранировать с помощью двойного слеша сивол \"
	КонецЕсли;	 
	
	ТаблицаБиблиотеки = Ванесса.НайтиТЧПоИмени("КаталогиБиблиотек");
	ПолеРеквизит = Ванесса.НайтиРеквизитТаблицы("КаталогиБиблиотек","КаталогиБиблиотекЗначение",Истина,ТаблицаБиблиотеки);
	Ванесса.ВвестиВПолеТекст(ПолеРеквизит,ИмяБиблиотеки);
	ТаблицаБиблиотеки.ЗакончитьРедактированиеСтроки();

	
	//Ванесса.Шаг("И В открытой форме в ТЧ ""КаталогиБиблиотек"" в поле с заголовком ""Значение"" я ввожу текст """ + ИмяБиблиотеки + """");
КонецПроцедуры

&НаКлиенте
//И В поле с именем "КаталогИнструментовСлужебный" я указываю значение реквизита объекта обработки "КаталогИнструментов"
//@ВПолеСИменемЯУказываюЗначениеРеквизитаОбъектаОбработки(Парам01,Парам02)
Процедура ВПолеСИменемЯУказываюЗначениеРеквизитаОбъектаОбработки(ИмяПоля,ИмяРеквизитаОбъекта) Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	
	Значение = Ванесса.Объект[ИмяРеквизитаОбъекта];
	ЭлементФормы = Ванесса.НайтиРеквизитОткрытойФормыПоЗаголовку(ИмяПоля,Истина);
	ЭлементФормы.ВвестиТекст(Значение);
	
	//Ванесса.Шаг("И В открытой форме в поле с именем """ + ИмяПоля + """ я ввожу текст """ + Значение + """");
	
КонецПроцедуры


//окончание текста модуля
