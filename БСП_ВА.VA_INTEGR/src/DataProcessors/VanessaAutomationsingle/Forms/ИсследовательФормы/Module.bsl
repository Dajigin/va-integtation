&НаКлиенте
Перем Ванесса;

&НаКлиенте
Перем МассивТипов;

&НаКлиенте
Перем МассивВидов;

&НаКлиенте
Перем КешТекущееОкно;

&НаКлиенте
Перем КешТекущаяФорма;

&НаКлиенте
Перем КешТекущийЭлементФормы;

&НаКлиенте
Перем КешАдресЯчейки;

&НаКлиенте
Перем КешЭлементовФормыПоИменам;

&НаКлиенте
Перем ПолучатьДанныеТекущегоОкна, ЗаголовокОкнаДляПолученияДанных;

&НаКлиенте
Функция ПолучитьТекущийЭлементФормы() Экспорт
	Если Не Ванесса.ОбъектКонтекстСохраняемый.Свойство("ТестовоеПриложение") Тогда
		Возврат Неопределено;
	КонецЕсли;	 
	
	ТекущееОкно = Неопределено;
	ТекФорма = ПолучитьТекущуюФормуTestClient(Ложь, ТекущееОкно);
	Если ТекФорма = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;	 
	
	Попытка
		ТекЭлемент = ТекФорма.ПолучитьТекущийЭлемент();
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	
	Если ТекЭлемент = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;	
	
	Данные = Новый Структура;
	Данные.Вставить("ЗаголовокОкна", ТекущееОкно.Заголовок);
	Данные.Вставить("ЗаголовокФормы", ТекФорма.ТекстЗаголовка);
	Данные.Вставить("ИмяФормы", ТекФорма.ИмяФормы);
	Данные.Вставить("ТекЭлемент", ТекЭлемент);
	
	ТипЭлемента = ТипЗнч(ТекЭлемент);
	
	Если ТипЭлемента = Тип("ТестируемаяТаблицаФормы") Тогда
		Попытка
			Данные.Вставить("ТекТаблица", ТекЭлемент);
			ТекЭлемент = ТекЭлемент.ПолучитьТекущийЭлемент();
			Данные.Вставить("ТекЭлемент", ТекЭлемент);
		Исключение
			Возврат Неопределено;
		КонецПопытки;
	ИначеЕсли ТипЭлемента = Тип("ТестируемоеПолеФормы") Тогда
		Попытка
			Вид = ТекЭлемент.Вид;
			Если Вид = ВидПоляФормы.ПолеТабличногоДокумента Тогда
				АдресТекущейОбласти = ТекЭлемент.ПолучитьАдресТекущейОбласти();
				ТекстТекущейОбласти = ТекЭлемент.ПолучитьТекстОбласти(АдресТекущейОбласти);
				Данные.Вставить("АдресЯчейки", АдресТекущейОбласти);
				Данные.Вставить("ЗначениеЯчейки", ТекстТекущейОбласти);
			КонецЕсли;	 
			
		Исключение
			
		КонецПопытки;
	КонецЕсли;	 
	
	Возврат Данные;
КонецФункции	 

&НаКлиенте
Функция ИнициализацияФормы(ВладелецФормы) Экспорт
	Ванесса = ВладелецФормы;
КонецФункции	 

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Язык = Параметры.Язык;
	ТекущийTestclientЭтоWebКлиент = Параметры.ТекущийTestclientЭтоWebКлиент;
	СтроитьДерево = НЕ ТекущийTestclientЭтоWebКлиент;
КонецПроцедуры

&НаКлиенте
Функция ПолучитьИдТипа(Тип)
	ИД = МассивТипов.Найти(Тип);
	Если ИД = Неопределено Тогда
		МассивТипов.Добавить(Тип);
		Возврат МассивТипов.Количество()-1;
	Иначе
		Возврат ИД;
	КонецЕсли;	 
КонецФункции	

&НаКлиенте
Функция ПолучитьИдВида(ВидПоля)
	ИД = МассивВидов.Найти(ВидПоля);
	Если ИД = Неопределено Тогда
		МассивВидов.Добавить(ВидПоля);
		Возврат МассивВидов.Количество()-1;
	Иначе
		Возврат ИД;
	КонецЕсли;	 
КонецФункции	

