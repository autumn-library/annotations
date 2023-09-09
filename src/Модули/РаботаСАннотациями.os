#Область ПрограммныйИнтерфейс

// Получить все аннотации свойства с указанным именем аннотации.
//
// Параметры:
//   Свойство - СтрокаТабличнойЧасти, Структура - Описание свойства/метода:
//	   * Аннотации - ТаблицаЗначений - Таблица аннотаций свойства/метода:
//		   * Имя - Строка - Имя аннотации.
//   ИмяАннотации - Строка - Имя аннотации.
//
//  Возвращаемое значение:
//   Массив из СтрокаТабличнойЧасти - Массив найденных аннотаций.
//
Функция ПолучитьАннотации(Свойство, ИмяАннотации) Экспорт
	Возврат ОтфильтроватьАннотацииПоИмени(Свойство.Аннотации, ИмяАннотации);
КонецФункции

// Получить первую аннотацию свойства с указанным именем аннотации.
//
// Параметры:
//   Свойство - СтрокаТабличнойЧасти, Структура - Описание свойства/метода:
//	   * Аннотации - ТаблицаЗначений - Таблица аннотаций свойства/метода:
//		   * Имя - Строка - Имя аннотации.
//   ИмяАннотации - Строка - Имя аннотации.
//
//  Возвращаемое значение:
//   СтрокаТабличнойЧасти - Найденная аннотация.
//
Функция ПолучитьАннотацию(Свойство, ИмяАннотации) Экспорт
	Возврат ОтфильтроватьПервуюАннотациюПоИмени(Свойство.Аннотации, ИмяАннотации);
КонецФункции

// Получить все аннотации с указанным именем аннотации.
//
// Параметры:
//   Аннотации - ТаблицаЗначений - Таблица аннотаций:
//	   * Имя - Строка - Имя аннотации.
//   ИмяАннотации - Строка - Имя аннотации.
//
//  Возвращаемое значение:
//   Массив из СтрокаТабличнойЧасти - Массив найденных аннотаций.
//
Функция НайтиАннотации(Аннотации, ИмяАннотации) Экспорт
	Возврат ОтфильтроватьАннотацииПоИмени(Аннотации, ИмяАннотации);
КонецФункции

// Получить первую аннотацию с указанным именем аннотации.
//
// Параметры:
//   Аннотации - ТаблицаЗначений - Таблица аннотаций:
//	   * Имя - Строка - Имя аннотации.
//   ИмяАннотации - Строка - Имя аннотации.
//
//  Возвращаемое значение:
//   СтрокаТабличнойЧасти - Найденная аннотация.
//
Функция НайтиАннотацию(Аннотации, ИмяАннотации) Экспорт
	Возврат ОтфильтроватьПервуюАннотациюПоИмени(Аннотации, ИмяАннотации);
КонецФункции

// Получить все методы с указанной аннотацией.
//
// Параметры:
//   Методы - ТаблицаЗначений, Массив - Список методов:
//	   * Аннотации - ТаблицаЗначений - Таблица аннотаций метода:
//		   * Имя - Строка - Имя аннотации.
//   ИмяАннотации - Строка - Имя аннотации.
//
//  Возвращаемое значение:
//   Массив из СтрокаТабличнойЧасти - Массив найденных методов.
//
Функция НайтиМетодыСАннотацией(Методы, ИмяАннотации) Экспорт
	
	Результат = Новый Массив();
	
	Для Каждого Метод Из Методы Цикл
		
		Если Метод.Аннотации = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		Для Каждого Аннотация Из Метод.Аннотации Цикл
			
			Если НРег(Аннотация.Имя) = Нрег(ИмяАннотации) Тогда
				Результат.Добавить(Метод);
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Получить параметры аннотации с указанным именем параметра.
//
// Параметры:
//   Аннотация - СтрокаТабличнойЧасти,Структура - Аннотация:
//	   * Параметры - ТаблицаЗначений - Таблица параметров аннотации:
//		   * Имя - Строка - Имя параметра.
//   ИмяПараметра - Строка - Имя параметра.
//
//  Возвращаемое значение:
//   Массив из СтрокаТабличнойЧасти - Массив найденных параметров.
//
Функция ПолучитьПараметрыАннотации(Аннотация, ИмяПараметра) Экспорт
	
	Результат = Новый Массив;
	
	Для Каждого Элемент Из Аннотация.Параметры Цикл
		ИмяЭлемента = Элемент.Имя;
		Если ИмяЭлемента = Неопределено Тогда
			ИмяЭлемента = "Значение";
		КонецЕсли;
		Если ВРег(ИмяЭлемента) = ВРег(ИмяПараметра) Тогда
			Результат.Добавить(Элемент);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Получить параметр аннотации с указанным именем параметра.
//
// Параметры:
//   Аннотация - СтрокаТабличнойЧасти,Структура - Аннотация:
//	   * Параметры - ТаблицаЗначений - Таблица параметров аннотации:
//		   * Имя - Строка - Имя параметра.
//   ИмяПараметра - Строка - Имя параметра.
//
//  Возвращаемое значение:
//   СтрокаТабличнойЧасти - Найденный параметр.
//
Функция ПолучитьПараметрАннотации(Аннотация, ИмяПараметра) Экспорт
	Для Каждого Элемент Из Аннотация.Параметры Цикл
		ИмяЭлемента = Элемент.Имя;
		Если ИмяЭлемента = Неопределено Тогда
			ИмяЭлемента = "Значение";
		КонецЕсли;
		Если ВРег(ИмяЭлемента) = ВРег(ИмяПараметра) Тогда
			Возврат Элемент;
		КонецЕсли;
	КонецЦикла;
	Возврат Неопределено;
КонецФункции

