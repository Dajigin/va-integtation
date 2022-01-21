
#Область ОписаниеПеременных

&НаКлиенте
Перем Ванесса;

#КонецОбласти

#Область ОбработкаСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТаблицаИзвестныхStepDefinition.Загрузить(Параметры.ТаблицаИзвестныхStepDefinition.Выгрузить());
	
	ЯзыкГенератораGherkin = Параметры.ЯзыкГенератораGherkin;
	Элементы.ПоказатьШагиНаРусском.Видимость = (ЯзыкГенератораGherkin <> "ru");
	
	КаталогИнструментов   = Параметры.КаталогИнструментов;
	МакетШаблонПеревода   = Параметры.МакетШаблонПеревода;
	ДвоичныеДанныеФайлПеревода = ЗначениеВСтрокуВнутр(Параметры.ДвоичныеДанныеФайлПеревода);
	ПараметрСнипет = Параметры.Снипет;
	
	Для Каждого СтрокаТаблицаУжеСуществующихСценариев Из Параметры.ТаблицаУжеСуществующихСценариев Цикл
		СтрокаТаблицаИзвестныхStepDefinition = ТаблицаИзвестныхStepDefinition.Добавить();
		
		СтрокаТаблицаИзвестныхStepDefinition.ИмяФайла           = СтрокаТаблицаУжеСуществующихСценариев.ИмяФайла;
		СтрокаТаблицаИзвестныхStepDefinition.ТипШага            = СтрокаТаблицаУжеСуществующихСценариев.ТипШага;
		СтрокаТаблицаИзвестныхStepDefinition.ПредставлениеТеста = СтрокаТаблицаУжеСуществующихСценариев.ПримерИспользования;
		СтрокаТаблицаИзвестныхStepDefinition.ОписаниеШага       = СтрокаТаблицаУжеСуществующихСценариев.ОписаниеШага;
		СтрокаТаблицаИзвестныхStepDefinition.СтрокаДляПоиска    = СтрокаТаблицаУжеСуществующихСценариев.Снипет;
		СтрокаТаблицаИзвестныхStepDefinition.id                 = СтрокаТаблицаУжеСуществующихСценариев.Снипет;
	КонецЦикла;
	
	УстановитьВидимостьОписанийШагов(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Ванесса = ВладелецФормы;
	
	Если ЯзыкГенератораGherkin = "ru" Тогда
		Элементы.ПоказатьПеревод.Видимость = Ложь;
	Иначе
		Если Ванесса.КешДанныеПеревода.ТаблицаПеревода = Неопределено Тогда
			Ванесса.ПеревестиТекст("");
			КешТаблицыПеревода = Ванесса.КешДанныеПеревода.ТаблицаПеревода;
		Иначе
			Если Ванесса.КешДанныеПеревода.Язык = ЯзыкГенератораGherkin Тогда
				КешТаблицыПеревода = Ванесса.КешДанныеПеревода.ТаблицаПеревода;
			КонецЕсли;	 
		КонецЕсли;	 
	КонецЕсли;	 
	
	ДвДанныеvbFeatureReader = ПолучитьДДFeatureReader();
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("ПараметрСнипет",ПараметрСнипет);
	ДопПараметры.Вставить("ТекстСообщенийПользователю",Ванесса.ДанныеПереводаСообщенийПользователю());
	ЗаполнитьДеревоИзвестныхШаговНаСервере(ДвДанныеvbFeatureReader,ДопПараметры);
	
	Если ЗначениеЗаполнено(ДопПараметры.ПараметрСнипет) Тогда
		АктивизироватьСтрокуПоСнипету(ДопПараметры.ПараметрСнипет);
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	ОтключениеМодуля();
	
КонецПроцедуры

#КонецОбласти

#Область ЭкспортныеПроцедурыИФункции

// Делает отключение модуля
&НаКлиенте
Функция ОтключениеМодуля() Экспорт
	
	Ванесса = Неопределено;
	
КонецФункции	 

// Возвращает данные команды
&НаКлиенте
Функция ДанныеКомандыVanessaAutomation(ИмяКоманды) Экспорт
	Возврат ДанныеКомандыVanessaAutomationСервер(ИмяКоманды); 
КонецФункции	 

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПоказыватьСлужебныеШагиПриИзменении(Элемент)
	ЗаполнитьДеревоИзвестныхШагов();
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьУстаревшиеШагиПриИзменении(Элемент)
	ЗаполнитьДеревоИзвестныхШагов();
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьШагиНаРусскомПриИзменении(Элемент)
	ТекстШага = ПолучитьТекстШагаТекущейСтроки(Истина);
	
	УстановитьВидимостьОписанийШагов(ЭтаФорма);
	ДвДанныеvbFeatureReader = ПолучитьДДFeatureReader();
	
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("ТекстСообщенийПользователю",Ванесса.ДанныеПереводаСообщенийПользователю());
	ЗаполнитьДеревоИзвестныхШаговНаСервере(ДвДанныеvbFeatureReader,ДопПараметры);
	
	Если ЗначениеЗаполнено(ТекстШага) Тогда
		АктивизироватьСтрокуДереваСНужнымШагом(ТекстШага);
	КонецЕсли;	 
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиШагиПриИзменении(Элемент)
	
	ВыполнитьПоиск();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоШагов

&НаКлиенте
Процедура ДеревоШаговВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Если Не ЗначениеЗаполнено(Элемент.ТекущиеДанные.ПредставлениеТеста) Тогда
		Возврат;
	КонецЕсли;	
	
	Значение = Новый Структура;
	Значение.Вставить("Текст", Элемент.ТекущиеДанные.ПредставлениеТеста + Символы.ПС);
	Значение.Вставить("ИдФормы", Ванесса.УникальныйИдентификатор);
	Оповестить("ВыборИзвестногоШага", Значение);
	ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Добавил шаг: %1");
	ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Элемент.ТекущиеДанные.ПредставлениеТеста);
	Сообщить(Ванесса.ПолучитьТекстСообщенияПользователю(ТекстСообщения));
