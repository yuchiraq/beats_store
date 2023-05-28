#include "trackdata.h"

trackData::trackData(QObject *parent) : QObject(parent) {

}

QString trackData::getTitle(int id){
    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("http://" + this->host + this->port + "/tracks/getData?ID=" + QString::number(id) + "&type=title")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR getTitleTrack " << reply->error();
        return "";
    }

    QString rep = QString(reply->readAll());

    return rep;
}


QString trackData::getAuthorTitle(int id){
    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("http://" + this->host + this->port + "/tracks/getData?ID=" + QString::number(id) + "&type=authorName")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return "";
    }

    QString rep = QString(reply->readAll());

    return rep;
}

int trackData::getAuthorId(int id){
    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

   QNetworkRequest req(QUrl(QString("http://" + this->host + this->port + "/tracks/getData?ID=" + QString::number(id) + "&type=author")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR getAuthorIdTrack " << reply->error();
        return 0;
    }

    QString rep = QString(reply->readAll());

    return rep.toInt();
}

QString trackData::getAlbumTitle(int id){
    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("http://" + this->host + this->port + "/tracks/getData?ID=" + QString::number(id) + "&type=albumTitle")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return "";
    }

    QString rep = QString(reply->readAll());

    return rep;
}

int trackData::getAlbumId(int id){
    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("http://" + this->host + this->port + "/tracks/getData?ID=" + QString::number(id) + "&type=album")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return 0;
    }

    QString rep = QString(reply->readAll());

    return rep.toInt();
}

int trackData::getDuration(int id){
    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("http://" + this->host + this->port + "/tracks/getData?ID=" + QString::number(id) + "&type=duration")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return 0;
    }

    QString rep = QString(reply->readAll());

    return rep.toInt();
}

int trackData::getBPM(int id){
    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("http://" + this->host + this->port + "/tracks/getData?ID=" + QString::number(id) + "&type=BPM")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return 0;
    }

    QString rep = QString(reply->readAll());

    return rep.toInt();
}

QString trackData::getTags(int id){
    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("http://" + this->host + this->port + "/tracks/getData?ID=" + QString::number(id) + "&type=tags")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return "";
    }

    QString rep = QString(reply->readAll());

    return rep;
}

int trackData::getPrice(int id){
    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("http://" + this->host + this->port + "/tracks/getData?ID=" + QString::number(id) + "&type=price")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return 0;
    }

    QString rep = QString(reply->readAll());

    return rep.toInt();
}