// Получить значения параметров аннотации с указанным именем параметра.
//
// Параметры:
//   Аннотация - СтрокаТабличнойЧасти,Структура - Аннотация:
//	   * Параметры - ТаблицаЗначений - Таблица параметров аннотации:
//		   * Имя - Строка - Имя параметра.
//         * Значение - Произвольный - Значение параметра.
//   ИмяПараметра - Строка - Имя параметра.
//
//  Возвращаемое значение:
//   Массив из Произвольный - Массив найденных значений параметров.
//
Функция ПолучитьЗначенияПараметровАннотации(Аннотация, ИмяПараметра) Экспорт
	
	ПараметрыАннотации = ПолучитьПараметрыАннотации(Аннотация, ИмяПараметра);
	МассивПараметров = Новый Массив();
	
	Если ПараметрыАннотации.Количество() > 0 Тогда
		Для Каждого ТекПараметр Из ПараметрыАннотации Цикл
			МассивПараметров.Добавить(ТекПараметр.Значение);
		КонецЦикла;
	КонецЕсли;
	
	Возврат МассивПараметров;

КонецФункции

// Получить значение параметра аннотации с указанным именем параметра.
//
// Параметры:
//   Аннотация - СтрокаТабличнойЧасти,Структура - Аннотация:
//	   * Параметры - ТаблицаЗначений - Таблица параметров аннотации:
//		   * Имя - Строка - Имя параметра.
//         * Значение - Произвольный - Значение параметра.
//   ИмяПараметра - Строка - Имя параметра.
//   ЗначениеПоУмолчанию - Произвольный - Значение параметра по умолчанию.
//   НеопределеноЭтоКорректноеЗначениеПараметра - Булево - Признак того,
//                                                         что Неопределено является корректным значением параметра.
//
//  Возвращаемое значение:
//   Произвольный - Значение параметра.
//
Функция ПолучитьЗначениеПараметраАннотации(
	Аннотация,
	ИмяПараметра = "Значение",
	ЗначениеПоУмолчанию = Неопределено,
	НеопределеноЭтоКорректноеЗначениеПараметра = Ложь
) Экспорт
	
	ИмяПараметраПоУмолчанию = "Значение";
	
	Если Аннотация = Неопределено ИЛИ Аннотация.Параметры = Неопределено ИЛИ Аннотация.Параметры.Количество() = 0 Тогда
		Возврат ЗначениеПоУмолчанию;
	КонецЕсли;
	
	ПараметрАннотации = ПолучитьПараметрАннотации(Аннотация, ИмяПараметра);
	
	Если ПараметрАннотации <> Неопределено Тогда
		Возврат ПараметрАннотации.Значение;
	КонецЕсли;
	
	ЭтоПараметрПоУмолчанию = ИмяПараметра = ИмяПараметраПоУмолчанию;
	АннотацияСодержитБольшеОдногоПараметра = Аннотация.Параметры.Количество() > 1;
	ЗначениеПараметраПередано = ЗначениеПоУмолчанию <> Неопределено ИЛИ НеопределеноЭтоКорректноеЗначениеПараметра;
	Если ЭтоПараметрПоУмолчанию И АннотацияСодержитБольшеОдногоПараметра И НЕ ЗначениеПараметраПередано Тогда
		Сообщение = СтрШаблон(
			"Аннотация %1 содержит несколько параметров, среди которых нет явного указания имени параметра ""%2""",
			Аннотация.Имя,
			ИмяПараметраПоУмолчанию
		);
		ВызватьИсключение Сообщение;
	ИначеЕсли ЭтоПараметрПоУмолчанию И Аннотация.Параметры[0].Имя = Неопределено Тогда
		Возврат Аннотация.Параметры[0].Значение;
	ИначеЕсли ЗначениеПоУмолчанию <> Неопределено ИЛИ НеопределеноЭтоКорректноеЗначениеПараметра Тогда
		Возврат ЗначениеПоУмолчанию;
	Иначе
		Сообщение = СтрШаблон("Не найден параметр аннотации %1", ИмяПараметра);
		ВызватьИсключение Сообщение;
	КонецЕсли;
	
КонецФункции

// Установить значение параметра аннотации с указанным именем параметра.
//
// Параметры:
//   Аннотация - СтрокаТабличнойЧасти,Структура - Аннотация:
//	   * Параметры - ТаблицаЗначений - Таблица параметров аннотации:
//		   * Имя - Строка - Имя параметра.
//         * Значение - Произвольный - Значение параметра.
//   ИмяПараметра - Строка - Имя параметра.
//   ЗначениеПараметра - Произвольный - Значение параметра.
//
Процедура УстановитьЗначениеПараметраАннотации(Аннотация, ИмяПараметра, ЗначениеПараметра) Экспорт
	Параметр = Аннотация.Параметры.Найти(ИмяПараметра, "Имя");
	Если Параметр = Неопределено Тогда
		Параметр = Аннотация.Параметры.Добавить();
		Параметр.Имя = ИмяПараметра;
	КонецЕсли;
	Параметр.Значение = ЗначениеПараметра;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОтфильтроватьАннотацииПоИмени(Аннотации, ИмяАннотации)
	
	Массив = Новый Массив();
	
	Для Каждого Элемент Из Аннотации Цикл
		Если ВРег(Элемент.Имя) = ВРег(ИмяАннотации) Тогда
			Массив.Добавить(Элемент);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Массив;
	
КонецФункции

Функция ОтфильтроватьПервуюАннотациюПоИмени(Аннотации, ИмяАннотации)
	
	Для Каждого Элемент Из Аннотации Цикл
		Если ВРег(Элемент.Имя) = ВРег(ИмяАннотации) Тогда
			Возврат Элемент;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;

КонецФункции

#КонецОбласти
