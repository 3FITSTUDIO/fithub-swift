# Fithub

Projekt licencjacki na kierunku Informatyka, specjalność ogólna, wydział Matematyki, Fizyki i Informatyki Uniwersytetu Gdańśkiego.

## Początek

Należy pobrać to repozytorium, pobrać repozytorium zawierające pliki potrzebne do konfiguracji JSON REST API [stąd](), zbudować aplikację na iPhonie lub symulatorze.

### Wymagania

- Xcode
- Cocoapods
- Macbook (do budowania)
- iPhone X, XR, XS, XS Max, iPhone 11, iPhone 11Pro, iPhone 11 Pro Max (w przypadku budowania na urządzeniu)

### Instalacja

JSON Server
1. Zainstaluj JSON Server zgodnie z [oficjalną instrukcją](https://github.com/typicode/json-server#getting-started).
2. Otwórz terminal i nawiguj do lokalizacji pliku `db.json`.
3. Wykonaj polecenie `json-server --watch db.json` lub `json-server --watch db.json --port [tu wstaw numer wybranego portu]`. 
Pomininięcie parametru `--port` skutkuje domyślnym użyciem portu 3000.

NGROK, portowanie localhost do adresu online.
1. Zainstaluj NGROK zgodnie z [oficjalną instrukcją](https://dashboard.ngrok.com/signup).
2. Otwórz terminal i upewnij się, że jesteś w katalogu domowym (`~`). 
3. Sprawdź na jakim porcie localhost uruchomiony jest JSON Server (domyślnie 3000).
4. Wykonaj polecenie `./ngrok http port [tu wstaw numer portu JSON Server]`.
5. Powinieneś uzyskać informację o pozytywnym uruchomieniu tunelu wraz z adresem HTTP URL zapewnionym przez NGROK, na którym dostępny online jest Twoj JSON Server z localhost.

Projekt Xcode
1. Otwórz terminal i nawiguj do katalogu projektu.
2. Wykonaj polecenie `pod install`, jeśli to koneiczne, wykonaj polecenie `pod install --repo-update`. 
3. Otwórz plik `.xcworkspace` z katalogu projektu z użyciem Xcode.
- W tej sekcji upewnij się czy chcesz uruchomić aplikację ze wsparciem API hostowanego lokalnie (localhost, symulator-only), czy online (NGROK, symulator oraz urządzenia).
- W obydwu przypadkach upewnij się, że w pliku `NetworkingClient.swift` stała `urlBase` ma wartość odpowiedniego Stringa z adresem localhost lub NGROK URL.
4. Upewnij się, że wybrany schemat budowania to `fithub-swift-client`.
5. Wybierz urządzenie, na którym chcesz uruchomić aplikację. (Tylko iPhone, iPhone X lub nowszy, iOS 12.4 lub nowszy).
6. Zbuduj, lub uruchom aplikację.

## Architektura

### Wzorzec projektowy MVVM i jego implementacja
// TODO
### Koncepcja store'ów i przechowywanie danych
// TODO
### Komunikacja z API
// TODO
### Własna klasa do generowania wykresów
// TODO

## Uruchamianie testów

By uruchomić testy użyj kombinacji klawiszy CMD+U. Spowoduje to nowy build aplikacji i uruchomienie wszystkich dostępnych testów.

### Opis testów.

// TODO

## Zbudowane z użyciem

* [Xcode](https://developer.apple.com/xcode/) - iOS IDE od Apple.
* [Swift 5](https://swift.org) - język programowania na platformy systemów Apple
* [Cocoapods](https://cocoapods.org) - Manager bibliotek
* [Alamofire](https://github.com/Alamofire/Alamofire) - Biblioteka do HTTP Networkingu
* [Easypeasy](https://github.com/nakiostudio/EasyPeasy) - Swiftowy framework do autolayout'u
* [JSON Server](https://github.com/typicode/json-server) - JS REST API framework
* [NGROK](https://ngrok.com) - narzędzie do tunelowania SSH localhostów, użyte w procesie testowania aplikacji na urządzeniach.

## Współtworzenie

Jako, że jest to projekt uczelniany, żadna forma współtworzenia nie jest przewidziana, ani dozwolona. 

## Autorzy

* **Dominik Urbaez Gomez** - *Główna praca* - [Profil na Github](https://github.com/durbaezgomez)

## Licencja

Ten projekt jest na licencji wyłącznej dla Uniwersytetu Gdańskiego.

## Wzmianki

Źródła, które okazały się przydatne w tworzeniu tego projektu:
* [Ray Wenderlich forum](https://www.raywenderlich.com)
* [Let's Build That App YouTube channel](https://www.youtube.com/channel/UCuP2vJ6kRutQBfRmdcI92mA)
* [Apple Developer Documentation](https://developer.apple.com/documentation/)
* [Swift by Sundell](https://www.swiftbysundell.com/)
* [Swift & iOS13 Complete Bootcamp](https://www.udemy.com/course/ios-13-app-development-bootcamp/)
