#Область ПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс
Процедура РегрессионныйТест(МассивОбъектов,
		ДополнительныеПараметры) Экспорт

	ИмяФормы = ДополнительныеПараметры.Форма.ИмяФормы;
	РезультатОбновления = ОбновитьСтруктуруКаталоговТестов(ИмяФормы, Истина);
	Если НЕ РезультатОбновления Тогда
		Возврат;
	КонецЕсли;
	
	ЭлементТестирования = ВАИНТ_ТестированиеВызовСервера.ОписаниеЭлементаТестирования(ИмяФормы);
	ИмяОбъекта = ЭлементТестирования.ИмяВладельца;
	ТипОбъекта = ЭлементТестирования.ТипВладельца;

	ФайлТестов = ВАИНТ_ТестированиеКлиентСервер.ФайлРегрессионногоТеста(ТипОбъекта, ИмяОбъекта);
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("КаталогПроекта", ВАИНТ_ТестированиеКлиентСервер.БазовыйКаталогТестирования());
	
	ФормаОбработкиТестирования = ОткрытьФорму("Обработка.VanessaAutomationsingle.Форма.УправляемаяФорма", ПараметрыФормы);
	ФормаОбработкиТестирования.Объект.КаталогФич = ФайлТестов;
	ФормаОбработкиТестирования.ЗагрузитьФичи();
КонецПроцедуры

Функция ОбновитьСтруктуруКаталоговТестов(ИмяФормы,
		ПодтверждениеПриСоздании = Ложь) Экспорт
	ЭлементТестирования = ВАИНТ_ТестированиеВызовСервера.ОписаниеЭлементаТестирования(ИмяФормы);
	ИмяЭлемента = ЭлементТестирования.ИмяВладельца;
	ТипОбъекта = ЭлементТестирования.ТипВладельца;
	БазовыйКаталогЭлемента = ВАИНТ_ТестированиеКлиентСервер.КаталогТестовПоТипуОбъекта(ТипОбъекта);
	
	ИмяКаталогаТестовЭлемента = БазовыйКаталогЭлемента + ИмяЭлемента;
	КаталогТестов = Новый Файл(ИмяКаталогаТестовЭлемента);
	Если НЕ КаталогТестов.Существует() Тогда

		Если ПодтверждениеПриСоздании Тогда
			ТекстВопроса = "Создать файлы теста для " + ИмяЭлемента + "?";

			ПоказатьВопрос(Новый ОписаниеОповещения("ПодтверждениеСозданияФайловТестовЗавершение", ЭтотОбъект, ИмяФормы), ТекстВопроса, РежимДиалогаВопрос.ДаНет);
			Возврат Ложь;
		КонецЕсли;

		СоздатьКаталог(ИмяКаталогаТестовЭлемента);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Обновление каталогов завершено. Повторите запуск тестов.");
	КонецЕсли;

	ПутьКФайлуШаблона = ВАИНТ_ТестированиеКлиентСервер.ПутьКФайлуШаблонаФичи();

	ФайлСозданияТД = Новый Файл(ВАИНТ_ТестированиеКлиентСервер.ФайлРегрессионногоТеста(ТипОбъекта, ИмяЭлемента));

	Если Не ФайлСозданияТД.Существует() Тогда
		КопироватьФайл(ПутьКФайлуШаблона, ФайлСозданияТД.ПолноеИмя);
	КонецЕсли;
	Возврат Истина;
КонецФункции

Процедура ПодтверждениеСозданияФайловТестовЗавершение(Результат, ИмяФормы) Экспорт
	Если Результат = КодВозвратаДиалога.Да Тогда
		ОбновитьСтруктуруКаталоговТестов(ИмяФормы);
	КонецЕсли;
КонецПроцедуры

Процедура ОткрытьДиалогВыбораКаталогаТестирования(ОписаниеОповещенияОЗакрытии = Неопределено) Экспорт
	ПараметрыОткрытия = Новый Структура;
	НастройкаКаталогТестирования = ПредопределенноеЗначение("Перечисление.ВАИНТ_НастройкиТестирования.ПутьККаталогуТестов"); 
	ПараметрыОткрытия.Вставить("НастройкаТестирования", НастройкаКаталогТестирования);
								
	ОткрытьФорму("РегистрСведений.ВАИНТ_НастройкиТестирования.ФормаЗаписи", ПараметрыОткрытия, , , , , ОписаниеОповещенияОЗакрытии);
КонецПроцедуры

Процедура СоздатьКаталогПриОтсутствии(Путь) Экспорт
	Каталог = Новый Файл(Путь);
	Если Не Каталог.Существует() Тогда
		СоздатьКаталог(Каталог);
	КонецЕсли;
КонецПроцедуры
#КонецОбласти