КонецПроцедуры

&НаКлиенте
Процедура ДеревоШаговИмяФайлаПолеОткрытие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ТекДанные = Элементы.ДеревоШагов.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	СвойстваФайла = РазложитьПутьКФайлу(ТекДанные.ИмяФайла);
	ЗапуститьПриложение(СвойстваФайла.Путь);	
КонецПроцедуры

#КонецОбласти 

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыгрузитьШагиВJSON(Команда)
	
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогВыбораФайла.МножественныйВыбор = Ложь;
	ДиалогВыбораФайла.Фильтр = "(*.json)|*.json";
	ДиалогВыбораФайла.Показать(Вычислить("Новый ОписаниеОповещения(""ВыгрузитьШагиВJSONВыборФайлаЗавершение"", ЭтаФорма)"));
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиШаги(Команда)

	ВыполнитьПоиск();

КонецПроцедуры

&НаКлиенте
Процедура ПоказатьПеревод(Команда)
	
	ДанныеПеревода = Новый Структура;
	ДанныеПеревода.Вставить("ЯзыкПеревода", ЯзыкГенератораGherkin);	
	ДанныеПеревода.Вставить("ДвоичныеДанныеФайлПеревода", ПолучитьДвоичныеДанныеФайлПереводаСервер());
	ДанныеПеревода.Вставить("ФормированиеТаблицыДляДальнейшегоПеревода", Истина);
	ДанныеПеревода.Вставить("ВерсияПоставки", Ванесса.Объект.ВерсияПоставки);
	ДанныеПеревода.Вставить("СтруктураПараметров", Ванесса.СлужебныеДанныеДляПарсераФич());
	
	ДвДанныеvbFeatureReader = Неопределено;
	Если НЕ Ванесса.ВозможнаОптимизацияРаботыСФайлами() Тогда
		ДвДанныеvbFeatureReader = ПолучитьДДFeatureReader();
	КонецЕсли;	 
	ДанныеПеревода.Вставить("ДвДанныеvbFeatureReader", ДвДанныеvbFeatureReader);
	
	ТабДок = ПоказатьПереводТекстаGherkin(ДанныеПеревода);
	ТабДок.Показать();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьФорму(Команда)
	Закрыть();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Сервис

