#ifndef MAINSCREEN_H
#define MAINSCREEN_H

#include "IScreen.h"
#include <QWidget>
#include <QPushButton>


class mainScreen : public IScreen
{

    Q_OBJECT

public:
    mainScreen();

private:

    QPushButton *leftNavigationButton, *centralNavigationButton,
        *rightNavigationButton;
};

#endif // MAINSCREEN_H
