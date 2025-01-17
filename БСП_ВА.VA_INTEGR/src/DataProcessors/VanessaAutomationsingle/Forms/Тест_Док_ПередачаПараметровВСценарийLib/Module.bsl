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
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПишуЗаголовокВложеннойФичиПоСозданиюЭлементаСправочника2()","ЯПишуЗаголовокВложеннойФичиПоСозданиюЭлементаСправочника2","И я пишу заголовок вложенной фичи по созданию элемента справочника2");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПишуСценарийВложеннойФичиПоСозданиюЭлементаСправочника2()","ЯПишуСценарийВложеннойФичиПоСозданиюЭлементаСправочника2","И я пишу сценарий  вложенной фичи по созданию элемента справочника2");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПишуЗаголовокВнешнейФичиПоСозданиюЭлементовСправочника2()","ЯПишуЗаголовокВнешнейФичиПоСозданиюЭлементовСправочника2","И я пишу заголовок внешней фичи по созданию элементов справочника2");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПишуСценарийВнешнейФичиПоСозданиюЭлементовСправочника2()","ЯПишуСценарийВнешнейФичиПоСозданиюЭлементовСправочника2","И я пишу сценарий  внешней фичи по созданию элементов справочника2");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗакрываюСеансСлужебнойБазы()","ЯЗакрываюСеансСлужебнойБазы","И я закрываю сеанс служебной базы");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯУбедилсяЧтоСлужебныеФайлыПоФичеПередачеПараметровВСценарииУдалены()","ЯУбедилсяЧтоСлужебныеФайлыПоФичеПередачеПараметровВСценарииУдалены","Дано я убедился, что служебные файлы по фиче передаче параметров в сценарии удалены");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВТекстовомРедактореЯВыбираюПодсветкуЯзыкаGherkin()","ВТекстовомРедактореЯВыбираюПодсветкуЯзыкаGherkin","И в текстовом редакторе я выбираю подсветку языка Gherkin");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСохраняюФайлОткрытыйВРедактореКак(Парам01)","ЯСохраняюФайлОткрытыйВРедактореКак","И я сохраняю файл открытый в редакторе как ""Support\Instructions\Temp\СозданиеОдногоЭлементаСправочникаТовары.feature""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСоздаюВТекстовомРедактореНовыйФайл()","ЯСоздаюВТекстовомРедактореНовыйФайл","И я создаю в текстовом редакторе новый файл");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапускаюСеансTestManagerВСлужебнойБазе()","ЯЗапускаюСеансTestManagerВСлужебнойБазе","Когда Я запускаю сеанс TestManager в служебной базе");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯОжидаюОкончанияВыполненияСценариевВСеансеСлужебнойБазы()","ЯОжидаюОкончанияВыполненияСценариевВСеансеСлужебнойБазы","И я ожидаю окончания выполнения сценариев в сеансе служебной базы");

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
	//УдалитьСлужебныеФайлы();
	//Ванесса.Шаг("И я закрываю сеанс служебной базы");
КонецПроцедуры

&НаКлиенте
Процедура УдалитьСлужебныеФайлы()
	Путь = Ванесса.Объект.КаталогИнструментов + "\features\Support\Instructions\Temp";
	Если НЕ Ванесса.ФайлСуществуетКомандаСистемы(Путь) Тогда
		Ванесса.СоздатьКаталогКомандаСистемы(Путь);
	КонецЕсли;	 
	
	Путь = Ванесса.Объект.КаталогИнструментов + "\features\Support\Instructions\Temp\СозданиеОдногоЭлементаСправочникаТовары.feature";
	Если Ванесса.ФайлСуществуетКомандаСистемы(Путь) Тогда
		Ванесса.УдалитьФайлыКомандаСистемы(Путь);
	КонецЕсли;	 
	
	Путь = Ванесса.Объект.КаталогИнструментов + "\features\Support\Instructions\Temp\СозданиеНесколькихЭлементовСправочникаТовары.feature";
	Если Ванесса.ФайлСуществуетКомандаСистемы(Путь) Тогда
		Ванесса.УдалитьФайлыКомандаСистемы(Путь);
	КонецЕсли;	 
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//Дано я убедился, что служебные файлы по фиче передаче параметров в сценарии удалены
//@ЯУбедилсяЧтоСлужебныеФайлыПоФичеПередачеПараметровВСценарииУдалены()
Процедура ЯУбедилсяЧтоСлужебныеФайлыПоФичеПередачеПараметровВСценарииУдалены() Экспорт
	УдалитьСлужебныеФайлы();
КонецПроцедуры

&НаКлиенте
//И я пишу заголовок вложенной фичи по созданию элемента справочника2
//@ЯПишуЗаголовокВложеннойФичиПоСозданиюЭлементаСправочника2()
Процедура ЯПишуЗаголовокВложеннойФичиПоСозданиюЭлементаСправочника2() Экспорт
	
КонецПроцедуры

