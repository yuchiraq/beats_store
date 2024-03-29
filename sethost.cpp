﻿#include "sethost.h"

setHost::setHost(QObject *parent) : QObject(parent) {
    qDebug() << this->host << " HOST cc";
}

QString setHost::getHost(){
    if(host.isNull())
        qDebug() << "HOST NULL";
    if(host.isNull())
        return "http://localhost";
    else
        return host;
}

QString setHost::getPort(){
    if(port.isNull())
        return ":8080";
    else
        return port;
}

int setHost::getTimeout(){
    return timeout;
}

void setHost::setNewHost(QString newHost, QString newPort){
    host = newHost;
    port = newPort;
    conectionServer = false;
    conectionServer = connect();
}

bool setHost::connect(){


    QNetworkReply *reply;
    QNetworkAccessManager manager;

    manager.setTransferTimeout(timeout);

    QEventLoop eventloop;

    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString(getHost() + getPort() + "/check")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError)
        qDebug() << "CONNECT ERROR " << reply->error();

    QString rep = QString(reply->readAll());

    qDebug() << rep << "CONNECT CHECK";

    conectionServer = rep == "availible";

    return conectionServer;
}

QString setHost::checkNotification(){
    QNetworkReply *reply;
    QNetworkAccessManager manager;

    manager.setTransferTimeout(timeout);

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString(getHost() + getPort() + "/check")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError)
        qDebug() << "CONNECT ERROR " << reply->error();

    QString rep = QString(reply->readAll());

    if(rep != "availible"){
        qDebug() << "ERROR " << rep;
        return rep;
    }
    req.setUrl(QUrl(QString(getHost() + getPort() + "/notify")));

    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return "Error of connection";
    }

    rep = QString(reply->readAll());

    qDebug() << rep << "CHECK NOTIFY";

    return rep;
}
