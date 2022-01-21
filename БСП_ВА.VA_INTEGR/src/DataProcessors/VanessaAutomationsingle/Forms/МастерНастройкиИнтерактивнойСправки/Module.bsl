#Область ОписаниеПеременных

&НаКлиенте
Перем Ванесса;

#КонецОбласти

#Область ОбработкаСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ПроверяемыйФичаФайл = Параметры.ПроверяемыйФичаФайл;
	Если ТипЗнч(Параметры.ДопПараметры) = Тип("Структура") Тогда
		Если Параметры.ДопПараметры.Свойство("СтрокаMDФайла") Тогда
			СтрокаMDФайла = Параметры.ДопПараметры.СтрокаMDФайла;
		ИначеЕсли Параметры.ДопПараметры.Свойство("СкачатьУроки") Тогда			
			СкачатьУроки = Параметры.ДопПараметры.СкачатьУроки;
		КонецЕсли;	 
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Элементы.ФормаПродолжитьУрок.Доступность = Ложь;
	Ванесса = ВладелецФормы;
	ОтобразитьЗначенияНастроек();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Ванесса = Неопределено;
	
КонецПроцедуры

#КонецОбласти

#Область КомандыФормы

&НаКлиенте
Процедура ВключитьИспользованиеВнешнейКомпоненты(Команда)
	
	Ванесса.ВключитьИспользованиеВнешнейКомпоненты();
	ПодключитьОбработчикОжидания("ОтобразитьЗначенияНастроекОбработчик", 1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура СкачатьКешОзвучки(Команда)
	
	Элементы.КартинкаКешОзвучкиИдетСкачивание.Видимость = Истина;
	Элементы.СкачатьКешОзвучки.Видимость = Ложь;
	ПодключитьОбработчикОжидания("СкачатьКешОзвучкиОбработчик", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура СкачатьУроки(Команда)
	
	Элементы.КартинкаСкачатьУрокиИдетСкачивание.Видимость = Истина;
	Элементы.СкачатьУроки.Видимость = Ложь;
	ПодключитьОбработчикОжидания("СкачатьСкачатьУрокиОбработчик", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПродолжитьУрок(Команда)
	
	Если ЗначениеЗаполнено(СтрокаMDФайла) Тогда
		Ванесса.ЗапуститьУрокИнтерактивнойСправки(СтрокаMDФайла);
	КонецЕсли;	 
	ЭтаФорма.Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОтобразитьЗначенияНастроек()
	МожноПродолжитьУрок = Истина;
	
	Элементы.КартинкаВключенаКомпонентаОшибка.Видимость = НЕ Ванесса.Объект.ИспользоватьКомпонентуVanessaExt;
	Элементы.ВключитьИспользованиеВнешнейКомпоненты.Видимость = НЕ Ванесса.Объект.ИспользоватьКомпонентуVanessaExt;
	Элементы.КартинкаВключенаКомпонентаОК.Видимость = Ванесса.Объект.ИспользоватьКомпонентуVanessaExt;
	Элементы.ИспользованиеКомпонентыВыключено.Видимость = НЕ Ванесса.Объект.ИспользоватьКомпонентуVanessaExt;
	Элементы.ИспользованиеКомпонентыВключено.Видимость = Ванесса.Объект.ИспользоватьКомпонентуVanessaExt;
	Если НЕ Ванесса.Объект.ИспользоватьКомпонентуVanessaExt Тогда
		МожноПродолжитьУрок = Ложь;
	КонецЕсли;	 
	
	Результат = НайденКешОзвучки();
	Элементы.КартинкаКешОзвучкиОК.Видимость = Результат;
	Элементы.КартинкаКешОзвучкиОшибка.Видимость = НЕ Результат;
	Элементы.СкачатьКешОзвучки.Видимость = НЕ Результат;
	Элементы.КартинкаКешОзвучкиНеНайден.Видимость = НЕ Результат;
	Элементы.КартинкаКешОзвучкиНайден.Видимость = Результат;
	Элементы.КартинкаКешОзвучкиИдетСкачивание.Видимость = Ложь;
	Если НЕ Результат Тогда
		МожноПродолжитьУрок = Ложь;
	КонецЕсли;
	Если СкачатьУроки Тогда
		МожноПродолжитьУрок = Ложь;
	КонецЕсли;	 
	
	Элементы.КартинкаСкачатьУрокиОК.Видимость = НЕ СкачатьУроки;
	Элементы.КартинкаСкачатьУрокиОшибка.Видимость = СкачатьУроки;
	Элементы.КартинкаСкачатьУрокиНеНайдены.Видимость = СкачатьУроки;
	Элементы.КартинкаСкачатьУрокиИдетСкачивание.Видимость = Ложь;
	Элементы.КартинкаСкачатьУрокиНайдены.Видимость = НЕ СкачатьУроки;
	Элементы.СкачатьУроки.Видимость = СкачатьУроки;
	
	Элементы.ФормаПродолжитьУрок.Доступность = МожноПродолжитьУрок;
	
КонецПроцедуры 

&НаКлиенте
Процедура ОтобразитьЗначенияНастроекОбработчик()
	ОтобразитьЗначенияНастроек();
КонецПроцедуры 

&НаКлиенте
Функция НайденКешОзвучки()
	
	ИмяКаталога = КаталогИнтерактивнойСправки();
	Если НЕ Ванесса.ФайлСуществуетКомандаСистемы(ИмяКаталога) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ДанныеКешОзвучкиИнтерактивнойСправки = Ванесса.ПрочитатьДанныеКешОзвучкиИнтерактивнойСправки();

	Если ЗначениеЗаполнено(ПроверяемыйФичаФайл) И
			НЕ Ванесса.ВКешЕстьВсеMp3ДляДаннойФичи(ДанныеКешОзвучкиИнтерактивнойСправки, ПроверяемыйФичаФайл) Тогда
		Возврат Ложь;
	КонецЕсли;	 
	
	Возврат Истина;
	
КонецФункции	 

&НаКлиенте
Функция КаталогИнтерактивнойСправки()
	
	ИмяКаталога = Ванесса.Объект.КаталогКешОзвучкиДляИнтерактивнойСправки;
	Если НЕ ЗначениеЗаполнено(ИмяКаталога) ИЛИ НЕ Ванесса.ФайлСуществуетКомандаСистемы(ИмяКаталога) Тогда
		ИмяКаталога = Ванесса.ДополнитьСлешВПуть(Ванесса.Объект.КаталогИнструментов) + "HelpTTS";
		Ванесса.Объект.КаталогКешОзвучкиДляИнтерактивнойСправки = ИмяКаталога;
	КонецЕсли;	 
	
	Возврат ИмяКаталога; 
	
КонецФункции	 

&НаКлиенте
Функция КаталогУроков()
	
	ИмяКаталога = Ванесса.ДополнитьСлешВПуть(Ванесса.Объект.КаталогИнструментов) + "training";
	Возврат ИмяКаталога; 
	
КонецФункции	 

&НаКлиенте
Процедура ПослеОтветаНаВопросОбОчисткеКаталогаКешаОзвучки(Результат, ДопПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
		Ванесса.ОчиститьСодержимоеКаталога(ДопПараметры.ИмяКаталога);
	Иначе
		Возврат;
	КонецЕсли;	 
	
	ПродолжитьСкачиваниеКешОзвучки(ДопПараметры.ИмяКаталога);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеОтветаНаВопросОбОчисткеКаталогаУроков(Результат, ДопПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
		Ванесса.ОчиститьСодержимоеКаталога(ДопПараметры.ИмяКаталога);
	Иначе
		Возврат;
	КонецЕсли;	 
	
	ПродолжитьСкачиваниеУроков(ДопПараметры.ИмяКаталога);
	
КонецПроцедуры

&НаКлиенте
Процедура ПродолжитьСкачиваниеКешОзвучки(ИмяКаталога)
	
	НомерРелиза = НомерРелиза();
	
	АдресРесурса = "//github.com/";
	
	Адрес = "//github.com/Pr-Mex/vanessa-automation/releases/download/%НомерРелиза%/TTSCache.zip";
	Адрес = СтрЗаменить(Адрес, "%НомерРелиза%", НомерРелиза);
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("zip");
	
	Соединение = Новый HTTPСоединение(АдресРесурса,,,,,, Новый ЗащищенноеСоединениеOpenSSL);
	
	Заголовки = Новый Соответствие;
	
	Запрос = Новый HTTPЗапрос(Адрес, Заголовки);
	Запрос.Заголовки.Вставить("Accept-Charset", "utf-8");
	
	Ответ = Соединение.Получить(Запрос);
	
	Если Ответ.КодСостояния = 302 Тогда
		ПутьКФайлу = Ответ.Заголовки["Location"];
		Если ПутьКФайлу = Неопределено Тогда
			ПутьКФайлу = Ответ.Заголовки["location"];
		КонецЕсли;	 
		ПутьКФайлу = СтрЗаменить(ПутьКФайлу, "https:", "");
		Запрос = Новый HTTPЗапрос(ПутьКФайлу, Заголовки);
		Ответ = Соединение.Получить(Запрос, ИмяВременногоФайла);				
	Иначе
		ВызватьИсключение Ванесса.Локализовать("Не удалось установить кеш озвучки. Выполните действие вручную.");
	КонецЕсли;
	
	Если Ванесса.ФайлСуществуетКомандаСистемы(ИмяВременногоФайла) Тогда
		Архив = Новый ЧтениеZipФайла(ИмяВременногоФайла);
		Попытка
			Архив.ИзвлечьВсе(ИмяКаталога);
			ТекстСообщения = Ванесса.Локализовать("Кеш озвучки успешно установлен.");	
		Исключение
			ТекстСообщения = Ванесса.Локализовать("Не удалось установить кеш озвучки. Выполните действие вручную.");
		КонецПопытки;
		
		ПоказатьОповещениеПользователя(,, ТекстСообщения);
	КонецЕсли;
	
	Ванесса.УдалитьФайлыКомандаСистемы(ИмяВременногоФайла);
	
	Ванесса.СброситьКешОзвучкиИнтерактивнойСправки();
	
	ПодключитьОбработчикОжидания("ОтобразитьЗначенияНастроекОбработчик", 1, Истина);
КонецПроцедуры 

&НаКлиенте
Процедура ПродолжитьСкачиваниеУроков(ИмяКаталога)
	
	НомерРелиза = НомерРелиза();
	
	АдресРесурса = "//github.com/";
	
	Адрес = "//github.com/Pr-Mex/vanessa-automation/releases/download/%НомерРелиза%/training.zip";
	Адрес = СтрЗаменить(Адрес, "%НомерРелиза%", НомерРелиза);
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("zip");
	
	Соединение = Новый HTTPСоединение(АдресРесурса,,,,,, Новый ЗащищенноеСоединениеOpenSSL);
	
	Заголовки = Новый Соответствие;
	
	Запрос = Новый HTTPЗапрос(Адрес, Заголовки);
	Запрос.Заголовки.Вставить("Accept-Charset", "utf-8");
	
	Ответ = Соединение.Получить(Запрос);
	
	Если Ответ.КодСостояния = 302 Тогда
		ПутьКФайлу = Ответ.Заголовки["Location"];
		Если ПутьКФайлу = Неопределено Тогда
			ПутьКФайлу = Ответ.Заголовки["location"];
		КонецЕсли;	 
		ПутьКФайлу = СтрЗаменить(ПутьКФайлу, "https:", "");
		Запрос = Новый HTTPЗапрос(ПутьКФайлу, Заголовки);
		Ответ = Соединение.Получить(Запрос, ИмяВременногоФайла);				
	Иначе
		ВызватьИсключение Ванесса.Локализовать("Не удалось скачать уроки. Выполните действие вручную.");
	КонецЕсли;
	
	Если Ванесса.ФайлСуществуетКомандаСистемы(ИмяВременногоФайла) Тогда
		Архив = Новый ЧтениеZipФайла(ИмяВременногоФайла);
		Попытка
			Архив.ИзвлечьВсе(ИмяКаталога);
			ТекстСообщения = Ванесса.Локализовать("Уроки успешно установлены.");
		Исключение
			ТекстСообщения = Ванесса.Локализовать("Не удалось скачать уроки. Выполните действие вручную.");
		КонецПопытки;
		
		ПоказатьОповещениеПользователя(,, ТекстСообщения);
	КонецЕсли;
	
	Ванесса.УдалитьФайлыКомандаСистемы(ИмяВременногоФайла);
	
	СкачатьУроки = Ложь;
	
	ПодключитьОбработчикОжидания("ОтобразитьЗначенияНастроекОбработчик", 1, Истина);
КонецПроцедуры 

&НаКлиенте
Процедура СкачатьКешОзвучкиОбработчик()
	
	ИмяКаталога = КаталогИнтерактивнойСправки();
	
	Если НЕ Ванесса.ФайлСуществуетКомандаСистемы(ИмяКаталога) Тогда
		Ванесса.СоздатьКаталогКомандаСистемы(ИмяКаталога);
	КонецЕсли;
	
	Если НЕ Ванесса.ФайлСуществуетКомандаСистемы(ИмяКаталога) Тогда
		ВызватьИсключение Ванесса._СтрШаблон(Ванесса.Локализовать("Каталог <%1> не найден."), ИмяКаталога);
	КонецЕсли;
	
	СписокКаталогов = Новый СписокЗначений;
	СписокФайлов = Новый СписокЗначений;
	Ванесса.НайтиФайлыКомандаСистемы(ИмяКаталога, СписокКаталогов, СписокФайлов, Истина);
	
	Если СписокКаталогов.Количество() > 0 ИЛИ СписокФайлов.Количество() > 0 Тогда
		ТекстВопроса = Ванесса._СтрШаблон(Ванесса.Локализовать("Каталог <%1> будет очищен. Продолжить?"), ИмяКаталога);
		ДопПараметры = Новый Структура;
		ДопПараметры.Вставить("ИмяКаталога", ИмяКаталога);
		ОписаниеОповещения = Новый ОписаниеОповещения("ПослеОтветаНаВопросОбОчисткеКаталогаКешаОзвучки", ЭтаФорма, ДопПараметры);
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ОКОтмена, 0, КодВозвратаДиалога.ОК);
		Возврат;
	КонецЕсли;	 
	
	ПродолжитьСкачиваниеКешОзвучки(ИмяКаталога);
	
КонецПроцедуры 

&НаКлиенте
Процедура СкачатьСкачатьУрокиОбработчик()
	
	ИмяКаталога = КаталогУроков();
	
	Если НЕ Ванесса.ФайлСуществуетКомандаСистемы(ИмяКаталога) Тогда
		Ванесса.СоздатьКаталогКомандаСистемы(ИмяКаталога);
	КонецЕсли;
	
	Если НЕ Ванесса.ФайлСуществуетКомандаСистемы(ИмяКаталога) Тогда
		ВызватьИсключение Ванесса._СтрШаблон(Ванесса.Локализовать("Каталог <%1> не найден."), ИмяКаталога);
	КонецЕсли;
	
	СписокКаталогов = Новый СписокЗначений;
	СписокФайлов = Новый СписокЗначений;
	Ванесса.НайтиФайлыКомандаСистемы(ИмяКаталога, СписокКаталогов, СписокФайлов, Истина);
	
	Если СписокКаталогов.Количество() > 0 ИЛИ СписокФайлов.Количество() > 0 Тогда
		ТекстВопроса = Ванесса._СтрШаблон(Ванесса.Локализовать("Каталог <%1> будет очищен. Продолжить?"), ИмяКаталога);
		ДопПараметры = Новый Структура;
		ДопПараметры.Вставить("ИмяКаталога", ИмяКаталога);
		ОписаниеОповещения = Новый ОписаниеОповещения("ПослеОтветаНаВопросОбОчисткеКаталогаУроков", ЭтаФорма, ДопПараметры);
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ОКОтмена, 0, КодВозвратаДиалога.ОК);
		Возврат;
	КонецЕсли;	 
	
	ПродолжитьСкачиваниеУроков(ИмяКаталога);
	
КонецПроцедуры 

&НаКлиенте
Функция НомерРелиза()
	
	НомерРелиза = Ванесса.ВерсияVanessaAutomation();
	НомерРелиза = СокрЛП(СтрЗаменить(НомерРелиза, "ver", ""));
	МассивСтрок = Ванесса._СтрРазделить(НомерРелиза, ".");
	Если МассивСтрок.Количество() <> 4 Тогда
		ВызватьИсключение Ванесса._СтрШаблон(Ванесса.Локализовать("Не получилось корректно определить номер версии Vanessa Automation по строке <%1>."), НомерРелиза);
	КонецЕсли;	 
	
	МассивСтрок[3] = "1";
	НомерРелиза = Ванесса._СтрСоединить(МассивСтрок, ".");
	
	Возврат НомерРелиза; 
	
КонецФункции	 

#КонецОбласти