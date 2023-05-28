#ifndef TRACKDATA_H
#define TRACKDATA_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QEventLoop>

class trackData : public QObject{
    Q_OBJECT
public:
    trackData(QObject *parent = nullptr);

    QString host = "172.20.10.7";
    QString port = ":8080";

public slots:
    QString getTitle(int id);

    QString getAuthorTitle(int id);
    int getAuthorId(int id);

    QString getAlbumTitle(int id);
    int getAlbumId(int id);

    int getDuration(int id);

    int getBPM(int id);

    QString getTags(int id);

    int getPrice(int id);


};

#endif // TRACKDATA_H
