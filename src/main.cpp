#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>



#include "todolist.h"
#include "todomodel.h"

int main(int argc, char *argv[])
{
    //Q_INIT_RESOURCE(qml);

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<ToDoModel>("ToDo", 1, 0, "ToDoModel");
    qmlRegisterUncreatableType<ToDoList>("ToDo", 1, 0, "ToDoList",
    QStringLiteral("ToDoList should not be created in QML"));

    ToDoList toDoList;


    const QUrl url(QStringLiteral("qrc:/main.qml"));


    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.rootContext()->setContextProperty(QStringLiteral("toDoList"), &toDoList);

    engine.load(url);
    return app.exec();
}
