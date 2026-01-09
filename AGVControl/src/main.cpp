#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "AgvController.h"

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Register the C++ type or context property
    AgvController agvController;

    QQmlApplicationEngine engine;

    // Expose controller to QML
    engine.rootContext()->setContextProperty("agvBackend", &agvController);

    const QUrl url(u"qrc:/qml/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
