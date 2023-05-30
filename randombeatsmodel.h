#ifndef RANDOMBEATSMODEL_H
#define RANDOMBEATSMODEL_H

#include <QObject>
#include <QSqlQueryModel>

#include "sethost.h"

class RandomBeatsModel : public QObject {
    Q_OBJECT

    Q_PROPERTY(QStringList items READ model CONSTANT)
public:
    // Объявляем конструктор класса
    explicit RandomBeatsModel(QObject *parent = nullptr);
    // Переопределяем метод, который будет возвращать данные
    QStringList model();

public slots:
    void updateModel(QString quantity, QString type = "");

private:
    QStringList results;
};

#endif // RANDOMBEATSMODEL_H
