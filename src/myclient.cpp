#include "myclient.h"

MyClient::MyClient(const QString& strHost, int nPort, QObject* parent ) : QObject(parent)
{
    m_nNextBlockSize = 0;
    m_pTcpSocket = new QTcpSocket(this);

    m_pTcpSocket->connectToHost(strHost, nPort);
    connect(m_pTcpSocket, SIGNAL(connected()), SLOT(slotConnected()));
    connect(m_pTcpSocket, SIGNAL(readyRead()), SLOT(slotReadyRead()));
    connect(m_pTcpSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this,         SLOT(slotError(QAbstractSocket::SocketError))
           );

}

void MyClient::sendMessageToServer(const QString &str)
{

    QByteArray  arrBlock;
    QDataStream out(&arrBlock, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_2);

    out << quint16(0) << QTime::currentTime() << str;

    out.device()->seek(0);
    out << quint16(arrBlock.size() - sizeof(quint16));

    m_pTcpSocket->write(arrBlock);

}

void MyClient::sendUserDataToServer(const QString &login, const QString &password)
{

    QJsonObject data;
    QJsonDocument document;
    QString message("CreateUserData");
    data.insert("login", login);
    data.insert("password", password);
    document.setObject(data);


    QByteArray  arrBlock;
    QDataStream out(&arrBlock, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_2);

    out << quint16(0) << QTime::currentTime() << message << document.toJson();

    out.device()->seek(0);
    out << quint16(arrBlock.size() - sizeof(quint16));

// можно запилить какой-то сигнал и слот, дабы подобные сообщения пушапом отправлялись на ui

    m_pTcpSocket->write(arrBlock);

//    QFile p("C:/example/ser.json");
//    p.open(QFile::WriteOnly);
//    p.write(document.toJson());

}

void MyClient::sendProveUserDataToServer(const QString &login, const QString &password)
{

    QJsonObject data;
    QJsonDocument document;
    QString message("ProveUserData");
    data.insert("login", login);
    data.insert("password", password);
    document.setObject(data);


    QByteArray  arrBlock;
    QDataStream out(&arrBlock, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_2);

    out << quint16(0) << QTime::currentTime() << message << document.toJson();

    out.device()->seek(0);
    out << quint16(arrBlock.size() - sizeof(quint16));

    // можно запилить какой-то сигнал и слот, дабы подобные сообщения пушапом отправлялись на ui // типа готово

    m_pTcpSocket->write(arrBlock);
}

void MyClient::sendNewMarkerToServer(const double latitude, const double longitude, const QString &userLogin, const QString &description, const int danger)
{
    QJsonObject data;
    QJsonDocument document;
    QString message("ClentSendMarker");
    data.insert("latitude", latitude);
    data.insert("longitude", longitude);
    data.insert("userLogin", userLogin);
    data.insert("description", description);
    data.insert("danger", danger);
    document.setObject(data);


    QByteArray  arrBlock;
    QDataStream out(&arrBlock, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_2);

    out << quint16(0) << QTime::currentTime() << message << document.toJson();

    out.device()->seek(0);
    out << quint16(arrBlock.size() - sizeof(quint16));

    m_pTcpSocket->write(arrBlock);
}

void MyClient::slotReadyRead()
{
    QDataStream in(m_pTcpSocket);
    in.setVersion(QDataStream::Qt_4_2);
    for (;;) {
        if (!m_nNextBlockSize) {
            if (m_pTcpSocket->bytesAvailable() < sizeof(quint16)) {
                break;
            }
            in >> m_nNextBlockSize;
        }

        if (m_pTcpSocket->bytesAvailable() < m_nNextBlockSize) {
            break;
        }

        QTime   time;
        QString str;

        in >> time >> str;

        if(str == "SynchronizeResponse"){ // reconstruct for switch
            QJsonDocument qjd; // and another operations
            QByteArray a;

            in >> a;

            JBase = qjd.fromJson(a);

            emit serverSendNewData();

           qDebug() << time.toString() << str << "i get json";

            m_nNextBlockSize = 0;
        }
        else if(str == "UserHasAdded"){

            // emit signal for give a pass
            emit serverHasAddedThisUser();
            qDebug() << str;
            m_nNextBlockSize = 0;

        }
        else if(str == "UserIsntFind"){

            // emit to re-create account or re-sign
            emit serverUserIsntFind();
            qDebug() << str;
            m_nNextBlockSize = 0;
        }

        else if(str == "UserHasAlready"){ // зочем и для чего повторение. В таблице ничего не написано про это.

            emit serverUserHasAlready();
            qDebug() << str;
            m_nNextBlockSize = 0;
        }

        else{
           qDebug() << time.toString() << str;
            m_nNextBlockSize = 0;

        }

    }
}

void MyClient::slotError(QAbstractSocket::SocketError err)
{
    QString strError =
        "Error: " + (err == QAbstractSocket::HostNotFoundError ?
                     "The host was not found." :
                     err == QAbstractSocket::RemoteHostClosedError ?
                     "The remote host is closed." :
                     err == QAbstractSocket::ConnectionRefusedError ?
                     "The connection was refused." :
                     QString(m_pTcpSocket->errorString())
                    );
    qDebug() << strError;
}


void MyClient::slotSendToServer()
{

    QByteArray  arrBlock;
    QDataStream out(&arrBlock, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_2);

//    if(m_ptxtInput->text() == "do"){
//        sendMessageToServer("Hello");
//    }

    //out << quint16(0) << QTime::currentTime() << m_ptxtInput->text();



    out.device()->seek(0);
    out << quint16(arrBlock.size() - sizeof(quint16));

    m_pTcpSocket->write(arrBlock);
}


void MyClient::slotConnected()
{
   qDebug() << "Received the connected() signal";
}
