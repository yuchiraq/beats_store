#ifndef RANDOMBEATSMODEL_H
#define RANDOMBEATSMODEL_H

#include <QObject>
#include <QSqlQueryModel>

class RandomBeatsModel : public QSqlQueryModel {
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1, // idFNameRole,
        TitleRole,
        AuthorRole,
        timeRole,
        coverRole
    };
    // Объявляем конструктор класса
    explicit RandomBeatsModel(QObject *parent = nullptr);
    // Переопределяем метод, который будет возвращать данные
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

public slots:
    void updateModel(int type);
    int getId(int row);

};

#endif // RANDOMBEATSMODEL_H
