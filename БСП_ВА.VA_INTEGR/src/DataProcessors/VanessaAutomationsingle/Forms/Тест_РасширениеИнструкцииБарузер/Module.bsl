
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Automation
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Automation.
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

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВключаяюПодсветкуАктивногоЭлементаВБраузере()","ЯВключаяюПодсветкуАктивногоЭлементаВБраузере","И я включаяю подсветку активного элемента в браузере","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВыключаяюПодсветкуАктивногоЭлементаВБраузере()","ЯВыключаяюПодсветкуАктивногоЭлементаВБраузере","И я выключаяю подсветку активного элемента в браузере","","");

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
// Функция выполняется перед началом каждого сценария
Функция ПередНачаломСценария() Экспорт
	
КонецФункции

&НаКлиенте
// Функция выполняется перед окончанием каждого сценария
Функция ПередОкончаниемСценария() Экспорт
	
КонецФункции


&НаСервереБезКонтекста
Процедура УстановитьЗначениеКонстантыДелатьПодсветку(Значение)
	Константы.ДелатьПодсветку.Установить(Значение);
КонецПроцедуры 


///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И я включаяю подсветку активного элемента в браузере
//@ЯВключаяюПодсветкуАктивногоЭлементаВБраузере()
Функция ЯВключаяюПодсветкуАктивногоЭлементаВБраузере() Экспорт
	УстановитьЗначениеКонстантыДелатьПодсветку(Истина);
КонецФункции

&НаКлиенте
//И я выключаяю подсветку активного элемента в браузере
//@ЯВыключаяюПодсветкуАктивногоЭлементаВБраузере()
Функция ЯВыключаяюПодсветкуАктивногоЭлементаВБраузере() Экспорт
	УстановитьЗначениеКонстантыДелатьПодсветку(Ложь);
КонецФункции
