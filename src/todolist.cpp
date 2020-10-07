#include "todolist.h"

ToDoList::ToDoList(QObject *parent) : QObject(parent)
{

    m_client = new MyClient("192.168.0.111", 2323);

    m_client->sendMessageToServer("hello from client");

    connect(m_client, &MyClient::serverSendNewData, this, [=]() {setNewData(); emit showSynchroMessage(); });
    connect(m_client, &MyClient::serverHasAddedThisUser, this, [&](){/*userHaveAccount = true;*/ /*addUserToQrc(this->m_userLogBuffer, this->m_userPassBuffer);*/ showAccessMessage();});

    connect(m_client, &MyClient::serverUserHasAlready, this, [&](){/*userHaveAccount = true;*/ /*addThisUserToBuffer();*/ emit showAccountProofMessage();}); //
    connect(m_client, &MyClient::serverUserIsntFind, this, [&](){/*userHaveAccount = false;*/ emit showErrorMessage(); }); //добавить слот и сигнал в форме, что такой юзер не найден

}

QVector<ToDoItem> ToDoList::items() const
{
    return mItems;
}

bool ToDoList::setItemAt(int index, const ToDoItem &item)
{
    if (index < 0 || index >= mItems.size())
        return false;

    const ToDoItem &oldItem = mItems.at(index);
//    if (item.done == oldItem.done && item.description == oldItem.description)
//        return false;

    mItems[index] = item;
    return true;
}

void ToDoList::appendItem()
{
    emit preItemAppended();

    ToDoItem item;
    //item.done = false;
    mItems.append(item);

    emit postItemAppended();
}

void ToDoList::removeCompletedItems()
{
//    for (int i = 0; i < mItems.size(); ) {
//        if (mItems.at(i).done) {
//            emit preItemRemoved(i);

//            mItems.removeAt(i);

//            emit postItemRemoved();
//        } else {
//            ++i;
//        }
//    }
}

void ToDoList::addNewMarker(QGeoCoordinate geo, int danger_, QString description_, QString login)
{

   m_client->sendNewMarkerToServer(geo.latitude(),geo.longitude(), login, description_, danger_);

    //after this code in form has created the signal about sychro with server
}

void ToDoList::synchroWithServer()
{
    m_client->sendMessageToServer("Synchronize");
}

void ToDoList::addNewUser(const QString login, const QString password)
{
    qDebug() << "from addNewUser" << login << " " << password;
    m_userLogBuffer = login;
    m_userPassBuffer = password;

    m_client->sendUserDataToServer(login, password);
}


void ToDoList::proveUser(QString log_, QString pass_)
{
    m_client->sendProveUserDataToServer(log_, pass_);
}

//void ToDoList::addUserToQrc(const QString login, const QString password)
//{

//    QFile file("qrc:/data/userInfo.json");
//    QJsonDocument qjdoc;
//    QJsonObject qjob;

//    qjob.insert("login", login);
//    qjob.insert("password", password);
//    qjdoc.setObject(qjob);

//    if(file.open(QFile::WriteOnly)){
//        file.write(qjdoc.toJson());
//    }
//    else{
//        qDebug() << "WtiteError";
//    }

//}

void ToDoList::addThisUserToBuffer()
{
    QFile file(":/data/userInfo.json");
    QJsonDocument qjdoc;
    QJsonObject qjob;

    if(file.open(QFile::ReadOnly)){
        qjdoc = qjdoc.fromJson(file.readAll());

        qjob = qjdoc.object();
        m_userLogBuffer = qjob.take("login").toString();
    }
    else{
        qDebug() << "Error in addThisUserToBuffer";
    }
}

void ToDoList::setNewData()
{
    QJsonDocument bufdoc; // = m_client->JBase;
    bufdoc.swap(m_client->JBase);
    QJsonArray bufarrey;
    QVector<ToDoItem> bufvec;

    bufarrey = bufdoc.array();

    qDebug() << "data it todolist";
    for(int i =0; i < bufarrey.count(); ++i){
      bufvec.append({ (float)bufarrey.at(i)["latitude"].toDouble(), (float)bufarrey.at(i)["longitude"].toDouble(),
                       bufarrey.at(i)["username"].toString(), bufarrey.at(i)["description"].toString(),
                       bufarrey.at(i)["danger"].toInt()});
    }

    qDebug() << mItems.size() << "befire";
    qDebug() << bufvec.size() << "before";


    if(mItems.size()){
        for(int i = mItems.size()-1; i >= 0; --i){
            emit preItemRemoved(i);
            mItems.removeAt(i);
            emit postItemRemoved();
        }
    }

    mItems = std::move(bufvec);

    emit preAllItemAppended();
    emit postAllItemAppended();


    qDebug() << mItems.size() << "after";
    qDebug() << bufvec.size() << "after";

}