&НаКлиенте
//И я пишу сценарий  вложенной фичи по созданию элемента справочника2
//@ЯПишуСценарийВложеннойФичиПоСозданиюЭлементаСправочника2()
Процедура ЯПишуСценарийВложеннойФичиПоСозданиюЭлементаСправочника2() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение Ванесса.ПолучитьТекстСообщенияПользователю("Не реализовано.");
КонецПроцедуры

&НаКлиенте
//И я пишу заголовок внешней фичи по созданию элементов справочника2
//@ЯПишуЗаголовокВнешнейФичиПоСозданиюЭлементовСправочника2()
Процедура ЯПишуЗаголовокВнешнейФичиПоСозданиюЭлементовСправочника2() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение Ванесса.ПолучитьТекстСообщенияПользователю("Не реализовано.");
КонецПроцедуры

&НаКлиенте
//И я пишу сценарий  внешней фичи по созданию элементов справочника2
//@ЯПишуСценарийВнешнейФичиПоСозданиюЭлементовСправочника2()
Процедура ЯПишуСценарийВнешнейФичиПоСозданиюЭлементовСправочника2() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение Ванесса.ПолучитьТекстСообщенияПользователю("Не реализовано.");
КонецПроцедуры

//окончание текста модуля

&НаКлиенте
//И я сохраняю файл открытый в редакторе как "Support\Instructions\Temp\СозданиеОдногоЭлементаСправочника2.feature"
//@ЯСохраняюФайлОткрытыйВРедактореКак(Парам01)
Процедура ЯСохраняюФайлОткрытыйВРедактореКак(ЧастьПути) Экспорт
	Результат = Ванесса.ВыполнитьSikuliСкрипт(Ванесса.Объект.КаталогИнструментов + "\tools\Sikuli\CtrlS.sikuli");
	Ванесса.ПроверитьРавенство(Результат, 0 , "Произошло выполнение скрипта <CtrlS>");
	
	
	Путь = Ванесса.Объект.КаталогИнструментов + "\features\" + ЧастьПути;
	Ванесса.Шаг("И я добавляю строку текста """ + Путь + """");
КонецПроцедуры

&НаКлиенте
//И в текстовом редакторе я выбираю подсветку языка Gherkin
//@ВТекстовомРедактореЯВыбираюПодсветкуЯзыкаGherkin()
Процедура ВТекстовомРедактореЯВыбираюПодсветкуЯзыкаGherkin() Экспорт
	Результат = Ванесса.ВыполнитьSikuliСкрипт(Ванесса.Объект.КаталогИнструментов + "\tools\Sikuli\ChooseGherkin.sikuli");
	Ванесса.ПроверитьРавенство(Результат, 0 , "Произошло выполнение скрипта <ChooseGherkin>");
	
	Ванесса.Шаг("И я добавляю строку текста ""Gherkin""");
КонецПроцедуры


&НаКлиенте
//И я создаю в текстовом редакторе новый файл
//@ЯСоздаюВТекстовомРедактореНовыйФайл()
Процедура ЯСоздаюВТекстовомРедактореНовыйФайл() Экспорт
	Результат = Ванесса.ВыполнитьSikuliСкрипт(Ванесса.Объект.КаталогИнструментов + "\tools\Sikuli\CtrlN.sikuli");
	Ванесса.ПроверитьРавенство(Результат, 0 , "Произошло выполнение скрипта <CtrlN>");
КонецПроцедуры

&НаКлиенте
//Когда Я запускаю сеанс TestManager в служебной базе
//@ЯЗапускаюСеансTestManagerВСлужебнойБазе()
Процедура ЯЗапускаюСеансTestManagerВСлужебнойБазе() Экспорт
	Ванесса.СоздатьСлужебныеБазыЕслиИхНет();
	
	Ванесса.ЗапуститьСеансСлужебнойБазы("v83ServiceBase836","ENTERPRISE","/TESTMANAGER /CLibsOnly");
	
	Ванесса.sleep(5);
	
КонецПроцедуры

&НаКлиенте
//И я ожидаю окончания выполнения сценариев в сеансе служебной базы
//@ЯОжидаюОкончанияВыполненияСценариевВСеансеСлужебнойБазы()
Процедура ЯОжидаюОкончанияВыполненияСценариевВСеансеСлужебнойБазы() Экспорт
	Ванесса.ЭтотШагНеНадоМасштабироватьВВидео();
	Результат = Ванесса.ВыполнитьSikuliСкрипт(Ванесса.Объект.КаталогИнструментов + "\tools\Sikuli\WaitForStringAllScenariosOK.sikuli");
	Ванесса.ПроверитьРавенство(Результат, 0 , "Произошло выполнение скрипта <WaitForStringAllScenariosOK>");
КонецПроцедуры

&НаКлиенте
//И я закрываю сеанс служебной базы
//@ЯЗакрываюСеансСлужебнойБазы()
Процедура ЯЗакрываюСеансСлужебнойБазы() Экспорт
	Результат = Ванесса.ВыполнитьSikuliСкрипт(Ванесса.Объект.КаталогИнструментов + "\tools\Sikuli\Exit1C.sikuli");
	Ванесса.ПроверитьРавенство(Результат, 0 , "Произошло выполнение скрипта <Exit1C>");
КонецПроцедуры