&НаКлиенте
Процедура ДобавитьКонтролВДерево(ТекущийКонтрол,ЭлементДерева)
	Тип                     = ТипЗнч(ТекущийКонтрол);
	ЭлементДерева.ТипВнутр  = ПолучитьИдТипа(Тип);
	ЭлементДерева.ТипСтрока = Строка(Тип);
	
	Попытка
		ВидПоля                 = ТекущийКонтрол.Вид;
		ЭлементДерева.ВидВнутр  = ПолучитьИдВида(ВидПоля);
		ЭлементДерева.ВидСтрока = Строка(ВидПоля);
	Исключение
	КонецПопытки;
	
	Если Тип = Тип("ТестируемоеОкноКлиентскогоПриложения") Тогда
		ЭлементДерева.Синоним = ТекущийКонтрол.Заголовок;
		ЗаголовокОкна         = ТекущийКонтрол.Заголовок;
		Возврат;
	ИначеЕсли Тип = Тип("ТестируемаяФорма") Тогда
		ЭлементДерева.Имя     = ТекущийКонтрол.ИмяФормы;
		ЭлементДерева.Синоним = ТекущийКонтрол.ТекстЗаголовка;
		
		ИмяТекущейФормы       = ТекущийКонтрол.ИмяФормы;
		ЗаголовокТекущейФормы = ТекущийКонтрол.ТекстЗаголовка;

		Возврат;
	КонецЕсли;	 
	
	Попытка
		ЭлементДерева.Имя                   = ТекущийКонтрол.Имя;
		ЭлементДерева.Синоним               = ТекущийКонтрол.ТекстЗаголовка;
		ЭлементДерева.ТекущаяВидимость      = Ложь;
		ЭлементДерева.ТекущаяДоступность    = Ложь;
		ЭлементДерева.ТекущееТолькоПросмотр = Ложь;
		
		Если Элементы.ДеревоФормыТекущаяВидимость.Видимость Тогда
			ЭлементДерева.ТекущаяВидимость      = ТекущийКонтрол.ТекущаяВидимость();
		КонецЕсли;	 
		
		Если Элементы.ДеревоФормыТекущаяДоступность.Видимость Тогда
			ЭлементДерева.ТекущаяДоступность    = ТекущийКонтрол.ТекущаяДоступность();
		КонецЕсли;	 
		
		Если Элементы.ДеревоФормыТекущееТолькоПросмотр.Видимость Тогда
			ЭлементДерева.ТекущееТолькоПросмотр = ТекущийКонтрол.ТекущееТолькоПросмотр();
		КонецЕсли;	 
		
	Исключение
		Ванесса.Отладка("Не смог прочитать данные контрола. " + ОписаниеОшибки());
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДанныеФормыРекурсивно(ТекущийКонтрол,ТекЭелементДерева)
	НовыйЭлементДерева = ТекЭелементДерева.ПолучитьЭлементы().Добавить();
	ДобавитьКонтролВДерево(ТекущийКонтрол,НовыйЭлементДерева);
	
	Попытка
		МассивЭлементов = ТекущийКонтрол.ПолучитьПодчиненныеОбъекты();
	Исключение
		Возврат;
	КонецПопытки;
	
	Для Каждого Элем Из МассивЭлементов Цикл
		ЗаполнитьДанныеФормыРекурсивно(Элем,НовыйЭлементДерева);
	КонецЦикла;	
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДанныеФормыЛинейно(ТекущийКонтрол,ТекЭелементДерева)
	НовыйЭлементДерева = ТекЭелементДерева.ПолучитьЭлементы().Добавить();
	ДобавитьКонтролВДерево(ТекущийКонтрол,НовыйЭлементДерева);
	
	Попытка
		МассивЭлементов = ТекущийКонтрол.НайтиОбъекты();
	Исключение
		Возврат;
	КонецПопытки;
	
	ЭлементыДерева = НовыйЭлементДерева.ПолучитьЭлементы();
	
	Для Каждого Элем Из МассивЭлементов Цикл
		ДобавитьЭлементФормыВКеш(Элем);
		НовыйЭлементДерева = ЭлементыДерева.Добавить();
		ДобавитьКонтролВДерево(Элем,НовыйЭлементДерева);
	КонецЦикла;	
	
КонецПроцедуры

&НаКлиенте
Функция НайтиАктивноеОкноTestClient()
	Если ТекущийTestclientЭтоWebКлиент И КешТекущееОкно <> Неопределено Тогда
		Возврат КешТекущееОкно; 
	КонецЕсли;	 
	
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("ИскатьМодальныйДиалог",Истина);
	
	ТекущееОкно = Ванесса.ПолучитьАктивноеОкноИзТестовоеПриложение(ДопПараметры);
	КешТекущееОкно = ТекущееОкно;
	
	Возврат ТекущееОкно; 
КонецФункции	

&НаКлиенте
Функция НайтиОкноПоЗаголовку(Стр)
	Попытка
		Возврат Ванесса.ОбъектКонтекстСохраняемый.ТестовоеПриложение.НайтиОбъект(Тип("ТестируемоеОкноКлиентскогоПриложения"), Стр);
	Исключение
		Возврат Неопределено;
	КонецПопытки;
КонецФункции	 

&НаКлиенте
Процедура ЗаполнитьДеревоФормы(ЗаполнятьДеревоФормы)
	
	Если ТипЗнч(КешЭлементовФормыПоИменам) = Тип("Соответствие") Тогда
		КешЭлементовФормыПоИменам.Очистить();
	КонецЕсли;	 
	
	ТекстШагов.Очистить();
	ДеревоФормы.ПолучитьЭлементы().Очистить();
	
	КонтекстСохраняемый = Ванесса.ПолучитьКонтекстСохраняемый();
	Если НЕ КонтекстСохраняемый.Свойство("ТестовоеПриложение") Тогда
		Сообщить(Ванесса.ПолучитьТекстСообщенияПользователю("Не подключен TestClient."));
		Возврат;
	КонецЕсли;	
	
	Попытка
		Если ПолучатьДанныеТекущегоОкна Тогда
			ТекущееОкно = НайтиАктивноеОкноTestClient();
		Иначе	
			ТекущееОкно = НайтиОкноПоЗаголовку(ЗаголовокОкнаДляПолученияДанных);
		КонецЕсли;	 
	Исключение
		Сообщить(ОписаниеОшибки());
		Возврат;
	КонецПопытки;
	
	КешТекущееОкно = ТекущееОкно;
	КешТекущийЭлементФормы = Неопределено;
	
	Если ЗаполнятьДеревоФормы Тогда
		Если СтроитьДерево Тогда
			ЗаполнитьДанныеФормыРекурсивно(ТекущееОкно,ДеревоФормы);
		Иначе
			ЗаполнитьДанныеФормыЛинейно(ТекущееОкно,ДеревоФормы);
		КонецЕсли;	 
	КонецЕсли;	 
	
	Если ПолучатьАктивныйЭлементИзTestClient Тогда
		ПодключитьОбработчикОжидания("ПроверкаАктивногоЭлементаОткрытойФормы",1,Ложь);
	Иначе	
		// значит надо получить данные формы только один раз
		ПодключитьОбработчикОжидания("ПроверкаАктивногоЭлементаОткрытойФормы",1,Истина);
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
Функция ПолучитьТекущуюФормуTestClient(ЗаполнятьДеревоФормы, ТекущееОкно)
	Если ТекущийTestclientЭтоWebКлиент И КешТекущаяФорма <> Неопределено И КешТекущееОкно <> Неопределено Тогда
		ТекущееОкно = КешТекущееОкно;
		Возврат КешТекущаяФорма; 
	КонецЕсли;	 
	
	Попытка
		ТекущееОкно = НайтиАктивноеОкноTestClient();
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	
	Если ТекущееОкно = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;	 
	
	Если НЕ ЗаполнятьДеревоФормы Тогда
	КонецЕсли;	 
	
	Если ТекущееОкно <> КешТекущееОкно Тогда
		ЗаполнитьДеревоФормы(ЗаполнятьДеревоФормы);
	КонецЕсли;	 
	
	ТекФорма = ТекущееОкно.НайтиОбъект(Тип("ТестируемаяФорма"));
	КешТекущаяФорма = ТекФорма;
	
	Возврат ТекФорма;
