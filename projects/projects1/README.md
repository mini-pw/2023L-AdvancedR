## Projekt 1

## Cel i motywacja 
Wiele czasu poświęcamy nad analizą danych, niezależnie czy przed modelowaniem czy po prostu, żeby zrozumieć pewne zjawiska. Nie od dziś wiemy, że to dane są kluczowym elementem pozyskiwania informacji oraz motorem do budowania wysoko wydajnych modeli predykcyjnych. Są one również ważną częścią procesu CRISP-DM.

### Czym jest CRISP DM?

***CR**oss **I**ndustry **S**tandard **P**rocess for **D**ata **M**ining (CRISP-DM)* to model procesowy, który służy jako podstawa procesu data science. Składa się on z sześciu sekwencyjnych faz:
1. Zrozumienie biznesu - Czego potrzebuje biznes?
2. Zrozumienie danych - Jakie dane mamy / potrzebujemy? Czy są one czyste?
3. Przygotowanie danych - Jak organizujemy dane do modelowania?
4. Modelowanie - Jakie techniki modelowania powinniśmy zastosować?
5. Ocena - Który model najlepiej spełnia cele biznesowe?
6. Wdrożenie - Jak interesariusze mają dostęp do wyników?

Opublikowana w 1999 roku w celu standaryzacji procesów eksploracji danych w różnych branżach, stała się od tego czasu najbardziej powszechną metodologią dla projektów eksploracji danych, analityki i nauki o danych.

W tym miejscu zwróćmy uwagę na punkt 2. i 3. 

**2. Zrozumienie danych**

Faza zrozumienia danych napędza skupienie się na identyfikacji, zbieraniu i analizie zbiorów danych, które mogą pomóc w osiągnięciu celów projektu. Ta faza również składa się z czterech zadań:
- *Zebranie danych początkowych:* Pozyskaj niezbędne dane i (jeśli to konieczne) załaduj je do swojego narzędzia analitycznego.
- *Opisz dane:* Zbadaj dane i udokumentuj ich właściwości powierzchniowe, takie jak format danych, liczba rekordów czy tożsamości pól.
- *Eksploruj dane:* Zagłębiaj się w dane. Zapytania, wizualizacja i identyfikacja relacji pomiędzy danymi.
- *Weryfikacja jakości danych:* Jak czyste/brudne są dane? Dokumentuj wszelkie problemy związane z jakością.

**3. Przygotowanie danych**

Powszechną zasadą jest, że 80% projektu stanowi przygotowanie danych.

Ta faza, która często jest określana jako "data munging", przygotowuje ostateczny zestaw (zestawy) danych do modelowania. Składa się na nią pięć zadań:
- *Wybierz dane:* Określenie, które zbiory danych zostaną wykorzystane i udokumentowanie powodów włączenia/wyłączenia.
- *Czyszczenie danych:* Często jest to najdłuższe zadanie. Bez niego, prawdopodobnie padniesz ofiarą "śmiecenia" (ang. garbage-in, garbage-out). Częstą praktyką podczas tego zadania jest poprawianie, imputowanie lub usuwanie błędnych wartości.
- *Konstruowanie danych:* Wyprowadź nowe atrybuty, które będą pomocne. Na przykład, określ wskaźnik masy ciała osoby z pól wzrostu i wagi.
- *Integracja danych:* Twórz nowe zestawy danych poprzez łączenie danych z wielu źródeł.
- *Formatuj dane:* W razie potrzeby zmień format danych. Na przykład, możesz przekonwertować wartości łańcuchowe przechowujące liczby na wartości numeryczne, aby móc wykonywać operacje matematyczne.

Podczas Projektu 1 (Część 1) skupimy się na stworzeniu bazy zbiorów danych, które posłużą do testowania rozwiązania z Projektu 2. Natomiast Część 2 będzie kładła nacisk na zapoznanie się dotychczasowymi rozwiązaniami, aby zrozumieć jak działają narzędzia AutoEDA i czy są jakieś brakujące "dziury" do załatania. 

