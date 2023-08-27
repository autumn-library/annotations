#Область ОписаниеПеременных

// Имя аннотации
Перем Имя;

// Имя типа, к которому применяется аннотация
Перем ИмяТипаАннотации;

// Параметры аннотации
Перем Параметры;

// Подчиненные аннотации
Перем Аннотации;

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Имя аннотации.
//
//  Возвращаемое значение:
//   Строка
//
Функция Имя() Экспорт
	Возврат Имя;
КонецФункции

// Имя типа, к которому применяется аннотация.
//
//  Возвращаемое значение:
//   Строка
//
Функция ИмяТипаАннотации() Экспорт
	Возврат ИмяТипаАннотации;
КонецФункции

// Параметры аннотации - разобранные параметры конструктора класса аннотации.
// Метод возвращает копию таблицы.
//
//  Возвращаемое значение:
//   ТаблицаЗначений - таблица параметров аннотации:
//     * Имя                     - Строка          - Имя параметра.
//     * ПоЗначению              - Булево          - Признак получения пораметра по значению.
//     * ЕстьЗначениеПоУмолчанию - Булево          - Признак наличия значения по умолчанию.
//     * ЗначениеПоУмолчанию     - Произвольный    - Значение по умолчанию.
//     * Аннотации               - ТаблицаЗначений - Таблица аннотаций со следующими колонками:
//        ** Имя       - Строка          - Имя аннотации.
//        ** Параметры - ТаблицаЗначений - Таблица параметров аннотации:
//           *** Имя      - Строка - Имя параметра аннотации.
//           *** Значение - Строка - Значение параметра аннотации.
//     * Экспорт                 - Булево          - Признак экспорта параметра.
//
Функция Параметры() Экспорт
	Возврат Параметры.Скопировать();
КонецФункции

// Подчиненные аннотации - список аннотаций над конструктором класса-аннотации.
// Метот возвращает глубокую копию таблицы.
//
//  Возвращаемое значение:
//   ТаблицаЗначений - Таблица аннотаций:
//     * Имя       - Строка          - Имя аннотации.
//     * Параметры - ТаблицаЗначений - Таблица параметров аннотации:
//       ** Имя      - Строка - Имя параметра аннотации.
//       ** Значение - Строка - Значение параметра аннотации.
//
Функция Аннотации() Экспорт
	КопияАннотации = Аннотации.Скопировать();
	Для Каждого Аннотация Из КопияАннотации Цикл
		Аннотация.Параметры = Аннотация.Параметры.Скопировать();
	КонецЦикла;
	Возврат КопияАннотации;
КонецФункции

// Выполнить проверку корректности аннотации.
//
// Выбрасывает исключение:
//  * Когда аннотация не содержит параметр, у которого нет значения по умолчанию.
//  * Когда аннотация содержит параметр, которого нет в списке параметров аннотации.
//  * Когда аннотация содержит несколько параметров без имени или с именем "Значение".
//
// Параметры:
//   Аннотация - СтрокаТаблицыЗначений - Данные аннотации:
//     * Имя       - Строка          - Имя аннотации.
//     * Параметры - ТаблицаЗначений - Таблица параметров аннотации:
//       ** Имя      - Строка - Имя параметра аннотации.
//       ** Значение - Строка - Значение параметра аннотации.
//   ИмяТипаСАннотацией - Строка - Имя типа, к которому применяется аннотация.
//
Процедура Проверить(Аннотация, ИмяТипаСАннотацией) Экспорт

	ПривестиИменаПараметров(Аннотация);
	
	АннотацияСодержитОбязательныеПараметры(Аннотация, ИмяТипаСАннотацией);
	АннотацияСодержитМаксимумОдинПараметрСИменемПоУмолчанию(Аннотация, ИмяТипаСАннотацией);
	АннотацияНеСодержитНеизвестныеПараметры(Аннотация, ИмяТипаСАннотацией);
	ПовторяемыеПараметрыЗаданыКорректно(Аннотация, ИмяТипаСАннотацией);
	
КонецПроцедуры

