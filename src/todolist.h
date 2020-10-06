#ifndef TODOLIST_H
#define TODOLIST_H

#include <QObject>
#include <QVector>
#include <QGeoCoordinate>
#include <QIODevice>
#include "myclient.h"

struct ToDoItem
{

    float latitude;
    float longitude;
    QString userLogin;
    QString description;
    int danger;
};

class ToDoList : public QObject
{
    Q_OBJECT

public:
    explicit ToDoList(QObject *parent = nullptr);


    QVector<ToDoItem> items() const;

    bool setItemAt(int index, const ToDoItem &item);


signals:
    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int index);
    void postItemRemoved();

    void preAllItemAppended();
    void postAllItemAppended();

    //signals for messages
    void showErrorMessage();
    void showAccessMessage();
    void showDoneMessage(); // before addmarker
    void showSynchroMessage();
    void showInternetProblemMessage(); // test
    void showAccountError();
    void showAccountProofMessage();


public slots:
    void appendItem();
    void removeCompletedItems();


    //server slots
    void addNewMarker(QGeoCoordinate geo, int danger_, QString description_, QString login); // переделать под сервер
    void synchroWithServer(); //done
    void addNewUser(const QString login, const QString password); // отправляет данные и если они подтверждаются, то сохраняет их на в qrc
    void proveUser(QString log_, QString pass_); // читает qrc файл и смотрит данные (в начале работы программы)


private:
    QVector<ToDoItem> mItems;
    MyClient* m_client;

    bool userHaveAccount = false;
    QString m_userLogBuffer;
    QString m_userPassBuffer;

private:
//    void addUserToQrc(const QString login, const QString password);
    void addThisUserToBuffer();


private:

    void setNewData(); // add jsondoc
};

#endif // TODOLIST_H