&НаСервереБезКонтекста
Функция РазложитьСтрокуВМассивПодстрок(Знач Строка, Знач Разделитель = ",", Знач ПропускатьПустыеСтроки = Неопределено) Экспорт
	
	Результат = Новый Массив;
	
	// для обеспечения обратной совместимости
	Если ПропускатьПустыеСтроки = Неопределено Тогда
		ПропускатьПустыеСтроки = ?(Разделитель = " ", Истина, Ложь);
		Если ПустаяСтрока(Строка) Тогда 
			Если Разделитель = " " Тогда
				Результат.Добавить("");
			КонецЕсли;
			Возврат Результат;
		КонецЕсли;
	КонецЕсли;
		
	Позиция = Найти(Строка, Разделитель);
	Пока Позиция > 0 Цикл
		Подстрока = Лев(Строка, Позиция - 1);
		Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Подстрока) Тогда
			Результат.Добавить(Подстрока);
		КонецЕсли;
		Строка = Сред(Строка, Позиция + СтрДлина(Разделитель));
		Позиция = Найти(Строка, Разделитель);
	КонецЦикла;
	
	Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Строка) Тогда
		Результат.Добавить(Строка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции 

&НаКлиенте
Функция СоединитьСтроки(Строки, Разделитель)
	
	Результат = "";
	Счетчик = 0;
	Для каждого Строка Из Строки Цикл
		Счетчик = Счетчик + 1;
		РазделительТекущий = ?(Счетчик = 1, "", Разделитель);
		Результат = Результат + РазделительТекущий + Строка;		
	КонецЦикла; 
	
	Возврат Результат;
	
КонецФункции 

&НаСервереБезКонтекста
Процедура КешСнипетовИзХранилищаЗначений(СтруктураПараметров)
	Если СтруктураПараметров.КешСнипетов = Неопределено Тогда
		СтруктураПараметров.КешСнипетов = Новый Соответствие;
	Иначе
		АдресВременногоХранилища = СтруктураПараметров.КешСнипетов;
		СтруктураПараметров.Вставить("КешСнипетов",ПолучитьИзВременногоХранилища(АдресВременногоХранилища));
	КонецЕсли;	 
КонецПроцедуры 

// Универсальная функция для парсинга строк
//
// Параметры:
//  ИсходнаяСтрока - Строка
//  СтрокаРазделитель - Строка
//  ОбрезатьПробелы - Булево
//
// Возвращаемое значение:
//  СтруктураЧастиСтроки - Структура
//   * Левая - Строка - Левая часть строки (до начала СтрокаРазделитель)
//   * Правая - Строка - Правая часть строки (после окончания СтрокаРазделитель)
//   * Разбито - Булево - флаг указывающий что в исходной строке есть СтрокаРазделитель 
//
&НаКлиентеНаСервереБезКонтекста
Функция РазбитьСтроку(ИсходнаяСтрока, СтрокаРазделитель, ОбрезатьПробелы = Истина)
    
    поз = Найти(ИсходнаяСтрока, СтрокаРазделитель);
    ДлинаРазделителя = СтрДлина(СтрокаРазделитель);    
    Разбито = поз > 0;
    ЛеваяЧастьСтроки = Лев(ИсходнаяСтрока, поз - 1);
    Если ОбрезатьПробелы Тогда
        ЛеваяЧастьСтроки = СокрЛП(ЛеваяЧастьСтроки);        
    КонецЕсли; 
    
    ПраваяЧастьСтроки = Сред(ИсходнаяСтрока, поз + ДлинаРазделителя);
    Если ОбрезатьПробелы Тогда
        ПраваяЧастьСтроки = СокрЛП(ПраваяЧастьСтроки);        
    КонецЕсли; 
    
    СтруктураЧастиСтроки = Новый Структура("Левая, Правая, Разбито"
    , ЛеваяЧастьСтроки
    , ПраваяЧастьСтроки
    , Разбито);
    
    Возврат СтруктураЧастиСтроки;
    
КонецФункции

&НаКлиенте
Функция РазложитьПутьКФайлу(ПутьКФайлу)
	
	Результат = Новый Структура;
	Результат.Вставить("ЭтоКаталог", Ложь);
	Результат.Вставить("Путь", "");
	Результат.Вставить("Расширение", "");
	Результат.Вставить("ИмяБезРасширения", "");
	Результат.Вставить("Имя", "");
	
	ЧастиСтроки = РазбитьСтроку(ПутьКФайлу, ".");
	Результат.ЭтоКаталог = НЕ ЧастиСтроки.Разбито;	
	Результат.Расширение = ЧастиСтроки.Правая;
	
	Если Результат.ЭтоКаталог Тогда
		Результат.Путь = ЧастиСтроки.Левая;
	Иначе
		Разделитель = ?(Ванесса.ЭтоLinux, "/", "\");
		ЧастиПути = РазложитьСтрокуВМассивПодстрок(ЧастиСтроки.Левая, Разделитель);
		ВГраница = ЧастиПути.ВГраница();
		
		Результат.ИмяБезРасширения = ЧастиПути[ВГраница];
		Результат.Имя = Результат.ИмяБезРасширения + "." + Результат.Расширение;
		ЧастиПути.Удалить(ВГраница);
		Результат.Путь = СоединитьСтроки(ЧастиПути, Разделитель);		
	КонецЕсли; 
	
	Возврат Результат;
	
КонецФункции 

#КонецОбласти 

#Область Диалог

#Область НастройкиФормы

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьОписанийШагов(Форма)
	ЭлементыФормы = Форма.Элементы;	
	ЭлементыФормы.ДеревоШаговПредставлениеТестаОригинал.Видимость = Форма.ПоказатьШагиНаРусском;
	ЭлементыФормы.ДеревоШаговОписаниеШагаОригинал.Видимость       = Форма.ПоказатьШагиНаРусском;
	
КонецПроцедуры 

#КонецОбласти 

#Область ОбработчикиОповещений

&НаКлиенте
Процедура ВыгрузитьШагиВJSONВыборФайлаЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ВыбранныеФайлы) Тогда
		Возврат;
	КонецЕсли;	 
	
	МассивДляВыгрузкиШагов = ПодготовитьТаблицуДляВыгрузкиШагов();
	
	
	ЗаписьJSON = Вычислить("Новый ЗаписьJSON");
	
	
	ЗаписьJSON.ОткрытьФайл(ВыбранныеФайлы[0]);
	
	ЗаписьJSON.ЗаписатьНачалоМассива();
	
	Для Каждого ШагДляВыгрузки Из МассивДляВыгрузкиШагов Цикл
		ЗаписьJSON.ЗаписатьНачалоОбъекта();
		
		
		Для Каждого СвойстваШага Из ШагДляВыгрузки Цикл
			ЗаписьJSON.ЗаписатьИмяСвойства(СвойстваШага.Ключ);
			ЗаписьJSON.ЗаписатьЗначение(СвойстваШага.Значение);
		КонецЦикла;	
		
		ЗаписьJSON.ЗаписатьКонецОбъекта();
	КонецЦикла;	
	
	
	ЗаписьJSON.ЗаписатьКонецМассива();
	
	ЗаписьJSON.Закрыть();
КонецПроцедуры

#КонецОбласти 

#КонецОбласти 

#Область FeatureReader

&НаКлиенте               
Функция ПолучитьДДFeatureReader()
	Если Ванесса.Объект.ВерсияПоставки = "single" Тогда
		Возврат Неопределено;
	Иначе	
		Возврат Новый ДвоичныеДанные(ЭтаФорма.ВладелецФормы.ПолучитьПутьКFeatureReader());
	КонецЕсли;	 
КонецФункции	

&НаСервере
Функция СоздатьFeatureReader(КаталогИнструментов, ДвДанныеvbFeatureReader, ВременноеИмяФайла)
	Если Объект.ВерсияПоставки = "single" Тогда
		ОбъектСервер = РеквизитФормыВЗначение("Объект");
		Возврат ОбъектСервер; 
	КонецЕсли;	 
	
	ФайлvbFeatureReader = Новый Файл(КаталогИнструментов + "\lib\FeatureReader\vbFeatureReader.epf");
	ВременноеИмяФайла = Неопределено;
	Если Не ФайлvbFeatureReader.Существует() Тогда
		ВременноеИмяФайла = ПолучитьИмяВременногоФайла("epf");
		ДвДанныеvbFeatureReader.Записать(ВременноеИмяФайла);
		FeatureReader = ВнешниеОбработки.Создать(ВременноеИмяФайла, Ложь);
	Иначе	
		FeatureReader = ВнешниеОбработки.Создать(ФайлvbFeatureReader.ПолноеИмя, Ложь);
	КонецЕсли;	 
	
	Возврат FeatureReader;
КонецФункции	

#КонецОбласти

#Область РаботаСДеревомШагов

&НаСервере
Процедура ДобавитьТипыШагов(Дерево,Тип,ТаблицаПеревода)
	НайденныеСтрокиДерева = Дерево.Строки.НайтиСтроки(Новый Структура("ПолныйТипШага",Тип),Истина);
	Если НайденныеСтрокиДерева.Количество() = 0 Тогда
		ТекСтроки = Дерево.Строки;
		МассивТип = РазложитьСтрокуВМассивПодстрок(Тип,".");
		ПолныйТипШага = "";
		Для Каждого ПодТип Из МассивТип Цикл
			ЕстьПеревод = Ложь;
			
			Если ТаблицаПеревода <> Неопределено Тогда
				СтрокаТаблицаПеревода = ТаблицаПеревода.Найти(НРег(ПодТип),"ОригиналРусскийШагНРег");
				Если СтрокаТаблицаПеревода <> Неопределено Тогда
					Если ЗначениеЗаполнено(СтрокаТаблицаПеревода.ТекстПереводаШаг) Тогда
						ПодТип = СтрокаТаблицаПеревода.ТекстПереводаШаг;
					КонецЕсли;	 
					ЕстьПеревод = Истина;
				КонецЕсли;	 
			КонецЕсли;	 
			
			Если ПолныйТипШага = "" Тогда
				ПолныйТипШага = ПодТип;
			Иначе
				ПолныйТипШага = ПолныйТипШага + "." + ПодТип;
			КонецЕсли;	 
			
			НайденныеСтрокиДерева = ТекСтроки.НайтиСтроки(Новый Структура("ТипШага",ПодТип),Ложь);
			Если НайденныеСтрокиДерева.Количество() = 0 Тогда
				ТекСтрока               = ТекСтроки.Добавить();
				ТекСтрока.ТипШага       = ПодТип;
				ТекСтрока.ПолныйТипШага = ПолныйТипШага;
				ТекСтрока.Язык          = "ru";
				Если ТаблицаПеревода <> Неопределено и ЕстьПеревод Тогда
					ТекСтрока.Язык          = ЯзыкГенератораGherkin;
				КонецЕсли;	 
				
				ТекСтроки = ТекСтрока.Строки;
			Иначе	
				ТекСтроки = НайденныеСтрокиДерева[0].Строки;
			КонецЕсли;	 
		КонецЦикла;	
	КонецЕсли;	 
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПреобразоватьТипПеревод(Тип,ТаблицаПеревода)
	МассивТип = РазложитьСтрокуВМассивПодстрок(Тип,".");
	ПолныйТипШага = "";
	Для Каждого ПодТип Из МассивТип Цикл
		СтрокаТаблицаПеревода = ТаблицаПеревода.Найти(НРег(ПодТип),"ОригиналРусскийШагНРег");
		Если СтрокаТаблицаПеревода <> Неопределено Тогда
			Если ЗначениеЗаполнено(СтрокаТаблицаПеревода.ТекстПереводаШаг) Тогда
				ПодТип = СтрокаТаблицаПеревода.ТекстПереводаШаг;
			КонецЕсли;	 
		КонецЕсли;	 
		
		Если ПолныйТипШага = "" Тогда
			ПолныйТипШага = ПодТип;
		Иначе
			ПолныйТипШага = ПолныйТипШага + "." + ПодТип;
		КонецЕсли;	 
	КонецЦикла;	
	
	Возврат ПолныйТипШага;
КонецФункции	

&НаСервере
Функция ДобавитьШаги(Дерево,Тип,Данные,ТаблицаПеревода,СтрТаблицаИзвестныхStepDefinition,ДопПараметры)
	
	Если ТаблицаПеревода <> Неопределено Тогда
		Тип = ПреобразоватьТипПеревод(Тип,ТаблицаПеревода);
	КонецЕсли;	 
	
	НайденныеСтрокиДерева = Дерево.Строки.НайтиСтроки(Новый Структура("ПолныйТипШага",Тип),Истина);
	Если НайденныеСтрокиДерева.Количество() = 0 Тогда
		ТекстСообщения = ПолучитьТекстСообщенияПользователюСервер("Не найден тип шага <%1>",ДопПараметры.ТекстСообщенийПользователю);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Тип);
		ВызватьИсключение(ТекстСообщения);
	КонецЕсли;
	
	
	СтрокаДерева = НайденныеСтрокиДерева[0];	
	СтрокаШага   = СтрокаДерева.Строки.Добавить();
	СтрокаШага.ПредставлениеТеста = Данные.ПредставлениеТеста;
	СтрокаШага.ОписаниеШага       = Данные.ОписаниеШага;
	СтрокаШага.ИмяПроцедуры       = Данные.СтрокаРеальнойПроцедуры;
	СтрокаШага.ТипШагаВДереве     = Данные.ТипШагаВДереве;
	Если СтрТаблицаИзвестныхStepDefinition <> Неопределено Тогда
		СтрокаШага.ОписаниеШагаОригинал = СтрТаблицаИзвестныхStepDefinition.ОписаниеШагаОригинал;
		СтрокаШага.ПредставлениеТестаОригинал = СтрТаблицаИзвестныхStepDefinition.ПредставлениеТестаОригинал;
	КонецЕсли;	 
	СтрокаШага.ИмяФайла = СтрЗаменить(Данные.ИмяФайла,"/","\");
	СтрокаШага.Язык = "ru";
	СтрокаШага.Снипет = Данные.ID;
	
	Если ТаблицаПеревода <> Неопределено Тогда
		СтрокаПоиска = СтрТаблицаИзвестныхStepDefinition.СтрокаДляПоиска;
		
		СтрокаТаблицаПеревода = ТаблицаПеревода.Найти(СтрокаПоиска,"СтрокаДляПоискаРусский");
		Если СтрокаТаблицаПеревода <> Неопределено Тогда
			СтрокаШага.Язык               = ЯзыкГенератораGherkin;
			Если ЗначениеЗаполнено(СтрокаТаблицаПеревода.ТекстПереводаШаг) Тогда
				СтрокаШага.ПредставлениеТеста = УбратьСлужебныеСимволыИзПредставления(СтрокаТаблицаПеревода.ТекстПереводаШаг);
			КонецЕсли;	 
			Если ЗначениеЗаполнено(СтрокаТаблицаПеревода.ТекстПереводаОписание) Тогда
				СтрокаШага.ОписаниеШага = СтрокаТаблицаПеревода.ТекстПереводаОписание;
			КонецЕсли;	 
		Иначе
			ТекстСообщения = ПолучитьТекстСообщенияПользователюСервер("Не найден перевод для шага <%1>",ДопПараметры.ТекстСообщенийПользователю);
			ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Данные.ПредставлениеТеста);
			Сообщить(ТекстСообщения);
		КонецЕсли;	 
	КонецЕсли;	 
	
	Возврат СтрокаШага;
	
