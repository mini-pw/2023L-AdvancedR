## [Code Review](https://www.r-bloggers.com/2020/07/best-practices-for-code-review-r-edition/)

### A. Co to jest Code Review?

Przegląd kodu jest wykonywany w zespołach programistów, który tworzy nowy produkt lub funkcję. Celem jest upewnienie się, że wszystko, co zostało dodane do wspólnej bazy kodu jest wolne od błędów, jest zgodne z ustalonymi konwencjami kodowania i jest zoptymalizowane. 

### B. Dlaczego warto przeprowadzać przeglądy kodu?

Podstawową zaletą code review jest poprawa jakości oprogramowania. Dzięki temu, że małe grupy współpracowników regularnie przeglądają nawzajem swoje klasy, funkcje i tak dalej, pomaga to zapewnić, że zespół pisze elegancki kod, co z kolei przynosi korzyści całemu procesowi lub oprogramowaniu, które jest tworzone. Chcemy pisać wydajny kod, który zawiera solidną logikę i produkuje odpowiednie dane wyjściowe.

Istnieją jeszcze dwie inne korzyści z prowadzenia code review, o których warto wspomnieć.

 *Spójny projekt*

Przegląd kodu może pomóc w egzekwowaniu spójnego stylu kodowania, który sprawia, że kod źródłowy jest czytelny dla różnych członków zespołu. Jeśli różni członkowie w zespole data science będą przestrzegać jednego stylu kodowania, zapewni to, że różne części projektu mogą być przekazywane z jednego członka zespołu do drugiego z większą płynnością. 

*Dzielenie się wiedzą i mentorstwo*

Code reviews pozwala również współpracownikom uczyć się od siebie nawzajem, a młodszym osobom uczyć się od bardziej doświadczonych członków zespołu. Umożliwiając wszystkim członkom zespołu przeglądanie kodu innych osób, pozwala pracownikom o różnym poziomie doświadczenia wiele się nauczyć poprzez lepsze zrozumienie kodu. 

### C. Jakie czynniki powinny być brane pod uwagę podczas przeglądu kodu?

Code review powinien zawierać odpowiedzi na następujące pytania:

1) Czy ten kod realizuje cel autora?
2) Czy w kodzie są jakieś oczywiste błędy logiczne?
3) Patrząc na wymagania, czy wszystkie przypadki są w pełni zaimplementowane?
4) Czy kod jest zgodny z istniejącymi wytycznymi stylu?
5) Czy są jakieś obszary, w których kod mógłby zostać poprawiony? (skrócić, przyspieszyć, itp.)
6) Czy jest to najlepszy sposób na osiągnięcie pożądanego rezultatu?
7) Czy kod obsługuje wszystkie przypadki brzegowe?
8) Czy testy jednostkowe były odpowiednie?
9) Czy jest odpowiednia dokumentacja i komentarze?

W przypadku, w którym osoba wykonująca przegląd kodu sugeruje zmianę zaleca się, aby podała uzasadniony powód.


