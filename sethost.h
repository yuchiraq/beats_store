#ifndef SETHOST_H
#define SETHOST_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QEventLoop>

class setHost : public QObject
{
    Q_OBJECT
public:
    explicit setHost(QObject *parent = nullptr);
    static QString getHost();
    static QString getPort();
    static int getTimeout();

public slots:
    static void setNewHost(QString newHost, QString newPort = ":8080");
    static bool connect();
    static QString checkNotification();

private:
    static inline QString host = "http://localhost";
    static inline QString port = ":8080";
    static inline int timeout = 10000;
    static inline bool conectionServer = false;
};

#endif // SETHOST_H