КонецФункции

&НаСервере
Процедура СортироватьДеревоШагов(Дерево)
	Дерево.Строки.Сортировать("ТипШага,ОписаниеШага",Истина);
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоИзвестныхШаговНаСервере(ДвДанныеvbFeatureReader,ДопПараметры)
	ТабОригинал = РеквизитФормыВЗначение("ТаблицаИзвестныхStepDefinition");
	ТабОригинал.Колонки.Добавить("ПредставлениеТестаОригинал",Новый ОписаниеТипов("Строка"));
	ТабОригинал.Колонки.Добавить("ОписаниеШагаОригинал",Новый ОписаниеТипов("Строка"));

	ТаблицаПеревода = Неопределено;
	Если ЯзыкГенератораGherkin <> "ru" Тогда
		ТаблицаПеревода = ПолучитьТаблицуПеревода(ДвДанныеvbFeatureReader);
		ЗаменитьПредставлениеТестаВТаблице(ТаблицаПеревода,ТабОригинал);
		Если ДопПараметры.Свойство("ПараметрСнипет") Тогда
			Стр = ДопПараметры.ПараметрСнипет;
			Поз = Найти(Стр, "(");
			Если Поз > 0 Тогда
				Стр = Лев(Стр,Поз-1);
			КонецЕсли;
			
			Стр = НРег(Стр);
			СтрокаТаблицаПеревода = ТаблицаПеревода.Найти(Стр, "СтрокаДляПоискаПеревод");
			Если СтрокаТаблицаПеревода <> Неопределено Тогда
				ДопПараметры.ПараметрСнипет = СтрокаТаблицаПеревода.StepDefinitionРусский;
			КонецЕсли;	 
			
		КонецЕсли;	 
	КонецЕсли;	 
	
	Дерево = РеквизитФормыВЗначение("ДеревоШагов");
	
	Если Ложь Тогда
		Дерево = Новый ДеревоЗначений;
	КонецЕсли;
	Дерево.Строки.Очистить();
	
	//получить список шагов с учетом фильтра
	Если ЗначениеЗаполнено(ФильтрДереваШагов) Тогда
		
		ТабРезультат = ТабОригинал.Скопировать();
		ТабРезультат = ПолучитьРезультатПоиска(ТабОригинал,"ПредставлениеТеста");
		
		ТабРезультат.Индексы.Добавить("СтрокаДляПоиска");
		
		ТабРезультат2 = ТабОригинал.Скопировать();
		ТабРезультат2 = ПолучитьРезультатПоиска(ТабОригинал,"ОписаниеШага");
		ДополнитьТаблицуРезультатаПоиска(ТабРезультат,ТабРезультат2);
		
		Если ПоказатьШагиНаРусском Тогда
			ТабРезультат3 = ТабОригинал.Скопировать();
			ТабРезультат3 = ПолучитьРезультатПоиска(ТабОригинал,"ОписаниеШагаОригинал");
			ДополнитьТаблицуРезультатаПоиска(ТабРезультат,ТабРезультат3);
			
			ТабРезультат4 = ТабОригинал.Скопировать();
			ТабРезультат4 = ПолучитьРезультатПоиска(ТабОригинал,"ПредставлениеТестаОригинал");
			ДополнитьТаблицуРезультатаПоиска(ТабРезультат,ТабРезультат4);
		КонецЕсли;	 
	Иначе
		ТабРезультат = ТабОригинал;
	КонецЕсли;	
	
	Для Каждого СтрТаблицаИзвестныхStepDefinition Из ТабРезультат Цикл
		Тип = СокрЛП(СтрТаблицаИзвестныхStepDefinition.ТипШага);
		Если ПоказыватьСлужебныеШаги И Тип = "" Тогда
			Тип = "Служебные";
		ИначеЕсли Тип = "" Тогда
			Продолжить;
		КонецЕсли;
		
		Если НЕ ПоказыватьУстаревшиеШаги Тогда
			Если Найти(СтрТаблицаИзвестныхStepDefinition.ТипШага,"Устаревшее") > 0 Тогда
				Продолжить;
			КонецЕсли;	 
		КонецЕсли;	 
		
		ДобавитьТипыШагов(Дерево,Тип,ТаблицаПеревода); //группы
	КонецЦикла;
	
	Для Каждого СтрТаблицаИзвестныхStepDefinition Из ТабРезультат Цикл
		Тип = СокрЛП(СтрТаблицаИзвестныхStepDefinition.ТипШага);
		Если ПоказыватьСлужебныеШаги И Тип = "" Тогда
			Тип = "Служебные";
		ИначеЕсли Тип = "" Тогда
			Продолжить;
		КонецЕсли;
		
		Данные = СтрТаблицаИзвестныхStepDefinition;
		
		Если НЕ ПоказыватьУстаревшиеШаги Тогда
			Если Найти(Данные.ТипШага,"Устаревшее") > 0 Тогда
				Продолжить;
			КонецЕсли;	 
		КонецЕсли;	 
		
		СтрокаШага = ДобавитьШаги(Дерево,Тип,Данные,ТаблицаПеревода,СтрТаблицаИзвестныхStepDefinition,ДопПараметры);
	КонецЦикла;	
	
	СортироватьДеревоШагов(Дерево);	
	ЗначениеВРеквизитФормы(Дерево,"ДеревоШагов");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДеревоИзвестныхШагов()
	ДвДанныеvbFeatureReader = ПолучитьДДFeatureReader();
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("ТекстСообщенийПользователю",Ванесса.ДанныеПереводаСообщенийПользователю());
	ЗаполнитьДеревоИзвестныхШаговНаСервере(ДвДанныеvbFeatureReader,ДопПараметры);
