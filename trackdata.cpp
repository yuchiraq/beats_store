#include "trackdata.h"

trackData::trackData(QObject *parent) : QObject(parent) {

}

QString trackData::getTitle(uint id){

    if(this->titles.contains(id)){
        qDebug() << "title for " << id << " present";
        return this->titles.value(id);
    }
    qDebug() << "title for " << id << " not present" << this->titles;

    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString(setHost::getHost() + setHost::getPort() + "/tracks/getData?ID=" + QString::number(id) + "&type=title")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR getTitleTrack " << reply->error();
        return "";
    }

    QString rep = QString(reply->readAll());

    this->titles.insert(id, rep);

    return rep;
}


QString trackData::getAuthorTitle(uint id){

    if(this->authors.contains(id)){
        return this->authors.value(id);
    }

    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString(setHost::getHost() + setHost::getPort() + "/tracks/getData?ID=" + QString::number(id) + "&type=author")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR AUTHOR TITLE" << reply->error();
        return "";
    }

    QString rep = QString(reply->readAll());

    this->authors.insert(id, rep);

    return rep;
}

QString trackData::getAlbumTitle(uint id){

    if(this->albums.contains(id)){
        return this->albums.value(id);
    }

    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString(setHost::getHost() + setHost::getPort() + "/tracks/getData?ID=" + QString::number(id) + "&type=album")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return "";
    }

    QString rep = QString(reply->readAll());

    this->albums.insert(id, rep);

    return rep;
}

int trackData::getDuration(uint id){

    if(this->duration.contains(id)){
        return this->duration.value(id);
    }

    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString(setHost::getHost() + setHost::getPort() + "/tracks/getData?ID=" + QString::number(id) + "&type=duration")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return 0;
    }

    QString rep = QString(reply->readAll());

    this->duration.insert(id, rep.toUInt());

    return rep.toInt();
}

int trackData::getBPM(uint id){

    if(this->bpm.contains(id))
        return this->bpm.value(id);

    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString(setHost::getHost() + setHost::getPort() + "/tracks/getData?ID=" + QString::number(id) + "&type=BPM")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return 0;
    }

    QString rep = QString(reply->readAll());

    this->bpm.insert(id, rep.toInt());

    return rep.toInt();
}

QString trackData::getTags(uint id){

    if(this->tags.contains(id))
        return this->tags.value(id);

    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString(setHost::getHost() + setHost::getPort() + "/tracks/getData?ID=" + QString::number(id) + "&type=tags")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return "";
    }

    QString rep = QString(reply->readAll());

    this->tags.insert(id, rep);

    return rep;
}

int trackData::getPrice(uint id){

    if(this->prices.contains(id))
        return this->prices.value(id);

    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString(setHost::getHost() + setHost::getPort() + "/tracks/getData?ID=" + QString::number(id) + "&type=price")));
    reply = manager.get(req);
    eventloop.exec();

    if(reply->error() != QNetworkReply::NoError){
        qDebug() << "CONNECT ERROR " << reply->error();
        return 0;
    }

    QString rep = QString(reply->readAll());

    this->prices.insert(id, rep.toInt());

    return rep.toInt();
}
