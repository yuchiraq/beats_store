#ifndef SETHOST_H
#define SETHOST_H

#include "databasetracks.h"
#include <QObject>
#include <QNetworkAccessManager>

class setHost : public QObject
{
    Q_OBJECT
public:
    explicit setHost(QObject *parent = nullptr);
    setHost(DataBaseTracks* database);

signals:

public slots:
    void getHost(QString newHost);
    bool connect();
    QString checkNotification();
    bool connectDB();

private:
    bool conectionDB = false;
    bool conectionServer = false;
    //Requester* requester;
    DataBaseTracks* database;
};

#endif // SETHOST_H