КонецФункции	

&НаКлиенте
Процедура НайтиВДеревеАктивныйЭлементЕслиЭтоВозможно()
	
	Данные = ПолучитьТекущийЭлементФормы();
	Если Данные = Неопределено Тогда
		Возврат;
	КонецЕсли;	 
	
	ТекЭлемент = Данные.ТекЭлемент;
	
	ВидЭлемента = Неопределено;
	Попытка
		ВидЭлемента = ТекЭлемент.Вид;
	Исключение
	КонецПопытки;
	
	АдресЯчейки = Неопределено;
	Если ВидЭлемента = ВидПоляФормы.ПолеТабличногоДокумента Тогда
		Попытка
			АдресЯчейки = ТекЭлемент.ПолучитьАдресТекущейОбласти();
		Исключение
		КонецПопытки;
	КонецЕсли;	 
	
	Если ТекЭлемент <> КешТекущийЭлементФормы ИЛИ
		(ВидЭлемента = ВидПоляФормы.ПолеТабличногоДокумента И КешАдресЯчейки <> АдресЯчейки И АдресЯчейки <> Неопределено) Тогда
		
		КешТекущийЭлементФормы = ТекЭлемент;
		
		Если ВидЭлемента = ВидПоляФормы.ПолеТабличногоДокумента Тогда
			Попытка
				КешАдресЯчейки = ТекЭлемент.ПолучитьАдресТекущейОбласти();
			Исключение
			КонецПопытки;
		КонецЕсли;	 
		
		Попытка
			Имя = ТекЭлемент.Имя;
		Исключение
			Сообщить(ОписаниеОшибки());
			Возврат;
		КонецПопытки;
		
		СтрокаДерева = НайтиСтрокуДереваСИменемЭлемента(Имя);
		
		Если СтрокаДерева = Неопределено Тогда
			//ЗаполнитьДеревоФормы();
			Возврат;
		КонецЕсли;	
		
		ПроизошлаСменаСтрокиПриИзмененииТекущегоЭлементаВTestClient = Истина;
		Элементы.ДеревоФормы.ТекущаяСтрока = СтрокаДерева.ПолучитьИдентификатор();
		ЗаполнитьТекстШаговПоАктивномуЭлементу();
		
		
		Ванесса.Отладка(Ванесса.ПолучитьТекстСообщенияПользователю("Найден активный элемент формы") + " <" + Имя + ">");
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
Процедура ПроверкаАктивногоЭлементаОткрытойФормы()
	Попытка
		НайтиВДеревеАктивныйЭлементЕслиЭтоВозможно();
	Исключение
		Сообщить(ОписаниеОшибки());
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
Функция НайтиСтрокуДереваСИменемЭлемента(Имя)
	Результат = Неопределено;
	НайтиСтрокуДереваСИменемЭлементаРекурсивно(ДеревоФормы.ПолучитьЭлементы(),Имя,Результат);
	Возврат Результат;
КонецФункции	

&НаКлиенте
Процедура НайтиСтрокуДереваСИменемЭлементаРекурсивно(ЭлементыДерева,Имя,Результат)
	Если Результат <> Неопределено Тогда
		Возврат;
	КонецЕсли;	 
	
	Для Каждого Элем Из ЭлементыДерева Цикл
		Если Элем.Имя = Имя Тогда
			Результат = Элем;
			Возврат;
		КонецЕсли;	 
		
		НайтиСтрокуДереваСИменемЭлементаРекурсивно(Элем.ПолучитьЭлементы(),Имя,Результат)
	КонецЦикла;	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПолучатьДанныеТекущегоОкна = Истина;
	МассивТипов = Новый Массив;
	МассивВидов = Новый Массив;
	СкрытьДопКолонки();
	Ванесса = ВладелецФормы;
	ЗаполнитьДеревоФормы(Истина);
	ПолучатьАктивныйЭлементИзTestClient = Истина;
	
	Если КешЭлементовФормыПоИменам = Неопределено Тогда
		КешЭлементовФормыПоИменам = Новый Соответствие;
	КонецЕсли;	 
	
	ВключитьПоискАктивногоЭлементаФомры();
КонецПроцедуры

&НаКлиенте
Функция НайтиФормуРекурсивноВДереве(ДанныеЭлемента)
	ТекРодитель = ДанныеЭлемента.ПолучитьРодителя();
	Пока Истина Цикл
		Если ТекРодитель = Неопределено Тогда
			Прервать;
		КонецЕсли;	 
		
		Если ТекРодитель.ТипВнутр = ПолучитьИдТипа(Тип("ТестируемаяФорма")) Тогда
			Возврат ТекРодитель;
		КонецЕсли;	 
		
		ТекРодитель = ТекРодитель.ПолучитьРодителя();
	КонецЦикла;	
КонецФункции	

