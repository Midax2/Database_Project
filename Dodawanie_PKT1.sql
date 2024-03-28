CREATE TABLE Studenci (
    Nr_albumu CHAR(10) PRIMARY KEY NOT NULL CHECK (ISNUMERIC(Nr_albumu) = 1),
    Imie VARCHAR(20) NOT NULL CHECK (ISNUMERIC(Imie) = 0),
    Nazwisko VARCHAR(20) NOT NULL CHECK (ISNUMERIC(Nazwisko) = 0),
    Numer_telefonu VARCHAR(15) CHECK (Numer_telefonu LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]'),
    Email VARCHAR(30) CHECK (Email LIKE '%@%.%'),
    Semestr VARCHAR(2) CHECK (Semestr BETWEEN 1 AND 20)
);
CREATE TABLE Pracownicy (
    Nr_albumu CHAR(10) PRIMARY KEY NOT NULL CHECK (ISNUMERIC(Nr_albumu) = 1),
    Imie VARCHAR(50) NOT NULL CHECK (ISNUMERIC(Imie) = 0),
    Nazwisko VARCHAR(50) NOT NULL CHECK (ISNUMERIC(Nazwisko) = 0),
    Numer_telefonu NVARCHAR(12) NOT NULL CHECK (Numer_telefonu LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]'),
);
CREATE TABLE Oceny (
    Nr_albumu_studenta CHAR(10) NOT NULL CHECK (ISNUMERIC(Nr_albumu_studenta) = 1),
    Przedmiot VARCHAR(50) NOT NULL CHECK (ISNUMERIC(Przedmiot) = 0),
    Ocena DECIMAL NOT NULL CHECK (Ocena BETWEEN 2.0 AND 5.0),
    Semestr VARCHAR(2) CHECK(Semestr BETWEEN 1 AND 20),
    Status VARCHAR(20) CHECK(Status in ('Zatwierdzona', 'Niezatwierdzona')) DEFAULT('Niezatwierdzona'),
    Data_wystawienia DATE,
    PRIMARY KEY(Nr_albumu_studenta, Przedmiot),
    FOREIGN KEY (Nr_albumu_studenta) REFERENCES Studenci(Nr_albumu) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Wniosek_o_stypendium (
    ID_wniosku CHAR(10) PRIMARY KEY NOT NULL CHECK (ISNUMERIC(ID_wniosku) = 1),
    Data_Zlozenia DATETIME,
    Status_wniosku VARCHAR(20) CHECK(Status_wniosku in ('Zaakceptowany', 'Niezaakceptowany')) DEFAULT('Niezaakceptowany'),
    Kwota DECIMAL CHECK (Kwota >= 0),
    Nr_albumu_studenta CHAR(10) NOT NULL CHECK (ISNUMERIC(Nr_albumu_studenta) = 1),
    Nr_albumu_pracownika CHAR(10) NOT NULL CHECK (ISNUMERIC(Nr_albumu_pracownika) = 1),
    FOREIGN KEY (Nr_albumu_studenta) REFERENCES Studenci(Nr_albumu) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Nr_albumu_pracownika) REFERENCES Pracownicy(Nr_albumu) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Wniosek_o_stypendium_socjalne(
    Dochod_rodziny DECIMAL NOT NULL CHECK (Dochod_rodziny >= 0),
    Typ_rodziny VARCHAR(50) NOT NULL,
    ID_wniosku CHAR(10) PRIMARY KEY NOT NULL CHECK (ISNUMERIC(ID_wniosku) = 1),
    FOREIGN KEY (ID_wniosku) REFERENCES Wniosek_o_stypendium(ID_wniosku) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Wniosek_o_stypendium_sportowe(
    Dyscyplina_sportowa VARCHAR(50) NOT NULL CHECK (ISNUMERIC(Dyscyplina_sportowa) = 0),
    ID_wniosku CHAR(10) PRIMARY KEY NOT NULL CHECK (ISNUMERIC(ID_wniosku) = 1),
    FOREIGN KEY (ID_wniosku) REFERENCES Wniosek_o_stypendium(ID_wniosku) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Wniosek_o_stypendium_naukowe(
    Dziedzina_naukowa  VARCHAR(50) NOT NULL CHECK (ISNUMERIC(Dziedzina_naukowa) = 0),
    ID_wniosku CHAR(10) PRIMARY KEY NOT NULL CHECK (ISNUMERIC(ID_wniosku) = 1),
    FOREIGN KEY (ID_wniosku) REFERENCES Wniosek_o_stypendium(ID_wniosku) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Wyplata (
    ID_wyplaty CHAR(10) PRIMARY KEY NOT NULL CHECK (ISNUMERIC(ID_wyplaty) = 1),
    Data_wyplaty DATE,
    Kwota DECIMAL NOT NULL CHECK (Kwota >= 0),
    Status_wyplaty VARCHAR(20) NOT NULL CHECK (Status_wyplaty IN ('Wypłacono', 'Niewypłacono')) DEFAULT ('Niewypłacono'),
    ID_wniosku CHAR(10) NOT NULL, CHECK (ISNUMERIC(ID_wniosku) = 1),
    FOREIGN KEY (ID_wniosku) REFERENCES Wniosek_o_stypendium(ID_wniosku) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Wyniki_sportowe (
    ID CHAR(10) PRIMARY KEY NOT NULL CHECK (ISNUMERIC(ID) = 1),
    Nr_albumu_studenta CHAR(10) NOT NULL CHECK (ISNUMERIC(Nr_albumu_studenta) = 1),
    Osiagniecie VARCHAR(255) NOT NULL,
    Data DATE,
    Nagroda VARCHAR(255),
    ID_wniosku CHAR(10) NOT NULL CHECK (ISNUMERIC(ID_wniosku) = 1),
    FOREIGN KEY (ID_wniosku) REFERENCES Wniosek_o_stypendium_sportowe(ID_wniosku) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Wyniki_naukowe (
    ID CHAR(10) PRIMARY KEY NOT NULL CHECK (ISNUMERIC(ID) = 1),
    Nr_albumu_studenta CHAR(10) NOT NULL CHECK (ISNUMERIC(Nr_albumu_studenta) = 1),
    Osiagniecie VARCHAR(255) NOT NULL,
    Data DATE,
    Nagroda VARCHAR(255),
    ID_wniosku CHAR(10) NOT NULL CHECK (ISNUMERIC(ID_wniosku) = 1),
    FOREIGN KEY (ID_wniosku) REFERENCES Wniosek_o_stypendium_naukowe(ID_wniosku) ON DELETE CASCADE ON UPDATE CASCADE
);