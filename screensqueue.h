#ifndef SCREENSQUEUE_H
#define SCREENSQUEUE_H

#include <QString>

#include "IScreensStack.h"


namespace screens {
    static const QString SPLASH_TAG = "splash";
    static const QString START_TAG = "start";
    static const QString LOGIN_TAG = "login";
    static const QString REGISTRATION_TAG = "registration";
    static const QString MAIN_TAG = "main";
    // и так далее.....
};

class ScreensQueue : public IScreensStack {
public:
    ScreensQueue();
    ~ScreensQueue();

    IScreen* create(QString tag) override;
    QString createStart() override;
};

#endif // SCREENSQUEUE_H
