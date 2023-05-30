#ifndef TRACKDATA_H
#define TRACKDATA_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QEventLoop>

#include "sethost.h"

class trackData : public QObject{
    Q_OBJECT
public:
    trackData(QObject *parent = nullptr);

    //QString host = "172.20.10.7";
    //QString port = ":8080";

public slots:
    QString getTitle(uint id);

    QString getAuthorTitle(uint id);
    uint getAuthorId(uint id);

    QString getAlbumTitle(uint id);
    uint getAlbumId(uint id);

    int getDuration(uint id);

    int getBPM(uint id);

    QString getTags(uint id);

    int getPrice(uint id);

private:
    QMap<uint, QString> titles;
    QMap<uint, QString> authors;
    QMap<uint, QString> albums;

    QMap<uint, int> duration;
    QMap<uint, int> bpm;

    QMap<uint, uint> authorsID;
    QMap<uint, uint> albumsID;

    QMap<uint, QString> tags;

    QMap<uint, int> prices;
};

#endif // TRACKDATA_H
