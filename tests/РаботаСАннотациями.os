#Использовать ".."
#Использовать "."
#Использовать asserts

&Тест
Процедура ПолучитьАннотации() Экспорт
	
	// Дано
	Рефлектор = Новый Рефлектор();
	ТаблицаПолей = Рефлектор.ПолучитьТаблицуСвойств(Тип("ВладелецАннотаций"), Истина);

	// Когда
	Результат = РаботаСАннотациями.ПолучитьАннотации(ТаблицаПолей[0], "Поле");

	// Тогда
	Ожидаем.Что(Результат.Количество()).Равно(2);
	Ожидаем.Что(Результат).ИмеетТип("Массив");
	Ожидаем.Что(Результат[0]).ИмеетТип("СтрокаТаблицыЗначений");
	Ожидаем.Что(Результат[0].Имя).Равно("Поле");
	Ожидаем.Что(Результат[1].Имя).Равно("Поле");

КонецПроцедуры

&Тест
Процедура ПолучитьАннотацию() Экспорт
	
	// Дано
	Рефлектор = Новый Рефлектор();
	ТаблицаПолей = Рефлектор.ПолучитьТаблицуСвойств(Тип("ВладелецАннотаций"), Истина);

	// Когда
	Результат = РаботаСАннотациями.ПолучитьАннотацию(ТаблицаПолей[0], "Поле");
	
	// Тогда
	Ожидаем.Что(Результат).ИмеетТип("СтрокаТаблицыЗначений");
	Ожидаем.Что(Результат.Имя).Равно("Поле");
	Ожидаем.Что(Результат.Параметры[0].Значение).Равно(1);

КонецПроцедуры

&Тест
Процедура НайтиАннотации() Экспорт
	
	// Дано
	Рефлектор = Новый Рефлектор();
	ТаблицаПолей = Рефлектор.ПолучитьТаблицуСвойств(Тип("ВладелецАннотаций"), Истина);

	// Когда
	Результат = РаботаСАннотациями.НайтиАннотации(ТаблицаПолей[0].Аннотации, "Поле");

	// Тогда
	Ожидаем.Что(Результат.Количество()).Равно(2);
	Ожидаем.Что(Результат).ИмеетТип("Массив");
	Ожидаем.Что(Результат[0]).ИмеетТип("СтрокаТаблицыЗначений");
	Ожидаем.Что(Результат[0].Имя).Равно("Поле");
	Ожидаем.Что(Результат[1].Имя).Равно("Поле");

КонецПроцедуры

&Тест
Процедура НайтиАннотацию() Экспорт
	
	// Дано
	Рефлектор = Новый Рефлектор();
	ТаблицаПолей = Рефлектор.ПолучитьТаблицуСвойств(Тип("ВладелецАннотаций"), Истина);

	// Когда
	Результат = РаботаСАннотациями.НайтиАннотацию(ТаблицаПолей[0].Аннотации, "Поле");
	
	// Тогда
	Ожидаем.Что(Результат).ИмеетТип("СтрокаТаблицыЗначений");
	Ожидаем.Что(Результат.Имя).Равно("Поле");
	Ожидаем.Что(Результат.Параметры[0].Значение).Равно(1);

КонецПроцедуры

&Тест
Процедура НайтиМетодыСАннотацией() Экспорт

	// Дано
	Рефлектор = Новый Рефлектор();
	ТаблицаМетодов = Рефлектор.ПолучитьТаблицуМетодов(Тип("ВладелецАннотаций"));

	// Когда
	Результат = РаботаСАннотациями.НайтиМетодыСАннотацией(ТаблицаМетодов, "Метод");
	
	// Тогда
	Ожидаем.Что(Результат.Количество()).Равно(2);
	Ожидаем.Что(Результат).ИмеетТип("Массив");
	Ожидаем.Что(Результат[0]).ИмеетТип("СтрокаТаблицыЗначений");
	Ожидаем.Что(Результат[0].Имя).Равно("МетодПриватный");
	Ожидаем.Что(Результат[1].Имя).Равно("МетодЭкспортный");

КонецПроцедуры

