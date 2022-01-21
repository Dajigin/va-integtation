
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

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСоздаюПустуюБазу(Парам01)","ЯСоздаюПустуюБазу","Затем я создаю пустую базу ""ПараметрыСозданияБазы""","Создаёт пустую базу по указанным параметрам.","Прочее.Пакетный режим");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагружаюБазуИзDT(Парам01,Парам02)","ЯЗагружаюБазуИзDT","Затем я загружаю базу ""СтрокаСоединенияСБазой"" из DT ""ПутьКDT""","Загружает базу из DT файла.","Прочее.Пакетный режим");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВыгружаюБазуВDT(Парам01,Парам02)","ЯВыгружаюБазуВDT","Затем я выгружаю базу ""СтрокаСоединенияСБазой"" в DT ""ПутьКDT""","Выгружает базу в DT файл.","Прочее.Пакетный режим");

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
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
Функция ПутьКФайлу1cv8()
	
	КаталогПрограммы = КаталогПрограммы();
	Если Ванесса.ЭтоLinux Тогда
		ИмяФайла = Ванесса.ДополнитьСлешВПуть(КаталогПрограммы) + "1cv8";
	Иначе	
		ИмяФайла = Ванесса.ДополнитьСлешВПуть(КаталогПрограммы) + "1cv8.exe";
	КонецЕсли;	 
	
	Возврат ИмяФайла; 
	
КонецФункции	 

&НаКлиенте
//Затем я создаю пустую базу 'File=ПутьККаталогу'
//@ЯСоздаюПустуюБазу(Парам01)
Процедура ЯСоздаюПустуюБазу(ПараметрыСозданияБазы) Экспорт
	ПутьКФайлу1cv8 = ПутьКФайлу1cv8();
	
	Команда = """" + ПутьКФайлу1cv8 + """ CreateInfoBase " + ПараметрыСозданияБазы;
	Статус = Ванесса.ВыполнитьКомандуОСБезПоказаЧерногоОкна(Команда);
	Если Статус <> 0 Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Не смог создать базу по строке: %1. Статус возврата: %2");
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",ПараметрыСозданияБазы); 
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",Статус); 
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
	
КонецПроцедуры

&НаКлиенте
//Затем я загружаю базу 'СтрокаСоединения' из DT "ПутьКDT"
//@ЯЗагружаюБазуИзDT(Парам01,Парам02)
Процедура ЯЗагружаюБазуИзDT(СтрокаСоединения,ПутьКDT) Экспорт
	ПутьКФайлу1cv8 = ПутьКФайлу1cv8();
	
	Команда = """" + ПутьКФайлу1cv8 + """ DESIGNER " + СтрокаСоединения + " /RestoreIB """ + ПутьКDT + """";
	Ванесса.Отладка(Команда);
	Статус = Ванесса.ВыполнитьКомандуОСБезПоказаЧерногоОкна(Команда);
	Если Статус <> 0 Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Не смог загрузить базу из dt: %1. ПутьКDT: %2. Статус возврата: %3");
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",СтрокаСоединения); 
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",ПутьКDT); 
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%3",Статус); 
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
//Затем я выгружаю базу 'СтрокаСоединения' в DT "ПутьКDT"
//@ЯВыгружаюБазуВDT(Парам01,Парам02)
Процедура ЯВыгружаюБазуВDT(СтрокаСоединения,ПутьКDT) Экспорт
	ПутьКФайлу1cv8 = ПутьКФайлу1cv8();
	
	Команда = """" + ПутьКФайлу1cv8 + """ DESIGNER " + СтрокаСоединения + " /DumpIB """ + ПутьКDT + """";
	Статус = Ванесса.ВыполнитьКомандуОСБезПоказаЧерногоОкна(Команда);
	Если Статус <> 0 Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Не получилось выгрузить базу в dt: <%1>. Путь к DT: <%2>. Статус возврата: <%3>.");
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",СтрокаСоединения); 
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",ПутьКDT); 
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%3",Статус); 
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
КонецПроцедуры