КонецПроцедуры 

&НаКлиенте
Процедура РазвернутьСтрокиДерева(Дерево)
	
	Строки = Дерево.ПолучитьЭлементы();
	
	Для Каждого Строка Из Строки Цикл
		ИдентификаторСтроки = Строка.ПолучитьИдентификатор();
		Элементы.ДеревоШагов.Развернуть(ИдентификаторСтроки);

		РазвернутьСтрокиДерева(Строка);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура АктивизироватьСтрокуДереваСНужнымШагомРекурсивно(ПредставлениеТеста,Дерево,Нашли)
	Если Нашли Тогда
		Возврат;
	КонецЕсли;	 
	
	ЭлементыДерева = Дерево.ПолучитьЭлементы();
	Для Каждого СтрокаДерева Из ЭлементыДерева Цикл
		Если СтрокаДерева.ПредставлениеТеста = ПредставлениеТеста Тогда
			Элементы.ДеревоШагов.ТекущаяСтрока = СтрокаДерева.ПолучитьИдентификатор();
			Нашли = Истина;
			Возврат;
		КонецЕсли;
		
		АктивизироватьСтрокуДереваСНужнымШагомРекурсивно(ПредставлениеТеста,СтрокаДерева,Нашли);
	КонецЦикла;	
КонецПроцедуры