&НаКлиенте
Процедура АктивизироватьОбъектTestClient(ДанныеЭлемента)
	Если ДанныеЭлемента = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	Если ДанныеЭлемента.ТипВнутр = ПолучитьИдТипа(Тип("ТестируемоеОкноКлиентскогоПриложения")) Тогда
		Возврат;
	ИначеЕсли ДанныеЭлемента.ТипВнутр = ПолучитьИдТипа(Тип("ТестируемаяФорма")) Тогда
		Возврат;
	КонецЕсли;	 
	
	Если ТекущийTestclientЭтоWebКлиент Тогда
		ТекФормаЭлемент = КешТекущаяФорма;
	ИначеЕсли СтроитьДерево Тогда
		ТекФормаДерево = НайтиФормуРекурсивноВДереве(ДанныеЭлемента);
		
		Попытка
			ТекОкноЭлемент = НайтиАктивноеОкноTestClient();
		Исключение
			Сообщить(ОписаниеОшибки());
			Возврат;
		КонецПопытки;
		
		Если ТекОкноЭлемент = Неопределено Тогда
			Возврат;
		КонецЕсли;	 
		
		Попытка
			ВсеФормыОкна = ТекОкноЭлемент.НайтиОбъекты(Тип("ТестируемаяФорма"));
			ТекФормаЭлемент = Неопределено;
			Для Каждого ФормаОкна Из ВсеФормыОкна Цикл
				Если ФормаОкна.ИмяФормы = ТекФормаДерево.Имя Тогда
					ТекФормаЭлемент = ФормаОкна;
					Прервать;
				КонецЕсли;	 
			КонецЦикла;	
		Исключение
			Сообщить(ОписаниеОшибки());
			Возврат;
		КонецПопытки;
		
		Если ТекФормаЭлемент = Неопределено Тогда
			Возврат;
		КонецЕсли;
	Иначе	
		ТекФормаЭлемент = КешТекущаяФорма;
	КонецЕсли;	 
	
	Попытка
		ТекЭлемент = ПолучитьЭлементФормыИзКеш(ДанныеЭлемента.Имя);
		Если ТекЭлемент = Неопределено Тогда
			ТекЭлемент = ТекФормаЭлемент.НайтиОбъект(,,ДанныеЭлемента.Имя);
		КонецЕсли;	 
	Исключение
		Сообщить(ОписаниеОшибки());
		Возврат;
	КонецПопытки;
	
	Если ТекЭлемент = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	Попытка
		ТекЭлемент.Активизировать();
		КешТекущийЭлементФормы = ТекЭлемент;
		ЗаполнитьТекстШаговПоАктивномуЭлементу();
	Исключение
		Возврат;
	КонецПопытки;
КонецПроцедуры


&НаКлиенте
Функция НайтиТаблицуДляТекущегоЭлемента()
	ТекущиеДанные = Элементы.ДеревоФормы.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;	
	
	ИдТипа = ПолучитьИдТипа(Тип("ТестируемаяТаблицаФормы"));
	
	ТекРодитель = ТекущиеДанные.ПолучитьРодителя();
	Пока ТекРодитель <> Неопределено Цикл
		
		Если ТекРодитель.ТипВнутр = ИдТипа Тогда
			// значит это таблица значений
			Возврат ТекРодитель;
		КонецЕсли;	 
		
		ТекРодитель = ТекРодитель.ПолучитьРодителя();
	КонецЦикла;	
	
	Возврат Неопределено;
КонецФункции	

&НаКлиенте
Функция ЭкранироватьСпецСимволы(Знач Стр)
	Возврат СтрЗаменить(Стр, "'", "\'");
	
КонецФункции	 

