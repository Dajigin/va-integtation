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
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВБазеНетЭлементовСправочникаСУказаннымиВТаблицеНаименованиями(Парам01,ТабПарам)","ВБазеНетЭлементовСправочникаСУказаннымиВТаблицеНаименованиями","Дано в базе нет элементов справочника ""Справочник1"" с указанными в таблице наименованиями","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСоздаюЭлементГдеНаименованиеРавноИмениПользователя(Парам01)","ЯСоздаюЭлементГдеНаименованиеРавноИмениПользователя","И я создаю элемент ""Справочник1"" где Наименование равно имени пользователя","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВБазеДанныхЕстьЭлементаСНаименованиемРавным(Парам01,Парам02,Парам03)","ВБазеДанныхЕстьЭлементаСНаименованиемРавным","И в базе данных есть 2 элемента ""Справочник1"" с Наименованием равным ""Пользователь1""","","");
	

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

&НаСервереБезКонтекста
Функция ПолучитьТекстСообщенияПользователюСервер(Текст,ТекстСообщенийПользователю)
	Значение = ТекстСообщенийПользователю[Текст];
	Если ЗначениеЗаполнено(Значение) Тогда
		Возврат Значение;
	КонецЕсли;	 
	
	Возврат Текст; 
КонецФункции


///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры


&НаСервере
Функция УдалитьЭлементСправочникаЕслиОнЕсть(ВидСправочника,Наименование,ДопПараметры)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Справочник1.Ссылка
		|ИЗ
		|	Справочник.Справочник1 КАК Справочник1
		|ГДЕ
		|	Справочник1.Наименование = &Наименование";
		
		
	Запрос.Текст = СтрЗаменить(Запрос.Текст,"Справочник1",ВидСправочника);	
	Запрос.УстановитьПараметр("Наименование", Наименование);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СпрОбъект = ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
		ТекстСообщения = ПолучитьТекстСообщенияПользователюСервер("Удаляю элемент справочника <%1> : <%2>",ДопПараметры.ТекстСообщенийПользователю);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",ВидСправочника);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",СпрОбъект.Наименование);
		Сообщить(ТекстСообщения);
		СпрОбъект.Удалить();
	КонецЦикла;
	
КонецФункции	


///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//Дано в базе нет элементов справочника "Справочник1" с указанными в таблице наименованиями
//@ВБазеНетЭлементовСправочникаСУказаннымиВТаблицеНаименованиями(Парам01,ТабПарам)
Процедура ВБазеНетЭлементовСправочникаСУказаннымиВТаблицеНаименованиями(ВидСправочника,ТабПарам) Экспорт
	Для Каждого СтрокаТаблицы Из ТабПарам Цикл
		ДопПараметры = Новый Структура;
		ДопПараметры.Вставить("ТекстСообщенийПользователю",Ванесса.ДанныеПереводаСообщенийПользователю());
		УдалитьЭлементСправочникаЕслиОнЕсть(ВидСправочника,СтрокаТаблицы.Кол1,ДопПараметры);
	КонецЦикла;	
КонецПроцедуры



&НаКлиенте
//И я создаю элемент "Справочник1" где Наименование равно имени пользователя
//@ЯСоздаюЭлементГдеНаименованиеРавноИмениПользователя(Парам01)
Процедура ЯСоздаюЭлементГдеНаименованиеРавноИмениПользователя(ВидСправочника) Экспорт
	Ванесса.Шаг("Когда В панели разделов я выбираю ""Основная""");
	Ванесса.Шаг("И в панели функций я выбираю """ + ВидСправочника + """");
	Ванесса.Шаг("И я нажимаю на кнопку ""Создать""");
	Ванесса.Шаг("И я нажимаю на кнопку ""Ввести в наименование имя пользовтаеля""");
	Ванесса.Шаг("И я нажимаю на кнопку ""Записать и закрыть""");
КонецПроцедуры





&НаСервере
Функция ПолучитьКоличествоЭлементовСправочикаПоНаименованию(ВидСправочника,Наименование)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	КОЛИЧЕСТВО(Справочник1.Ссылка) КАК КоличествоЭлементов
		|ИЗ
		|	Справочник.Справочник1 КАК Справочник1
		|ГДЕ
		|	Справочник1.Наименование = &Наименование";
		
		
	Запрос.Текст = СтрЗаменить(Запрос.Текст,"Справочник1",ВидСправочника);	
	Запрос.УстановитьПараметр("Наименование", Наименование);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.КоличествоЭлементов;
	КонецЦикла;
	
	Возврат 0;
КонецФункции	

&НаКлиенте
//И в базе данных есть 2 элемента "Справочник1" с Наименованием равным "Пользователь1"
//@ВБазеДанныхЕстьЭлементаСНаименованиемРавным(Парам01,Парам02,Парам03)
Процедура ВБазеДанныхЕстьЭлементаСНаименованиемРавным(КоличествоЭлементов,ВидСправочника,Наименование) Экспорт
	КоличествоЭлементовСправочика = ПолучитьКоличествоЭлементовСправочикаПоНаименованию(ВидСправочника,Наименование);
	Если КоличествоЭлементовСправочика <> КоличествоЭлементов Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Ожидали <%1> элементов справочника <%2>, а нашли <%3> элементов.");
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",КоличествоЭлементов);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",ВидСправочника);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%3",КоличествоЭлементовСправочика);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
КонецПроцедуры


//окончание текста модуля