// Создать объект класса аннотации по параметрам аннотации.
//
// Параметры:
//   Аннотация - СтрокаТаблицыЗначений - Данные аннотации:
//     * Имя       - Строка          - Имя аннотации.
//     * Параметры - ТаблицаЗначений - Таблица параметров аннотации:
//       ** Имя      - Строка - Имя параметра аннотации.
//       ** Значение - Строка - Значение параметра аннотации.
//
// Возвращаемое значение:
//   Произвольный - Объект аннотации с заданными параметрами.
//
Функция СоздатьОбъектАннотации(Аннотация) Экспорт

	ПараметрыКонструктора = Новый Массив;
	Для Каждого Параметр Из Параметры() Цикл

		Если Параметр.Повторяемый Тогда
			ЗначениеПараметра = РаботаСАннотациями.ПолучитьЗначенияПараметраАннотации(Аннотация, Параметр.Имя);
		Иначе
			ЗначениеПараметра = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(
				Аннотация,
				Параметр.Имя,
				Параметр.ЗначениеПоУмолчанию,
				Истина
			);
		КонецЕсли;
		ПараметрыКонструктора.Добавить(ЗначениеПараметра);
	КонецЦикла;
	
	ОбъектАннотации = Новый(ИмяТипаАннотации(), ПараметрыКонструктора);

	Возврат ОбъектАннотации;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПривестиИменаПараметров(Аннотация)

	Для Каждого ПараметрАннотации Из Аннотация.Параметры Цикл
		Если ПараметрАннотации.Имя = Неопределено Тогда
			ПараметрАннотации.Имя = "Значение";
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура АннотацияСодержитОбязательныеПараметры(Аннотация, ИмяТипаСАннотацией)
	
	Для Каждого ОпределениеПараметраАннотации Из Параметры Цикл
		
		ПараметрВложеннойАннотации = Аннотация.Параметры.Найти(ОпределениеПараметраАннотации.Имя, "Имя");
		Если НЕ ОпределениеПараметраАннотации.ЕстьЗначениеПоУмолчанию
			И ПараметрВложеннойАннотации = Неопределено Тогда
			
			ВызватьИсключение СтрШаблон(
				"Аннотация %1 в классе %2 не содержит параметр %3",
				Аннотация.Имя,
				ИмяТипаСАннотацией,
				ОпределениеПараметраАннотации.Имя
			);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура АннотацияСодержитМаксимумОдинПараметрСИменемПоУмолчанию(Аннотация, ИмяТипаСАннотацией)
	
	КоличествоПараметровСИменемПоУмолчанию = 0;
	Для Каждого ПараметрАннотации Из Аннотация.Параметры Цикл
		
		ИмяПараметраВложеннойАннотации = ПараметрАннотации.Имя;
		Если ВРег(ИмяПараметраВложеннойАннотации) = ВРег("Значение") Тогда
			КоличествоПараметровСИменемПоУмолчанию = КоличествоПараметровСИменемПоУмолчанию + 1;
		КонецЕсли;
		
		// Аннотация содержит только один параметр с именем по умолчанию
		Если КоличествоПараметровСИменемПоУмолчанию > 1 Тогда
			ВызватьИсключение СтрШаблон(
				"Аннотация %1 в классе %2 имеет более одного параметра без имени или с именем ""Значение""",
				Аннотация.Имя,
				ИмяТипаСАннотацией
			);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура АннотацияНеСодержитНеизвестныеПараметры(Аннотация, ИмяТипаСАннотацией)
	
	Для Каждого ПараметрАннотации Из Аннотация.Параметры Цикл
		
		ИмяПараметраВложеннойАннотации = ПараметрАннотации.Имя;
		ОпределениеПараметраАннотации = Параметры.Найти(ИмяПараметраВложеннойАннотации, "Имя");
		
		Если ОпределениеПараметраАннотации = Неопределено Тогда
			ВызватьИсключение СтрШаблон(
				"Аннотация %1 в классе %2 содержит неизвестный параметр %3",
				Аннотация.Имя,
				ИмяТипаСАннотацией,
				ИмяПараметраВложеннойАннотации
			);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ПовторяемыеПараметрыЗаданыКорректно(Аннотация, ИмяТипаСАннотацией)

	ИмяАннотацииПовторяемый = "Повторяемый";

	Для Каждого Параметр Из Параметры Цикл
		ЭтоПовторяемыйПараметр = РаботаСАннотациями.ПолучитьАннотацию(Параметр, ИмяАннотацииПовторяемый) <> Неопределено;
		ПараметрыАннотации = РаботаСАннотациями.ПолучитьПараметрыАннотации(Аннотация, Параметр.Имя);

		Если ПараметрыАннотации.Количество() > 1 И НЕ ЭтоПовторяемыйПараметр Тогда
			ВызватьИсключение СтрШаблон(
				"Аннотация %1 в классе %2 содержит несколько значений параметра %3, но параметр не помечен аннотацией ""%4""",
				Аннотация.Имя,
				ИмяТипаСАннотацией,
				Параметр.Имя,
				ИмяАннотацииПовторяемый
			);
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

Процедура ОпределитьПовторяемостьПараметров()

	Параметры.Колонки.Добавить("Повторяемый");

	Для Каждого Параметр Из Параметры Цикл
		Параметр.Повторяемый =  НЕ РаботаСАннотациями.НайтиАннотацию(Параметр.Аннотации, "повторяемый") = Неопределено;
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область Инициализация

Процедура ПриСозданииОбъекта(Знач _Имя, Знач _ИмяТипаАннотации, Знач _Параметры, Знач _Аннотации)
	
	Имя = _Имя;
	ИмяТипаАннотации = _ИмяТипаАннотации;
	Аннотации = _Аннотации;
	Параметры = _Параметры;

	ОпределитьПовторяемостьПараметров();
	
КонецПроцедуры

#КонецОбласти