% Убираем повторяющиеся элементы из списка
unique([], []).
unique([H|T], [H|T2]) :- not(member(H, T)), unique(T, T2).
unique([H|T], T2) :- member(H, T), unique(T, T2).

% Объединение двух списков
union([], L, L).
union([H|T], L, [H|T2]) :- not(member(H, L)), union(T, L, T2).
union([H|T], L, T2) :- member(H, L), union(T, L, T2).

% Пересечение двух списков
intersection([], _, []).
intersection([H|T], L, [H|T2]) :- member(H, L), intersection(T, L, T2).
intersection([H|T], L, T2) :- not(member(H, L)), intersection(T, L, T2).

% Дополнение множества A относительно множества U (все элементы, которые есть в U, но нет в A)
complement([], _, []).
complement([H|T], U, [H|T2]) :- not(member(H, U)), complement(T, U, T2).
complement([H|T], U, T2) :- member(H, U), complement(T, U, T2).

% Закон де Моргана: ~ (A U B) = (~ A) ∩ (~ B)
de_morgan(A, B) :-
    unique(A, A1),
    unique(B, B1),
    union(A1, B1, UnionAB),
    complement(UnionAB, UnionAB, NotUnionAB),
    complement(A1, UnionAB, NotA),
    complement(B1, UnionAB, NotB),
    intersection(NotA, NotB, NotUnionAB),
    write('Закон де Моргана выполняется: ~ (A U B) = (~ A) ∩ (~ B)'), nl.

% Стартовая процедура для тестирования с вводом с клавиатуры
start :-
    write('Введите множество A (список чисел): '), nl,
    read(A), % Чтение множества A с клавиатуры
    write('Введите множество B (список чисел): '), nl,
    read(B), % Чтение множества B с клавиатуры
    write('Множество A: '), write(A), nl,
    write('Множество B: '), write(B), nl,
    de_morgan(A, B).
