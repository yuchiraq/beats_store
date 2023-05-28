#ifndef SEARCHTRACKSMODEL_H
#define SEARCHTRACKSMODEL_H

#include <QObject>
#include <QEventLoop>
#include <QNetworkRequest>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class searchTracksModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QStringList items READ model CONSTANT)
public:
    explicit searchTracksModel(QObject *parent = nullptr);

    QString host = "172.20.10.7";
    QString port = ":8080";

    QStringList model();
public slots:
    bool updateModel(QString title);

private:
    QStringList results;
};

#endif // SEARCHTRACKSMODEL_H
