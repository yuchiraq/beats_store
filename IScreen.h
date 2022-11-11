#ifndef ISCREEN_H
#define ISCREEN_H

#include <QFrame>

class IScreen: public QWidget {
    Q_OBJECT

    /**
     * Интерфейс активности
    */

signals:
    //тут мы потом определим сигналы для навигатора
    void back();
    void navigateTo(QString tag);
    void newRootScreen(QString tag);
    void replace(QString tag);

    //void navigateWhithData(QString tag, BaseModel* model);

public:
    IScreen() = default;
    ~IScreen() = default;

    virtual void onPause();
    virtual void onResume();
    //virtual void setData(BaseModel* model);

    //тут реализуем что-то из жизненного цикла
};

#endif // ISCREEN_H