Badania nawiązują do pracy [Staniak, Mateusz & Biecek, Przemyslaw. (2019). The Landscape of R Packages for Automated Exploratory Data Analysis. The R Journal. 11. 10.32614/RJ-2019-033.](https://journal.r-project.org/archive/2019/RJ-2019-033/RJ-2019-033.pdf)

## Część 1 (20p = 10p + 10p)
W tej części skupimy się na przygotowaniu bazy zawierającej zbiory danych. Zadaniem jest przygotowanie dwóch zbiorów danych (jeden dla zadania klasyfikacji, drugi dla zadania regresji). 

Oddanie tej części będzie polegało na wypełnieniu *Ankiety o zbiorze danych*, która będzie zawierała podstawowe informacje oraz na wrzuceniu zbioru danych do katalogu TBA.

#### Punktacja 
1. Za każdy ze zbiorów (dla zadania regresji i klasyfikacji) można otrzymać maksymalnie 10p.
2. W przypadku dodania zbioru, który już ktoś wcześniej już umieścił można otrzymać maksymalnie 5p.
3. Punkty przyznawane są za wypełnienie ankiety i za umieszczenie zbioru danych na repozytorium.
4. Do zbiorów, które będą sztucznie wygenerowane należy dodatkowo zamieścić kod, który pozwoli na odtworzenie wykorzystanych przekształceń. 

## Pytania

1. Ile jest kolumn kategorycznych
2. Ile jest kolumn liczbowych
3. Ile jest kolumn time stampowych
4. Jaki jest target zbioru danych (y)
5. Jaki typ ma target
6. Ilość obserwacji posiadającyh conajmniej jeden brak w danych
7. Ilość obserwacji gdzie brakuje targetu
8. Ile i które kolumny są statyczne
9. Ile i które kolumny są duplikatami
10. Jak mocno skorelowane są zmienne liczbowe (Pearsona) i kategoryczne (Crammera V)
11. Ile i które kolumny są ID-like (mają id w nazwie / są takim kluczem głównym, sąnumeracją pewnego rodzaju)
12. Ile obserwacji zawiera zbiór danych
13. Czy dane są rzeczywiste czy sztucznie wygenerowane
14. Krótki opis zbioru danych
15. Gdzie znaleziony został zbiór danych
16. Jaka jest proporcja klas targetu / Jaki jest rozkład wartości targetu
17. Ile unikalnych wartości (levels) mają poszczególne zmienne kategoryczne



## Część 2 (25p = 7 x 3p + 4p)  
W tej części podejmiemy próbę zweryfikowania już istniejących rozwiązań do AutoEDA. Każdy dostanie przydzielony pakiet oraz zadanie (regresja/klasyfikacja) dla którego będzie należało wypełnić tablę (patrz niżej *Funkcjonalności*) oraz w przypadku gdy dany pakiet zawiera te funkcjonalności należy zamieści kod z przykładem użycia. Pakiety, które bierzemy pod uwagę są wymienione poniżej.

#### Pakiety:
- arsenal
- DataExplorer
- ExPanDaR
- explore	
- funModeling
- inspectdf
- SmartEDA
- summarytools
- visdat
- dlookr


#### Funkcjonalności:

<table style="undefined;table-layout: fixed; width: 349px">
<colgroup>
<col style="width: 129.116667px">
<col style="width: 220.116667px">
</colgroup>
<thead>
  <tr>
    <th>Task type</th>
    <th>Task</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td rowspan="4">Dataset</td>
    <td>Variable types</td>
  </tr>
  <tr>
    <td>Dimensions</td>
  </tr>
  <tr>
    <td>Other info </td>
  </tr>
  <tr>
    <td>Compare datasets</td>
  </tr>
  <tr>
    <td rowspan="5">Validity</td>
    <td>Missing values</td>
  </tr>
  <tr>
    <td>Redundant col.</td>
  </tr>
  <tr>
    <td>Outliers</td>
  </tr>
  <tr>
    <td>Atypical values</td>
  </tr>
  <tr>
    <td>Level encoding</td>
  </tr>
  <tr>
    <td rowspan="5">Univar.</td>
    <td>Descriptive stat.</td>
  </tr>
  <tr>
    <td>Histograms</td>
  </tr>
  <tr>
    <td>Other dist. plots</td>
  </tr>
  <tr>
    <td>Bar plots</td>
  </tr>
  <tr>
    <td>QQ plots</td>
  </tr>
  <tr>
    <td rowspan="9">Bivar.</td>
    <td>Descriptive stat.</td>
  </tr>
  <tr>
    <td>Correlation matrix</td>
  </tr>
  <tr>
    <td>1 vs each corr.</td>
  </tr>
  <tr>
    <td>Time-dependency<br></td>
  </tr>
  <tr>
    <td>Bar plots by target</td>
  </tr>
  <tr>
    <td>Num. plots by target</td>
  </tr>
  <tr>
    <td>Scatter plots</td>
  </tr>
  <tr>
    <td>Contigency tables</td>
  </tr>
  <tr>
    <td>Other stats. (factor)</td>
  </tr>
  <tr>
    <td rowspan="3">Multivar.</td>
    <td>PCA</td>
  </tr>
  <tr>
    <td>Stat. models</td>
  </tr>
  <tr>
    <td>PCP</td>
  </tr>
  <tr>
    <td rowspan="6">Transform.</td>
    <td>Imputation</td>
  </tr>
  <tr>
    <td>Scaling</td>
  </tr>
  <tr>
    <td>Skewness</td>
  </tr>
  <tr>
    <td>Outlier treatment</td>
  </tr>
  <tr>
    <td>Binning</td>
  </tr>
  <tr>
    <td>Merging levels</td>
  </tr>
  <tr>
    <td rowspan="2">Reporting</td>
    <td>Reports</td>
  </tr>
  <tr>
    <td>Saving outputs</td>
  </tr>
</tbody>
</table>



