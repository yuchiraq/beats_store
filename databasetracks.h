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

#include <QTextCodec>

#include <QNetworkReply>
#include <QEventLoop>

#include "sethost.h"

#define DATABASE_HOSTNAME "DataBase"
#define DATABASE_NAME ":memory:"
#define TABLE "tracks"
#define TABLE_TITLE "title"
#define TABLE_AUTHOR "author_id"
#define TABLE_TIME "duration"

class DataBaseTracks : public QObject
{
    Q_OBJECT
public:
    //QString host = "172.20.10.7";
    //QString port = ":8080";

    explicit DataBaseTracks(QObject *parent = nullptr);
    void connectToDataBase();

    bool connected = false;
private:
    // Сам объект базы данных, с которым будет производиться работа
    QSqlDatabase db;
private:

    QString divider = "|||";
    /* Внутренние методы для работы с базой данных
    * */
    bool openDataBase();
    // Открытие базы данных
    bool restoreDataBase(); // Восстановление базы данных
    void closeDataBase();
    // Закрытие базы данных
    bool createTable();
    // Создание таблицы в базе данных
    bool insertData();

public slots:

    QString showDB();

    int getQuantity();

    void deleteData();
};

#endif // DATABASETRACKS_H