&Тест
Процедура ПолучитьПараметрыАннотации() Экспорт

	// Дано
	Рефлектор = Новый Рефлектор();
	ТаблицаМетодов = Рефлектор.ПолучитьТаблицуМетодов(Тип("ВладелецАннотаций"));
	АннотацияКонструктора = РаботаСАннотациями.НайтиАннотацию(ТаблицаМетодов[0].Аннотации, "АннотацияКонструктора");

	// Когда
	Результат = РаботаСАннотациями.ПолучитьПараметрыАннотации(АннотацияКонструктора, "Параметр1");

	// Тогда
	Ожидаем.Что(Результат.Количество()).Равно(2);
	Ожидаем.Что(Результат).ИмеетТип("Массив");
	Ожидаем.Что(Результат[0]).ИмеетТип("СтрокаТаблицыЗначений");
	Ожидаем.Что(Результат[0].Значение).Равно(1);
	Ожидаем.Что(Результат[1].Значение).Равно("3");

КонецПроцедуры

&Тест
Процедура ПолучитьПараметрАннотации() Экспорт

	// Дано
	Рефлектор = Новый Рефлектор();
	ТаблицаМетодов = Рефлектор.ПолучитьТаблицуМетодов(Тип("ВладелецАннотаций"));
	АннотацияКонструктора = РаботаСАннотациями.НайтиАннотацию(ТаблицаМетодов[0].Аннотации, "АннотацияКонструктора");

	// Когда
	Результат = РаботаСАннотациями.ПолучитьПараметрАннотации(АннотацияКонструктора, "Параметр1");

	// Тогда
	Ожидаем.Что(Результат).ИмеетТип("СтрокаТаблицыЗначений");
	Ожидаем.Что(Результат.Значение).Равно(1);

КонецПроцедуры

&Тест
Процедура ПолучитьЗначенияПараметровАннотации() Экспорт

	// Дано
	Рефлектор = Новый Рефлектор();
	ТаблицаМетодов = Рефлектор.ПолучитьТаблицуМетодов(Тип("ВладелецАннотаций"));
	АннотацияКонструктора = РаботаСАннотациями.НайтиАннотацию(ТаблицаМетодов[0].Аннотации, "АннотацияКонструктора");

	// Когда
	Результат = РаботаСАннотациями.ПолучитьЗначенияПараметровАннотации(АннотацияКонструктора, "Параметр1");

	// Тогда
	Ожидаем.Что(Результат.Количество()).Равно(2);
	Ожидаем.Что(Результат).ИмеетТип("Массив");
	Ожидаем.Что(Результат[0]).Равно(1);
	Ожидаем.Что(Результат[1]).Равно("3");

КонецПроцедуры

&Тест
Процедура ПолучитьЗначениеПараметраАннотации() Экспорт

	// Дано
	Рефлектор = Новый Рефлектор();
	ТаблицаМетодов = Рефлектор.ПолучитьТаблицуМетодов(Тип("ВладелецАннотаций"));
	АннотацияКонструктора = РаботаСАннотациями.НайтиАннотацию(ТаблицаМетодов[0].Аннотации, "АннотацияКонструктора");

	// Когда
	Результат = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(АннотацияКонструктора, "Параметр1");

	// Тогда
	Ожидаем.Что(Результат).Равно(1);

КонецПроцедуры

&Тест
Процедура ПолучитьЗначениеПараметраАннотации_ЗначениеПоУмолчанию() Экспорт

	// Дано
	Рефлектор = Новый Рефлектор();
	ТаблицаМетодов = Рефлектор.ПолучитьТаблицуМетодов(Тип("ВладелецАннотаций"));
	АннотацияКонструктора = РаботаСАннотациями.НайтиАннотацию(ТаблицаМетодов[0].Аннотации, "АннотацияКонструктора");

	// Когда
	Результат = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(АннотацияКонструктора, "Параметр9", 1);

	// Тогда
	Ожидаем.Что(Результат).Равно(1);

КонецПроцедуры

&Тест
Процедура УстановитьЗначениеПараметраАннотации() Экспорт

	// Дано
	Рефлектор = Новый Рефлектор();
	ТаблицаМетодов = Рефлектор.ПолучитьТаблицуМетодов(Тип("ВладелецАннотаций"));
	АннотацияКонструктора = РаботаСАннотациями.НайтиАннотацию(ТаблицаМетодов[0].Аннотации, "АннотацияКонструктора");

	// Когда
	РаботаСАннотациями.УстановитьЗначениеПараметраАннотации(АннотацияКонструктора, "Параметр2", "999");

	// Тогда
	Ожидаем.Что(АннотацияКонструктора.Параметры[1].Значение).Равно("999");

КонецПроцедуры