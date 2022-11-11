#ifndef ISCREENSSTACK_H
#define ISCREENSSTACK_H

#include <QString>

#include "IScreen.h"

class IScreensStack {

public:
    IScreensStack() = default;
    ~IScreensStack() = default;

    virtual IScreen* create(QString tag);
    virtual QString createStart();

};

#endif // ISCREENSSTACK_H
