#ifndef MYCLIENT_H
#define MYCLIENT_H


#include <QObject>
#include <QTcpSocket>
#include <QTime>
#include <QVector>
#include <QFile>
#include <QTextStream>
#include <QDataStream>
#include <QByteArray>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>


class MyClient : public QObject {

Q_OBJECT

private:
    QTcpSocket* m_pTcpSocket;
    quint16     m_nNextBlockSize;


public:
    MyClient(const QString& strHost, int nPort, QObject* parent = 0) ;

    void sendMessageToServer(const QString& str); // get all markers or another
    void sendUserDataToServer(const QString& login, const QString& password); // тут // это отправление на регистрацию
    void sendProveUserDataToServer(const QString& login, const QString& password);  // и тут переделать. // а это на проверку
    void sendNewMarkerToServer(const double latitude, const double longitude, const QString& userLogin, const QString& description, const int danger);


signals:
    void serverSendNewData();
    void serverHasAddedThisUser();
    void serverUserIsntFind();
    void serverUserHasAlready();


private slots:
    void slotReadyRead   (                            );
    void slotError       (QAbstractSocket::SocketError);
    void slotConnected   (                            );
    void slotSendToServer(                            ); // delete later

public:

    QJsonDocument JBase;




};

#endif // MYCLIENT_H
