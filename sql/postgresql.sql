CREATE TABLE IF NOT EXISTS bookcases (
    id serial4 NOT NULL,
    CONSTRAINT bookcases_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS publishers (
    id serial4 NOT NULL,
    "name" varchar NOT NULL,
    description text NULL,
    CONSTRAINT publishers_pk PRIMARY KEY (id)
);

CREATE TABLE shelves (
    id serial4 NOT NULL,
    bookcase_id int4 NOT NULL,
    CONSTRAINT shelves_pk PRIMARY KEY (id),
    CONSTRAINT shelves_fk FOREIGN KEY (bookcase_id) REFERENCES bookcases(id)
);

CREATE TABLE IF NOT EXISTS users (
    id serial4 NOT NULL,
    "name" varchar NOT NULL,
    phone varchar NOT NULL,
    CONSTRAINT users_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS book_details (
    id serial4 NOT NULL,
    title varchar NOT NULL,
    description text NULL,
    authors varchar NOT NULL,
    publication_year int4 NOT NULL,
    publisher_id int4 NOT NULL,
    CONSTRAINT book_details_pk PRIMARY KEY (id),
    CONSTRAINT book_details_fk FOREIGN KEY (publisher_id) REFERENCES publishers(id)
);

CREATE TABLE IF NOT EXISTS book_copies (
    id serial4 NOT NULL,
    book_id int4 NOT NULL,
    shelf_id int4 NOT NULL,
    bookcase_id int4 NOT NULL,
    is_occupied bool NOT NULL DEFAULT false,
    borrowed_by int4 NULL,
    CONSTRAINT book_copies_pk PRIMARY KEY (id),
    CONSTRAINT book_details_fk FOREIGN KEY (book_id) REFERENCES book_details(id),
    CONSTRAINT bookcases_fk FOREIGN KEY (bookcase_id) REFERENCES bookcases(id),
    CONSTRAINT shelves_fk FOREIGN KEY (shelf_id) REFERENCES shelves(id),
    CONSTRAINT users_fk FOREIGN KEY (borrowed_by) REFERENCES users(id)
);

CREATE TABLE loans_history (
    id serial4 NOT NULL,
    user_id int4 NOT NULL,
    book_copy_id int4 NOT NULL,
    taken_at int4 NOT NULL,
    returned_at int4 NULL,
    CONSTRAINT loans_history_pk PRIMARY KEY (id),
    CONSTRAINT book_copy_fk FOREIGN KEY (book_copy_id) REFERENCES book_copies(id),
    CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO publishers VALUES (1, 'Азбука', 'Русская и зарубежная классика, современная художественная литература, фэнтези и фантастика, культурология, искусство, книги для детей, комиксы и манга.');
INSERT INTO publishers VALUES (2, 'АСТ', 'Издательство АСТ – одно из крупнейших издательств, занимающее лидирующие позиции на российском книжном рынке, основанное в 1990 году. АСТ издает книги практически всех жанров для самой широкой аудитории. Это интеллектуальная и развлекательная литература, русская и зарубежная классика, учебники и учебные пособия, прикладные книги. Издательство выпускает более 40 млн. экземпляров книг в год и объединяет сильнейшую в стране редакционную команду.');
INSERT INTO publishers VALUES (3, 'Эксмо', 'Эксмо» — это универсальное российское издательство, одно из крупнейших в Европе. Каждый год издательство выпускает порядка 80 миллионов книг. Авторский портфель издательства насчитывает около 8 000 имен. Каждая седьмая книга в России — это книга, изданная «Эксмо». Среди серий издательства: остросюжетная литература, сентиментальная проза, современная проза и классическая литература, отечественная и зарубежная фантастика. Здесь вы найдете огромный выбор интересных книг на любой вкус!');


INSERT INTO book_details VALUES (7, 'Золотой теленок', 'Бешеный успех, который обрушился на Ильфа и Петрова после выхода «Двенадцати стульев», побудил соавторов «воскресить» своего героя, сына турецко-подданного Остапа Бендера.

Блистательная дилогия, если верить самим авторам, — «не выдумка. Выдумать можно было бы и посмешнее». Это энциклопедия советского нэпа, энциклопедия быта первого поколения «шариковых».', 'Илья Ильф, Евгений Петров', 2021, 3);
INSERT INTO book_details VALUES (3, 'Мастер и Маргарита', '"Мастер и Маргарита" - итоговое произведение выдающегося отечественного прозаика и драматурга Михаила Афанасьевича Булгакова.', 'Михаил Булгаков', 2010, 1);
INSERT INTO book_details VALUES (4, 'Мёртвые души', '«…Говоря о „Мертвых душах“, можно вдоволь наговориться о России», – это суждение поэта и критика П. А. Вяземского объясняет особое место поэмы Гоголя в истории русской литературы: и огромный успех у читателей, и необычайную остроту полемики вокруг главной гоголевской книги, и многообразие высказанных мнений, каждое из которых так или иначе вовлекает в размышления о природе национального мышления и культурного сознания, о настоящем и будущем России.', 'Николай Гоголь', 2005, 2);
INSERT INTO book_details VALUES (5, 'Двенадцать стульев', 'И. Ильф и Е. Петров завершили роман «Двенадцать стульев» в 1928 году, но еще до первой публикации цензоры изрядно сократили, «почистили» его. Правка продолжалась от издания к изданию еще десять лет. В итоге книга уменьшилась почти на треть. Публикуемый ныне вариант — первый полный — реконструирован по архивным материалам. Книга снабжена обширным историко-литературным и реальным комментарием.', 'Илья Ильф, Евгений Петров', 2002, 1);
INSERT INTO book_details VALUES (6, 'Собачье сердце', '«Собачье сердце» – одно из самых любимых читателями произведений Михаила Булгакова. Вас ждёт полный рассказ о необыкновенном эксперименте гениального доктора.', 'Михаил Булгаков', 2010, 2);
INSERT INTO book_details VALUES (8, 'Преступление и наказание', '«Преступление и наказание» (1866) — роман об одном преступлении. Двойное убийство, совершенное бедным студентом из-за денег. Трудно найти фабулу проще, но интеллектуальное и душевное потрясение, которое производит роман, — неизгладимо. В чем здесь загадка? Кроме простого и очевидного ответа — «в гениальности Достоевского» — возможно, существует как минимум еще один: «проклятые» вопросы не имеют простых и положительных ответов. Нищета, собственные страдания и страдания близких всегда ставили и будут ставить человека перед выбором: имею ли я право преступить любой нравственный закон, чтобы потом стать спасителем униженных и утешителем слабых; должен ли я сперва возлюбить себя, а только потом, став сильным, возлюбить ближнего своего? Это вечные вопросы.', 'Федор Достоевский', 2022, 2);
INSERT INTO book_details VALUES (9, 'Война и мир', 'Роман-эпопея, описывающий события войн против Наполеона: 1805 года и отечественной 1812 года. Признан критикой всего мира величайшим эпическим произведением литературы нового времени.', 'Лев Толстой', 2003, 1);
INSERT INTO book_details VALUES (10, 'Евгений Онегин', 'Роман в стихах «Евгений Онегин» стал центральным событием в литературной жизни пушкинской поры. И с тех пор шедевр А.С.Пушкина не утратил своей популярности, по-прежнему любим и почитаем миллионами читателей.', '	Александр Пушкин', 2015, 1);
INSERT INTO book_details VALUES (11, 'Отцы и дети', 'И.С.Тургенев – имя уникальное даже в золотой плеяде классиков русской прозы XIX века. Это писатель, чье безупречное литературное мастерство соотносится со столь же безупречным знанием человеческой души. Тургенев обогатил русскую литературу самыми пленительными женскими образами и восхитительными, поэтичными картинами природы. Произведения Тургенева, облекающие высокую суть в изящно-простую сюжетную форму, по-прежнему не подвластны законам времени – и по-прежнему читаются так, словно написаны вчера…

В романе «Отцы и дети» отразилась идеологическая борьба двух поколений, являвшаяся одной из главных особенностей общественной жизни 60-х годов XIX века. Роман приобрел непреходящие общечеловеческий интерес и значение.', 'Иван Тургенев', 2007, 2);
INSERT INTO book_details VALUES (12, 'Ревизор', '«Ревизор» — одна из лучших русских комедий. Н.В. Гоголь заставил современников смеяться над тем, к чему они привыкли и что перестали замечать. И сегодня комедия, созданная великим русским писателем, продолжая звучать современно, указывает путь к нравственному возрождению.', 'Николай Гоголь', 2010, 2);
INSERT INTO book_details VALUES (13, 'Повести Белкина', 'Цикл повестей Александра Сергеевича Пушкина, состоящий из 5 повестей и выпущенный им без указания имени настоящего автора, то есть самого Пушкина.', 'Александр Пушкин', 2012, 1);
INSERT INTO book_details VALUES (14, 'Палата № 6', 'Это произведение Антона Павловича Чехова вошло в школьную программу и является обязательным для прочтения.

Действия романа происходят в психиатрической больнице. Главный герой – врач в этой самой больнице. Врач обнаружил среди всех своих больных одного с очень интересным мышлением. Пациент шокирует врача своими жизненными убеждениями. Врача повергает шок от жизненной философии этого человека.
После продолжительных бесед врача и пациента врач начал трогаться умом.
Книга поможет найти грань, после которой начинается безумие.', 'Антон Чехов', 2015, 2);
INSERT INTO book_details VALUES (15, 'Братья Карамазовы', 'Самый сложный, самый многоуровневый и неоднозначный из романов Достоевского, который критики считали то «интеллектуальным детективом», то «ранним постмодернизмом», то — «лучшим из произведений о загадочной русской душе».

Роман, легший в основу десятков экранизаций — от предельно точных до самых отвлеченных, — но не утративший своей духовной силы…', 'Федор Достоевский', 2017, 1);

INSERT INTO bookcases VALUES (1);
INSERT INTO bookcases VALUES (2);

INSERT INTO shelves VALUES (2, 1);
INSERT INTO shelves VALUES (3, 1);
INSERT INTO shelves VALUES (4, 1);
INSERT INTO shelves VALUES (5, 2);
INSERT INTO shelves VALUES (6, 2);
INSERT INTO shelves VALUES (7, 2);

INSERT INTO users VALUES (1, 'Вячеслав', '123');
INSERT INTO users VALUES (2, 'Владимир', '456');
INSERT INTO users VALUES (3, 'Кристина', '789');

INSERT INTO book_copies VALUES (1, 7, 2, 1, true, 1);
INSERT INTO book_copies VALUES (2, 7, 2, 1, false, NULL);
INSERT INTO book_copies VALUES (3, 3, 3, 1, true, 2);
INSERT INTO book_copies VALUES (4, 4, 4, 1, false, NULL);
INSERT INTO book_copies VALUES (5, 5, 5, 2, false, NULL);
INSERT INTO book_copies VALUES (7, 7, 7, 2, false, NULL);
INSERT INTO book_copies VALUES (8, 8, 3, 1, false, NULL);
INSERT INTO book_copies VALUES (9, 9, 4, 1, false, NULL);
INSERT INTO book_copies VALUES (10, 10, 5, 2, false, NULL);
INSERT INTO book_copies VALUES (11, 11, 6, 2, false, NULL);
INSERT INTO book_copies VALUES (12, 12, 7, 2, false, NULL);
INSERT INTO book_copies VALUES (13, 13, 3, 1, false, NULL);
INSERT INTO book_copies VALUES (14, 14, 4, 1, false, NULL);
INSERT INTO book_copies VALUES (15, 15, 5, 2, false, NULL);
INSERT INTO book_copies VALUES (6, 6, 6, 2, true, 3);

INSERT INTO loans_history VALUES (3, 1, 1, 1661685731, NULL);
INSERT INTO loans_history VALUES (4, 2, 3, 1661685731, NULL);
INSERT INTO loans_history VALUES (5, 3, 6, 1661685731, NULL);