&НаКлиенте
Процедура АктивизироватьСтрокуДереваСНужнымШагом(ТекСтрока)
	Нашли = Ложь;
	АктивизироватьСтрокуДереваСНужнымШагомРекурсивно(ТекСтрока,ДеревоШагов,Нашли);
КонецПроцедуры

&НаКлиенте
Процедура АктивизироватьСтрокуПоСнипету(Знач Снипет)
	СтрокаДерева = Неопределено;
	Поз = Найти(Снипет,"(");
	Если Поз > 0 Тогда
		Снипет = Лев(Снипет,Поз-1);
	КонецЕсли;
	Снипет = НРег(Снипет);
	
	НайтиСтрокуПоСнипетуРекурсивно(Снипет,ДеревоШагов.ПолучитьЭлементы(),СтрокаДерева);
	Если СтрокаДерева <> Неопределено Тогда
		Элементы.ДеревоШагов.ТекущаяСтрока = СтрокаДерева.ПолучитьИдентификатор();
		ЭтаФорма.ТекущийЭлемент = Элементы.ДеревоШагов;
	КонецЕсли;	 
КонецПроцедуры 

&НаСервереБезКонтекста
Функция ПолучитьТекстСообщенияПользователюСервер(Текст,ТекстСообщенийПользователю)
	Значение = ТекстСообщенийПользователю[Текст];
	Если ЗначениеЗаполнено(Значение) Тогда
		Возврат Значение;
	КонецЕсли;	 
	
	Возврат Текст; 
КонецФункции

&НаКлиенте
Функция ПолучитьТекстШагаТекущейСтроки(ВсегдаПолучатьТекстШага = Ложь)
	ТекстШага = Неопределено;
	Если НЕ ЗначениеЗаполнено(ФильтрДереваШагов) или ВсегдаПолучатьТекстШага Тогда
		ТекСтрока = Элементы.ДеревоШагов.ТекущаяСтрока;
		Если ТекСтрока <> Неопределено Тогда
			СтрокаДерева = ДеревоШагов.НайтиПоИдентификатору(ТекСтрока);
			Если СтрокаДерева <> Неопределено Тогда
				ТекстШага = СтрокаДерева.ПредставлениеТеста;
			КонецЕсли;	 
		КонецЕсли;	 
	КонецЕсли;	 
	
	Возврат ТекстШага; 
КонецФункции	 

#КонецОбласти 

#Область Перевод

&НаСервере
Функция ПолучитьТаблицуПеревода(ДвДанныеvbFeatureReader)
	Если ЗначениеЗаполнено(КешТаблицыПеревода) Тогда
		Возврат ПолучитьИзВременногоХранилища(КешТаблицыПеревода);
	КонецЕсли;	 
КонецФункции	

&НаСервере
Функция УбратьСлужебныеСимволыИзПредставления(Знач Стр)
	Стр = СтрЗаменить(Стр,"%1 ","");
	Стр = СтрЗаменить(Стр,"%2 ","");
	Стр = СтрЗаменить(Стр,"%3 ","");
	Стр = СтрЗаменить(Стр,"%4 ","");
	Стр = СтрЗаменить(Стр,"%5 ","");
	Стр = СтрЗаменить(Стр,"%6 ","");
	Стр = СтрЗаменить(Стр,"%7 ","");
	
	Возврат Стр;
КонецФункции	

