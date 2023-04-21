#ifndef DATABASETRACKS_H
#define DATABASETRACKS_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>
#include <QSqlDriver>
#include <QSqlDatabase>

#define DATABASE_HOSTNAME "DataBase"
#define DATABASE_NAME "DataBase.db"
#define TABLE "TracksTable"
#define TABLE_TITLE "trackTitle"
#define TABLE_AUTHOR "trackAuthor"
#define TABLE_TIME "trackTime"
///#define TABLE_COVER "coverURL"

//#define DATABASE_HOSTNAME "172.20.10.7"//"127.0.0.1"//"172.20.10.7"
//#define DATABASE_USER "beat_user"
//#define DATABASE_NAME "beats"
//#define DATABASE_PORT 3306
//#define DATABASE_PASS "p@ssword123Beats_User"
//#define TABLE "tracks"
//#define TABLE_TITLE "title"
//#define TABLE_AUTHOR "author"
//#define TABLE_TIME "duration"

class DataBaseTracks : public QObject
{
    Q_OBJECT
public:
    explicit DataBaseTracks(QObject *parent = nullptr);
    void connectToDataBase();

private:
    // Сам объект базы данных, с которым будет производиться работа
    QSqlDatabase db;
private:
    /* Внутренние методы для работы с базой данных
    * */
    bool openDataBase();
    // Открытие базы данных
    bool restoreDataBase(); // Восстановление базы данных
    void closeDataBase();
    // Закрытие базы данных
    bool createTable();
    // Создание таблицы в базе данных

public slots:
    bool inserIntoTable(const QVariantList &data); // Добавление записей в

    bool inserIntoTable(const QString &title, const QString &author, const
                        int &time/*, const QString &coverURL*/);
    bool removeRecord(const int id); // Удаление записи из таблицы по ее id

    QString showDB();

    int getQuantity();

    void deleteData();
};

#endif // DATABASETRACKS_H
