#include "sethost.h"

setHost::setHost(QObject *parent) : QObject(parent) {

}

setHost::setHost(DataBaseTracks* databaseObj, trackData* trackDataCur){
    this->database = databaseObj;
    this->trackDataClass = trackDataCur;

}

void setHost::getHost(QString newHost){
    this->database->host = newHost;
    this->database->connectToDataBase();
    this->trackDataClass->host = newHost;
}

bool setHost::connectDB(){
    this->conectionDB = database->connected;
    return this->conectionDB;
}

bool setHost::connect(){


    QNetworkReply *reply;
    QNetworkAccessManager manager;

    manager.setTransferTimeout(3000);

    QEventLoop eventloop;

    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("http://" + database->host + database->port + "/")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError)
        qDebug() << "CONNECT ERROR " << reply->error();

    QString rep = QString(reply->readAll());

    qDebug() << rep << "CONNECT CHECK";

    this->conectionServer = rep == "availible";

    return this->conectionServer;
}

QString setHost::checkNotification(){
    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("http://" + database->host + database->port + "/notify")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return "Error of connection";
    }

    QString rep = QString(reply->readAll());

    qDebug() << rep << "CHECK NOTIFY";

    return rep;
}