&НаСервере
Процедура ЗаменитьПредставлениеТестаВТаблице(ТаблицаПеревода,Тзн)
	Для Каждого СтрокаТзн Из Тзн Цикл
		СтрокаДляПоиска = СтрокаТзн.СтрокаДляПоиска;
		СтрТаблицаПеревода = ТаблицаПеревода.Найти(СтрокаДляПоиска,"СтрокаДляПоискаРусский");
		
		Если СтрТаблицаПеревода <> Неопределено Тогда
			Если ЗначениеЗаполнено(СтрТаблицаПеревода.ТекстПереводаШаг) Тогда
				СтрокаТзн.ПредставлениеТестаОригинал = СтрокаТзн.ПредставлениеТеста;
				СтрокаТзн.ПредставлениеТеста = СтрТаблицаПеревода.ТекстПереводаШаг;
			КонецЕсли;	 
			
			Если ЗначениеЗаполнено(СтрТаблицаПеревода.ТекстПереводаОписание) Тогда
				СтрокаТзн.ОписаниеШагаОригинал = СтрокаТзн.ОписаниеШага;
				СтрокаТзн.ОписаниеШага         = СтрТаблицаПеревода.ТекстПереводаОписание;
			КонецЕсли;	 
		КонецЕсли;	 
	КонецЦикла;	
КонецПроцедуры

&НаСервере
Функция УбратьЛишиниеСимволыИзТекста(Знач Стр)
	Стр = СтрЗаменить(Стр,Символы.Таб," ");
	Пока Найти(Стр,"  ") > 0 Цикл
		Стр = СтрЗаменить(Стр,"  "," ");
	КонецЦикла;	
	
	Возврат Стр;
КонецФункции	

&НаСервере
Процедура ДобавитьЗначенияВТаблицуДляПереодаРекурсивно(ТаблицаДляПереводаИзвестныхШагов,Дерево)
	Для Каждого СтрокаДерева Из Дерево.Строки Цикл
		Если СтрокаДерева.Язык = "ru" Тогда
			Если ЗначениеЗаполнено(СтрокаДерева.ТипШага) Тогда
				СтрокаТаблицаДляПереводаИзвестныхШагов = ТаблицаДляПереводаИзвестныхШагов.Найти(СтрокаДерева.ТипШага,"ОригиналРусскийШаг");
				Если СтрокаТаблицаДляПереводаИзвестныхШагов = Неопределено Тогда
					СтрокаТаблицаДляПереводаИзвестныхШагов = ТаблицаДляПереводаИзвестныхШагов.Добавить();
					СтрокаТаблицаДляПереводаИзвестныхШагов.ОригиналРусскийШаг          = СтрокаДерева.ТипШага;
					СтрокаТаблицаДляПереводаИзвестныхШагов.ОригиналРусскийОписаниеШага = "Категория шагов";
				КонецЕсли;	 
			Иначе
				СтрокаТаблицаДляПереводаИзвестныхШагов = ТаблицаДляПереводаИзвестныхШагов.Найти(СтрокаДерева.ПредставлениеТеста,"ОригиналРусскийШаг");
				Если СтрокаТаблицаДляПереводаИзвестныхШагов = Неопределено Тогда
					СтрокаТаблицаДляПереводаИзвестныхШагов = ТаблицаДляПереводаИзвестныхШагов.Добавить();
					СтрокаТаблицаДляПереводаИзвестныхШагов.ОригиналРусскийШаг          = УбратьЛишиниеСимволыИзТекста(СтрокаДерева.ПредставлениеТеста);
					СтрокаТаблицаДляПереводаИзвестныхШагов.ОригиналРусскийОписаниеШага = СтрокаДерева.ОписаниеШага;
				КонецЕсли;	 
			КонецЕсли;	
		КонецЕсли;	 
		
		ДобавитьЗначенияВТаблицуДляПереодаРекурсивно(ТаблицаДляПереводаИзвестныхШагов,СтрокаДерева);
	КонецЦикла;	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуДляПеревода(ТаблицаДляПереводаИзвестныхШагов,Дерево)
	ДобавитьЗначенияВТаблицуДляПереодаРекурсивно(ТаблицаДляПереводаИзвестныхШагов,Дерево);
КонецПроцедуры

&НаСервере
Функция ПоказатьПереводТекстаGherkin(ДанныеПеревода)
	ДеревоСервер = РеквизитФормыВЗначение("ДеревоШагов");
	
	ТаблицаДляПереводаИзвестныхШагов = Новый ТаблицаЗначений;
	ТаблицаДляПереводаИзвестныхШагов.Колонки.Добавить("ОригиналРусскийШаг");
	ТаблицаДляПереводаИзвестныхШагов.Колонки.Добавить("ОригиналРусскийОписаниеШага");
	ТаблицаДляПереводаИзвестныхШагов.Колонки.Добавить("Перевод");
	
	ЗаполнитьТаблицуДляПеревода(ТаблицаДляПереводаИзвестныхШагов,ДеревоСервер);
	
	ДанныеПеревода.Вставить("ТаблицаДляПереводаИзвестныхШагов",ТаблицаДляПереводаИзвестныхШагов);
	ДанныеПеревода.Вставить("МакетШаблонПеревода",МакетШаблонПеревода);
	
	ТаблицаИзвестныхStepDefinitionСервер = РеквизитФормыВЗначение("ТаблицаИзвестныхStepDefinition");
	ДанныеПеревода.Вставить("ТаблицаИзвестныхStepDefinition",ТаблицаИзвестныхStepDefinitionСервер);
	
	ДвДанныеvbFeatureReader = ДанныеПеревода.ДвДанныеvbFeatureReader;
	ВременноеИмяФайла = Неопределено;
	Если ДанныеПеревода.ВерсияПоставки = "single" Тогда
		ОбъектСервер  = РеквизитФормыВЗначение("Объект");
		FeatureReader = ОбъектСервер;
	Иначе	
		FeatureReader = СоздатьFeatureReader(КаталогИнструментов, ДвДанныеvbFeatureReader, ВременноеИмяФайла);
	КонецЕсли;	 
	
	КешСнипетовИзХранилищаЗначений(ДанныеПеревода.СтруктураПараметров);
	
	FeatureReader.ПолучитьПереводТекстаGherkin(ДанныеПеревода);
	ДанныеПеревода.Вставить("ТаблицаПеревода",Неопределено);
	
	ДанныеПеревода.Вставить("ТаблицаДляПереводаИзвестныхШагов",Неопределено);
	
	ТабДок         = ДанныеПеревода.ТабДок;
	ДанныеПеревода = Неопределено;
	
	Возврат ТабДок;
