#ifndef SEARCHLISTMODEL_H
#define SEARCHLISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>

class searchListModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    // Перечисляем все роли, которые будут использоваться в TableView
    enum Roles {
        IdRole = Qt::UserRole + 1, // idFNameRole,
        TitleRole,
        AuthorRole,
        timeRole,
        coverRole
    };
    // Объявляем конструктор класса
    explicit searchListModel(QObject *parent = nullptr);
    // Переопределяем метод, который будет возвращать данные
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

public slots:
    void updateModel(QString request);
    int getId(int row);

};

#endif // SEARCHLISTMODEL_H