&НаКлиенте
Процедура ЗаполнитьТекстШаговПоАктивномуЭлементу()
	ТекстШагов = "";
	
	ТекущиеДанные = Элементы.ДеревоФормы.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	ТекущееОкно = Неопределено;
	ТекФорма = ПолучитьТекущуюФормуTestClient(Истина, ТекущееОкно);
	Если ТекФорма = Неопределено Тогда
		Возврат;
	КонецЕсли;	 

	ЭлементФормы = ПолучитьЭлементФормыИзКеш(ТекущиеДанные.Имя);
	Если ЭлементФормы = Неопределено Тогда
		ЭлементФормы = ТекФорма.НайтиОбъект(,,ТекущиеДанные.Имя);
	КонецЕсли;	 
	
	Если ЭлементФормы = Неопределено Тогда
		Возврат;
	КонецЕсли;	 
	
	МассивШагов = Новый Массив;
	
	Если ТипЗнч(ЭлементФормы) = Тип("ТестируемоеПолеФормы") Тогда
		Вид = ЭлементФормы.Вид;
		
		ТаблицаВладелец = НайтиТаблицуДляТекущегоЭлемента();
		
		ЭлементТаблица  = Неопределено;
		Если ТаблицаВладелец <> Неопределено Тогда
			ЭлементТаблица = ТекФорма.НайтиОбъект(,,ТаблицаВладелец.Имя);
		КонецЕсли;	 
		
		ТекстРедактирования = Неопределено;
		Если Вид = ВидПоляФормы.ПолеВвода Тогда
			Если ТаблицаВладелец = Неопределено Тогда
				Попытка
					Если ЭлементФормы.Вид = ВидПоляФормы.ПолеВвода Тогда
						// Чтобы синхронизировать работу с шагом
						// И элемент формы "ИмяЭлемента" стал равен "Значение"
						Попытка
							ЗначениеПоля = ЭлементФормы.ПолучитьТекстРедактирования();
							ТекстРедактирования = ЗначениеПоля;
						Исключение
							// если поле невидимое - тогда получим представление данных
							ЗначениеПоля = ЭлементФормы.ПолучитьПредставлениеДанных();
						КонецПопытки;
					Иначе	
						ЗначениеПоля = ЭлементФормы.ПолучитьПредставлениеДанных();
					КонецЕсли;	 
					
					МассивСтрок = Ванесса.РазложитьСтрокуВМассивПодстрокКлиент(ЗначениеПоля,Символы.ПС);
					Если МассивСтрок.Количество() <= 1 Тогда
						МассивШагов.Добавить("И элемент формы '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' стал равен '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
						МассивШагов.Добавить("И элемент формы с именем '" + ЭлементФормы.Имя + "' стал равен '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
					Иначе	
						ТекстШага = "И элемент формы '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' стал равен";
						Для Каждого СтрокаШага Из МассивСтрок Цикл
							ТекстШага = ТекстШага + Символы.ПС + "	| '" + СтрокаШага + "' |";
						КонецЦикла;	
						МассивШагов.Добавить(ТекстШага);
						
						МассивШагов.Добавить("");
						
						ТекстШага = "И элемент формы с именем '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' стал равен";
						Для Каждого СтрокаШага Из МассивСтрок Цикл
							ТекстШага = ТекстШага + Символы.ПС + "	| '" + СтрокаШага + "' |";
						КонецЦикла;	
						МассивШагов.Добавить(ТекстШага);
					КонецЕсли;	 
					
				Исключение
				КонецПопытки;
				
				ОтображаемыйТекст   = Неопределено;
				Попытка
					МассивШагов.Добавить("");
					ОтображаемыйТекст   = ЭлементФормы.ПолучитьОтображаемыйТекст();
				Исключение
				КонецПопытки;
				
				
				Если ОтображаемыйТекст <> Неопределено Тогда
					МассивШагов.Добавить("И представление элемента с именем '" + ЭлементФормы.Имя + "' стало равно '" + ЭкранироватьСпецСимволы(ОтображаемыйТекст) + "'");
				КонецЕсли;	 
				
				Попытка
					Если ТекстРедактирования = Неопределено Тогда
						ТекстРедактирования = ЭлементФормы.ПолучитьТекстРедактирования();
					КонецЕсли;	 
					Если ЗначениеПоля <> ТекстРедактирования Тогда
						МассивШагов.Добавить("И у элемента формы с именем '" + ЭлементФормы.Имя + "' текст редактирования стал равен '" + ЭкранироватьСпецСимволы(ТекстРедактирования) + "'");
					КонецЕсли;	 
				Исключение
				КонецПопытки;
				
			Иначе	
				Попытка
					ЗначениеПоля = ЭлементТаблица.ПолучитьТекстЯчейки(ЭлементФормы.Имя);
					МассивСтрок  = Ванесса.РазложитьСтрокуВМассивПодстрокКлиент(ЗначениеПоля,Символы.ПС);
					Если МассивСтрок.Количество() <=1 Тогда
						МассивШагов.Добавить("И в таблице '" + ТаблицаВладелец.Имя + "' поле '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' имеет значение '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
						МассивШагов.Добавить("И в таблице '" + ТаблицаВладелец.Имя + "' поле с именем '" + ЭлементФормы.Имя + "' имеет значение '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
					Иначе	
						ТекстШага = "И в таблице '" + ТаблицаВладелец.Имя + "' поле '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' имеет значение";
						Для Каждого СтрокаШага Из МассивСтрок Цикл
							ТекстШага = ТекстШага + Символы.ПС + "	| '" + СтрокаШага + "' |";
						КонецЦикла;	
						МассивШагов.Добавить(ТекстШага);
						
						ТекстШага = "И в таблице '" + ТаблицаВладелец.Имя + "' поле с именем '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' имеет значение";
						Для Каждого СтрокаШага Из МассивСтрок Цикл
							ТекстШага = ТекстШага + Символы.ПС + "	| '" + СтрокаШага + "' |";
						КонецЦикла;	
						МассивШагов.Добавить(ТекстШага);
					КонецЕсли;	 
					
				Исключение
				КонецПопытки;
			КонецЕсли;	 
			
		ИначеЕсли Вид = ВидПоляФормы.ПолеФлажка Тогда
			Если ТаблицаВладелец = Неопределено Тогда
				ЗначениеПоля        = ЭлементФормы.ПолучитьПредставлениеДанных();
				МассивШагов.Добавить("И я изменяю флаг '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "'");
				МассивШагов.Добавить("И я изменяю флаг с именем '" + ЭлементФормы.Имя + "'");
				МассивШагов.Добавить("");
				МассивШагов.Добавить("И я снимаю флаг '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "'");
				МассивШагов.Добавить("И я снимаю флаг с именем '" + ЭлементФормы.Имя + "'");
				МассивШагов.Добавить("");
				МассивШагов.Добавить("И я устанавливаю флаг '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "'");
				МассивШагов.Добавить("И я устанавливаю флаг с именем '" + ЭлементФормы.Имя + "'");
				МассивШагов.Добавить("");
				МассивШагов.Добавить("И флаг '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' равен '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
				МассивШагов.Добавить("И флаг с именем '" + ЭлементФормы.Имя + "' равен '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
				
				Попытка
					Если ТекстРедактирования = Неопределено Тогда
						ТекстРедактирования = ЭлементФормы.ПолучитьТекстРедактирования();
					КонецЕсли;	 
					Если ЗначениеПоля <> ТекстРедактирования Тогда
						МассивШагов.Добавить("И у элемента формы с именем '" + ЭлементФормы.Имя + "' текст редактирования стал равен '" + ЭкранироватьСпецСимволы(ТекстРедактирования) + "'");
					КонецЕсли;	 
				Исключение
				КонецПопытки;
			Иначе	
				Попытка
					МассивШагов.Добавить("");
					ЗначениеПоля        = ЭлементТаблица.ПолучитьТекстЯчейки(ЭлементФормы.Имя);
					//МассивШагов.Добавить("Тогда текст ячейки таблицы '" + ТаблицаВладелец.Имя + "' '" + ЭлементФормы.Имя + "' стал равен '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
					МассивШагов.Добавить("И в таблице '" + ТаблицаВладелец.Имя + "' поле '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' имеет значение '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
					МассивШагов.Добавить("И в таблице '" + ТаблицаВладелец.Имя + "' поле с именем '" + ЭлементФормы.Имя + "' имеет значение '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
				Исключение
				КонецПопытки;
			КонецЕсли;	 
		ИначеЕсли Вид = ВидПоляФормы.ПолеТабличногоДокумента Тогда
			МассивШагов.Добавить("Дано Табличный документ '" + ЭлементФормы.Имя + "' равен макету ""ИмяМакета""");
			МассивШагов.Добавить("Дано Табличный документ '" + ЭлементФормы.Имя + "' равен макету ""ИмяМакета"" по шаблону");
			
			АдресТекущейОбласти = Неопределено;
			ТекстТекущейОбласти = Неопределено;
			Попытка
				АдресТекущейОбласти = ЭлементФормы.ПолучитьАдресТекущейОбласти();
				ТекстТекущейОбласти = ЭлементФормы.ПолучитьТекстОбласти(АдресТекущейОбласти);
				Поз = Найти(АдресТекущейОбласти,":");
				Если Поз > 0 Тогда
					АдресТекущейОбласти = Лев(АдресТекущейОбласти,Поз-1);
				КонецЕсли;	 
				МассивШагов.Добавить("");
				МассивШагов.Добавить("И я жду когда в табличном документе '" + ЭлементФормы.Имя + "' заполнится ячейка '" + АдресТекущейОбласти + "' в течение 20 секунд");
				МассивШагов.Добавить("И в табличном документе '" + ЭлементФормы.Имя + "' ячейка с адресом '" + АдресТекущейОбласти + "' равна '" + ЭкранироватьСпецСимволы(ТекстТекущейОбласти) + "'");
				МассивШагов.Добавить("И я жду, что в табличном документе '" + ЭлементФормы.Имя + "' ячейка '" + АдресТекущейОбласти + "' станет равна '" + ЭкранироватьСпецСимволы(ТекстТекущейОбласти) + "'" + " в течение 20 секунд");
				МассивШагов.Добавить("И я запоминаю значение ячейки табличного документа '" + ЭлементФормы.Имя + "' '" + АдресТекущейОбласти + "' в переменную ""ИмяПеременной""");
			Исключение
			КонецПопытки;
			
			МассивШагов.Добавить("");
			МассивШагов.Добавить("И область ""R1C1:R10C10"" табличного документа '" + ЭлементФормы.Имя + "' равна макету ""ИмяМакета""");
			
		ИначеЕсли Вид = ВидПоляФормы.ПолеПереключателя Тогда
			ЗначениеПоля        = ЭлементФормы.ПолучитьПредставлениеДанных();
			ОтображаемыйТекст   = Неопределено;
			ТекстРедактирования = Неопределено;
			Попытка
				ОтображаемыйТекст   = ЭлементФормы.ПолучитьОтображаемыйТекст();
			Исключение
			КонецПопытки;
			
			
			Попытка
				Если ТекстРедактирования = Неопределено Тогда
					ТекстРедактирования = ЭлементФормы.ПолучитьТекстРедактирования();
				КонецЕсли;	 
			Исключение
			КонецПопытки;
			
			
			МассивШагов.Добавить("И элемент формы с именем '" + ЭлементФормы.Имя + "' стал равен '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
			Если ОтображаемыйТекст <> Неопределено Тогда
				МассивШагов.Добавить("И представление элемента с именем '" + ЭлементФормы.Имя + "' стало равно '" + ЭкранироватьСпецСимволы(ОтображаемыйТекст) + "'");
			КонецЕсли;	 
			
			Если ТекстРедактирования <> Неопределено Тогда
				Если ЗначениеПоля <> ТекстРедактирования Тогда
					МассивШагов.Добавить("И у элемента формы с именем '" + ЭлементФормы.Имя + "' текст редактирования стал равен '" + ЭкранироватьСпецСимволы(ТекстРедактирования) + "'");
				КонецЕсли;	 
			КонецЕсли;	 
			
			ЗначениеПереключателя = ОтображаемыйТекст;
			Если ЗначениеПереключателя = Неопределено Тогда
				ЗначениеПереключателя = ТекстРедактирования;
			КонецЕсли;	 
			
			МассивШагов.Добавить("");
			МассивШагов.Добавить("И я меняю значение переключателя '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' на '" + ЭкранироватьСпецСимволы(ЗначениеПереключателя) + "'");
			МассивШагов.Добавить("И я меняю значение переключателя с именем '" + ЭлементФормы.Имя + "' на '" + ЭкранироватьСпецСимволы(ЗначениеПереключателя) + "'");
		ИначеЕсли Вид = ВидПоляФормы.ПолеНадписи Тогда
			Если ТаблицаВладелец = Неопределено Тогда
				Попытка
					ЗначениеПоля = ЭлементФормы.ПолучитьПредставлениеДанных();
				Исключение
					ЗначениеПоля = Неопределено;
				КонецПопытки;
				ОтображаемыйТекст   = Неопределено;
				ТекстРедактирования = Неопределено;
				
				Попытка
					ОтображаемыйТекст   = ЭлементФормы.ПолучитьОтображаемыйТекст();
				Исключение
				КонецПопытки;
				
				Попытка
					Если ТекстРедактирования = Неопределено Тогда
						ТекстРедактирования = ЭлементФормы.ПолучитьТекстРедактирования();
					КонецЕсли;	 
				Исключение
					
				КонецПопытки;
				
				МассивШагов.Добавить("И элемент формы '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' стал равен '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
				МассивШагов.Добавить("И элемент формы с именем '" + ЭлементФормы.Имя + "' стал равен '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
				Если ТекстРедактирования <> Неопределено Тогда
					Если ЗначениеПоля <> ТекстРедактирования Тогда
						МассивШагов.Добавить("И у элемента формы с именем '" + ЭлементФормы.Имя + "' текст редактирования стал равен '" + ЭкранироватьСпецСимволы(ТекстРедактирования) + "'");
					КонецЕсли;	
				КонецЕсли;	 
				
				МассивШагов.Добавить("");
				
				Если ОтображаемыйТекст <> Неопределено Тогда
					МассивШагов.Добавить("И представление элемента с именем '" + ЭлементФормы.Имя + "' стало равно '" + ЭкранироватьСпецСимволы(ОтображаемыйТекст) + "'");
				КонецЕсли;	 
				
				
				МассивШагов.Добавить("");
				МассивШагов.Добавить("И я нажимаю на гиперссылку '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "'");
				МассивШагов.Добавить("И я нажимаю на гиперссылку с именем '" + ЭлементФормы.Имя + "'");
				
				МассивШагов.Добавить("");
				
				МассивШагов.Добавить("И у гиперссылки '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "' элемента формы """" я нажимаю на ссылку '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "' программно");
			Иначе	
				Попытка
					ЗначениеПоля        = ЭлементТаблица.ПолучитьТекстЯчейки(ЭлементФормы.Имя);
					//МассивШагов.Добавить("Тогда текст ячейки таблицы '" + ТаблицаВладелец.Имя + "' '" + ЭлементФормы.Имя + "' стал равен '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
					МассивШагов.Добавить("И в таблице '" + ТаблицаВладелец.Имя + "' поле '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' имеет значение '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
					МассивШагов.Добавить("И в таблице '" + ТаблицаВладелец.Имя + "' поле с именем '" + ЭлементФормы.Имя + "' имеет значение '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
				Исключение
				КонецПопытки;
			КонецЕсли;	 
		КонецЕсли;	 
		
		Если ТаблицаВладелец <> Неопределено Тогда
			МассивШагов.Добавить("И таблица '" + ТаблицаВладелец.Имя + "' равна макету ""ИмяМакета""");
			
			МассивШагов.Добавить("");
			МассивШагов.Добавить("И в таблице '" + ТаблицаВладелец.Имя + "' я активизирую поле '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "'");
			МассивШагов.Добавить("И в таблице '" + ТаблицаВладелец.Имя + "' я активизирую поле с именем '" + ЭлементФормы.Имя + "'");
			
			МассивШагов.Добавить("");
			МассивШагов.Добавить("И я запоминаю значение поля с именем '" +  ЭлементФормы.Имя + "' таблицы '" + ТаблицаВладелец.Имя + "' как '" + ЭлементФормы.Имя + "'");
			
			МассивШагов.Добавить("");
			МассивШагов.Добавить("И в таблице '" + ТаблицаВладелец.Имя + "' я перехожу к первой строке");
			МассивШагов.Добавить("И в таблице '" + ТаблицаВладелец.Имя + "' я перехожу к последней строке");
			
			
			МассивШагов.Добавить("");
			МассивШагов.Добавить("И я жду, что в таблице '" + ТаблицаВладелец.Имя + "' количество строк будет ""больше"" 0 в течение 20 секунд");
			
			МассивШагов.Добавить("");
			МассивШагов.Добавить("И для каждой строки таблицы '" + ТаблицаВладелец.Имя + "' я выполняю");
		Иначе
			МассивШагов.Добавить("");
			МассивШагов.Добавить("И у элемента с именем '" + ЭлементФормы.Имя + "' я жду значения '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "' в течение 60 секунд");
			МассивШагов.Добавить("");
			МассивШагов.Добавить("И я запоминаю значение поля с именем '" + ЭлементФормы.Имя + "' как '" + ЭлементФормы.Имя + "'");
			МассивШагов.Добавить("И в поле с именем '" + ЭлементФормы.Имя + "' я ввожу текст '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
			МассивШагов.Добавить("И в поле с именем '" + ЭлементФормы.Имя + "' ввожу значение переменной '" + ЭлементФормы.Имя + "'");
		КонецЕсли;	 
	ИначеЕсли ТипЗнч(ЭлементФормы) = Тип("ТестируемаяДекорацияФормы") Тогда	
		ЗначениеПоля        = ЭлементФормы.ТекстЗаголовка;
		//МассивШагов.Добавить("И элемент формы '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' стал равен '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
		МассивШагов.Добавить("И элемент формы с именем '" + ЭлементФормы.Имя + "' стал равен '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
		МассивШагов.Добавить("И у элемента с именем '" + ЭлементФормы.Имя + "' я жду значения '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "' в течение 30 секунд");
		МассивШагов.Добавить("");
		МассивШагов.Добавить("И я нажимаю на гиперссылку '" + ЭкранироватьСпецСимволы(ЗначениеПоля) + "'");
		МассивШагов.Добавить("И я нажимаю на гиперссылку с именем '" + ЭлементФормы.Имя + "'");
	ИначеЕсли ТипЗнч(ЭлементФормы) = Тип("ТестируемаяКнопкаФормы") Тогда	
		МассивШагов.Добавить("И я нажимаю на кнопку '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "'");
		МассивШагов.Добавить("И я нажимаю на кнопку с именем '" + ЭлементФормы.Имя + "'");
	ИначеЕсли ТипЗнч(ЭлементФормы) = Тип("ТестируемаяГруппаФормы") Тогда	
		МассивШагов.Добавить("И я жду появления элемента '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "' в течение 20 секунд");
		МассивШагов.Добавить("И я жду появления элемента с именем '" + ЭлементФормы.Имя + "' в течение 20 секунд");
	КонецЕсли;	 
	
	Если ТаблицаВладелец = Неопределено Тогда
		МассивШагов.Добавить("");
		МассивШагов.Добавить("И я активизирую поле '" + ЭкранироватьСпецСимволы(ЭлементФормы.ТекстЗаголовка) + "'");
		МассивШагов.Добавить("И я активизирую поле с именем '" + ЭлементФормы.Имя + "'");
	КонецЕсли;	 
	
	
	Для Каждого ТекстШага Из МассивШагов Цикл
		ТекстШагов.ДобавитьСтроку(ТекстШага);
	КонецЦикла;	
	
	
	Если Язык <> "ru" И ЗначениеЗаполнено(Язык) Тогда
		Текст = Ванесса.ПеревестиТекст(ТекстШагов.ПолучитьТекст());
		ТекстШагов.УстановитьТекст(Текст);
	КонецЕсли;	 
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция СделатьПереводШаговСервер(Текст,КешТаблицаПеревода)
КонецФункции	 

&НаКлиенте
Процедура ДеревоФормыПриАктивизацииСтроки(Элемент)
	Если ПроизошлаСменаСтрокиПриИзмененииТекущегоЭлементаВTestClient Тогда
		// чтобы не было лишнего срабатывания в тестклиенте
		ПроизошлаСменаСтрокиПриИзмененииТекущегоЭлементаВTestClient = Ложь;
		Возврат;
	КонецЕсли;	 
	
	Если ЭтаФорма.ТекущийЭлемент.Имя = "ГруппаЗаголовокИмяФормы" Тогда
		// значит происходит сворачнивание/разворачивание группы
		Возврат;
	КонецЕсли;	 
	
	АктивизироватьОбъектTestClient(Элементы.ДеревоФормы.ТекущиеДанные);
КонецПроцедуры

&НаКлиенте
Процедура Обновить()
	КешТекущееОкно = Неопределено;
	КешТекущаяФорма = Неопределено;
	ЗаполнитьДеревоФормы(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСкрытьТип(Команда)
	Если Не Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТипСтрока.Видимость  Или Команда = "Показать" Тогда
		Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТипСтрока.Видимость = Истина;
		Элементы.ПоказатьСкрытьТип.Картинка = БиблиотекаКартинок.УстановитьФлажки;
	Иначе
		Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТипСтрока.Видимость = Ложь;
		Элементы.ПоказатьСкрытьТип.Картинка = БиблиотекаКартинок.СнятьФлажки;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСкрытьВид(Команда)
	Если Не Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыВидСтрока.Видимость  Или Команда = "Показать" Тогда
		Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыВидСтрока.Видимость = Истина;
		Элементы.ПоказатьСкрытьВид.Картинка = БиблиотекаКартинок.УстановитьФлажки;
	Иначе
		Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыВидСтрока.Видимость = Ложь;
		Элементы.ПоказатьСкрытьВид.Картинка = БиблиотекаКартинок.СнятьФлажки;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСкрытьВидимость(Команда)
	Если Не Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТекущаяВидимость.Видимость  Или Команда = "Показать" Тогда
		Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТекущаяВидимость.Видимость = Истина;
		Элементы.ПоказатьСкрытьВидимость.Картинка = БиблиотекаКартинок.УстановитьФлажки;
	Иначе
		Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТекущаяВидимость.Видимость = Ложь;
		Элементы.ПоказатьСкрытьВидимость.Картинка = БиблиотекаКартинок.СнятьФлажки;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСкрытьДоступность(Команда)
	Если Не Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТекущаяДоступность.Видимость  Или Команда = "Показать" Тогда
		Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТекущаяДоступность.Видимость = Истина;
		Элементы.ПоказатьСкрытьДоступность.Картинка = БиблиотекаКартинок.УстановитьФлажки;
	Иначе
		Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТекущаяДоступность.Видимость = Ложь;
		Элементы.ПоказатьСкрытьДоступность.Картинка = БиблиотекаКартинок.СнятьФлажки;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСкрытьТолькоПросмотр(Команда)
	Если Не Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТекущееТолькоПросмотр.Видимость  Или Команда = "Показать" Тогда
		Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТекущееТолькоПросмотр.Видимость = Истина;
		Элементы.ПоказатьСкрытьТолькоПросмотр.Картинка = БиблиотекаКартинок.УстановитьФлажки;
	Иначе
		Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТекущееТолькоПросмотр.Видимость = Ложь;
		Элементы.ПоказатьСкрытьТолькоПросмотр.Картинка = БиблиотекаКартинок.СнятьФлажки;
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура СкрытьДопКолонки()
	ПоказатьСкрытьТип("");
	ПоказатьСкрытьВид("");
	ПоказатьСкрытьВидимость("");
	ПоказатьСкрытьДоступность("");
	ПоказатьСкрытьТолькоПросмотр("");
	Элементы.ПоказатьСкрытьВсеКолонки.Картинка = БиблиотекаКартинок.УстановитьФлажки;
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьОкно(Команда)
	Попытка
		ВсеОкна = Ванесса.ОбъектКонтекстСохраняемый.ТестовоеПриложение.НайтиОбъекты(Тип("ТестируемоеОкноКлиентскогоПриложения"));
	Исключение
		ВсеОкна = Новый Массив;
	КонецПопытки;
	
	СписокДляВыбора = Новый СписокЗначений();
	Для Сч = 0 По ВсеОкна.Количество() - 1 Цикл
		ТекОкно = ВсеОкна[ВсеОкна.Количество() - 1 - Сч];
		СписокДляВыбора.Добавить(ТекОкно.Заголовок);
	КонецЦикла;	 
	
	Оповещение = Новый ОписаниеОповещения("ПоказатьВыборЭлементаОкончание", ЭтаФорма);
	СписокДляВыбора.ПоказатьВыборЭлемента(Оповещение, Ванесса.Локализовать("Выберите окно."));
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьВыборЭлементаОкончание(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт
	ЗаголовокОкнаДляПолученияДанных = ВыбранныйЭлемент.Значение;
	ПолучатьДанныеТекущегоОкна = Ложь;
	Обновить();
КонецПроцедуры 

&НаКлиенте
Процедура ПоказатьСкрытьВсеКолонки(Команда)

	Если Не Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыТипСтрока.Видимость Или
		 Не Элементы.ДеревоФормы.ПодчиненныеЭлементы.ДеревоФормыВидСтрока.Видимость 
		Тогда

		ПоказатьСкрытьТип("Показать");
		ПоказатьСкрытьВид("Показать");
		ПоказатьСкрытьВидимость("Показать");
		ПоказатьСкрытьДоступность("Показать");
		ПоказатьСкрытьТолькоПросмотр("Показать");
		Элементы.ПоказатьСкрытьВсеКолонки.Картинка = БиблиотекаКартинок.СнятьФлажки;
		
	Иначе
		СкрытьДопКолонки();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	ОтключитьОбработчикОжидания("ПроверкаАктивногоЭлементаОткрытойФормы");
КонецПроцедуры

&НаКлиенте
Процедура ВключитьПоискАктивногоЭлементаФомры()
	Если Не ПолучатьАктивныйЭлементИзTestClient Тогда
		ОтключитьОбработчикОжидания("ПроверкаАктивногоЭлементаОткрытойФормы");
	Иначе	
		Если ТекущийTestclientЭтоWebКлиент Тогда
			ПодключитьОбработчикОжидания("ПроверкаАктивногоЭлементаОткрытойФормы",2,Ложь);
		Иначе
			ПодключитьОбработчикОжидания("ПроверкаАктивногоЭлементаОткрытойФормы",1,Ложь);
		КонецЕсли;	 
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьАктивныйЭлементИзTestClientПриИзменении(Элемент)
	ВключитьПоискАктивногоЭлементаФомры();
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "ЗапускСценариевVB" Тогда
		ПолучатьАктивныйЭлементИзTestClient = Ложь;
		ВключитьПоискАктивногоЭлементаФомры();
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьЭлементФормыВКеш(Элем)
	Если ТипЗнч(Элем) = Тип("ТестируемаяФорма") Тогда
		Возврат;
	КонецЕсли;
	
	Если КешЭлементовФормыПоИменам = Неопределено Тогда
		КешЭлементовФормыПоИменам = Новый Соответствие;
	КонецЕсли;	 
	
	Попытка
		ИмяЭлемента = Элем.Имя;
	Исключение
		Возврат; 
	КонецПопытки;
	
	КешЭлементовФормыПоИменам.Вставить(ИмяЭлемента, Элем);
КонецПроцедуры 

&НаКлиенте
Функция ПолучитьЭлементФормыИзКеш(ИмяЭлемента)
	Если КешЭлементовФормыПоИменам = Неопределено Тогда
		КешЭлементовФормыПоИменам = Новый Соответствие;
	КонецЕсли;	 
	
	Возврат КешЭлементовФормыПоИменам[ИмяЭлемента]; 
КонецФункции	 