КонецФункции	

&НаСервере
Функция ПолучитьДвоичныеДанныеФайлПереводаСервер()
	Возврат ЗначениеИзСтрокиВнутр(ДвоичныеДанныеФайлПеревода);
КонецФункции	

#КонецОбласти 

#Область Поиск

&НаКлиенте
Процедура НайтиСтрокуПоСнипетуРекурсивно(Снипет,СтрокиДерева,Результат)
	Для каждого СтрокаДерева Из СтрокиДерева Цикл
		Если Результат <> Неопределено Тогда
			Возврат;
		КонецЕсли;	 
		
		СтрИзДерева = НРег(СтрокаДерева.Снипет);
		Поз = Найти(СтрИзДерева,"(");
		Если Поз > 0 Тогда
			СтрИзДерева = Лев(СтрИзДерева,Поз-1);
		КонецЕсли;
		
		Если Снипет = СтрИзДерева Тогда
			Результат = СтрокаДерева;
			Возврат;
		КонецЕсли;	 
		
		ПодчиненныеЭлементыСтроки = СтрокаДерева.ПолучитьЭлементы();
		НайтиСтрокуПоСнипетуРекурсивно(Снипет, ПодчиненныеЭлементыСтроки, Результат);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПоиск()

	ТекстШага = ПолучитьТекстШагаТекущейСтроки();

	ДвДанныеvbFeatureReader = ПолучитьДДFeatureReader();

	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("ТекстСообщенийПользователю", Ванесса.ДанныеПереводаСообщенийПользователю());
	ЗаполнитьДеревоИзвестныхШаговНаСервере(ДвДанныеvbFeatureReader, ДопПараметры);
	Если Не ЗначениеЗаполнено(ФильтрДереваШагов) Тогда
		Если ЗначениеЗаполнено(ТекстШага) Тогда
			АктивизироватьСтрокуДереваСНужнымШагом(ТекстШага);
		КонецЕсли;

		Возврат;
	КонецЕсли;

	РазвернутьСтрокиДерева(ДеревоШагов);

КонецПроцедуры

&НаСервере
Процедура ДополнитьТаблицуРезультатаПоиска(ТабРезультат,ТабРезультат2)
	Для Каждого СтрокаТабРезультат2 Из ТабРезультат2 Цикл
		СтрокаТабРезультат = ТабРезультат.Найти(СтрокаТабРезультат2.СтрокаДляПоиска,"СтрокаДляПоиска");
		Если СтрокаТабРезультат = Неопределено Тогда
			СтрокаТабРезультат = ТабРезультат.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТабРезультат,СтрокаТабРезультат2);
		КонецЕсли;	 
	КонецЦикла;	
КонецПроцедуры 

&НаСервере
Функция ПолучитьРезультатПоиска(ТаблицаДанных,ИмяКолонки)
	Построитель = Новый ПостроительЗапроса;
	Построитель.ИсточникДанных = Новый ОписаниеИсточникаДанных(ТаблицаДанных);
	
	тОтбор = Построитель.Отбор.Добавить(ИмяКолонки);
	тОтбор.ВидСравнения = ВидСравнения.Содержит;
	тОтбор.Значение = ФильтрДереваШагов;
	тОтбор.Использование = Истина;
	
	Построитель.Выполнить();
	Возврат Построитель.Результат.Выгрузить();
КонецФункции	 

#КонецОбласти 

#Область ВыгрузкаВJSON

&НаСервере
Функция ПодготовитьТаблицуДляВыгрузкиШагов()
	ДеревоШаговСервер                    = РеквизитФормыВЗначение("ДеревоШагов");
	ТаблицаИзвестныхStepDefinitionСервер = РеквизитФормыВЗначение("ТаблицаИзвестныхStepDefinition");
	
	Массив = Новый Массив;
	
	Для Каждого СтрокаТаблицаИзвестныхStepDefinitionСервер Из ТаблицаИзвестныхStepDefinitionСервер Цикл
		Если НЕ ЗначениеЗаполнено(СтрокаТаблицаИзвестныхStepDefinitionСервер.ПредставлениеТеста) Тогда
			Продолжить;
		КонецЕсли;	 
		
		СтрокаДерева = ДеревоШаговСервер.Строки.Найти(СтрокаТаблицаИзвестныхStepDefinitionСервер.ПредставлениеТеста,"ПредставлениеТеста",Истина);
		Если СтрокаДерева = Неопределено Тогда
			Продолжить;
		КонецЕсли;	 
		
		Структура = Новый Структура;
		Структура.Вставить("ИмяШага",СтрокаТаблицаИзвестныхStepDefinitionСервер.ПредставлениеТеста);
		Структура.Вставить("ОписаниеШага",СтрокаТаблицаИзвестныхStepDefinitionСервер.ОписаниеШага);
		Структура.Вставить("ПолныйТипШага",СтрокаДерева.Родитель.ПолныйТипШага);
		
		Массив.Добавить(Структура);
	КонецЦикла;	
	
	Возврат Массив;
КонецФункции	

#КонецОбласти 

#Область ИнтерактивнаяСправка

&НаСервере
Функция ДанныеКомандыVanessaAutomationСервер(ИмяКоманды)
	
	Данные = Новый Структура;
	Данные.Вставить("Заголовок", Команды[ИмяКоманды].Заголовок);
	Данные.Вставить("Действие", Команды[ИмяКоманды].Действие);
	Данные.Вставить("Подсказка", Команды[ИмяКоманды].Подсказка);
	
	Возврат Данные; 
	
КонецФункции	 

#КонецОбласти

#КонецОбласти

