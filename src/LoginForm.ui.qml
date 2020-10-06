import QtQuick 2.4
import QtQuick.Controls 2.5

Page {
    property alias log: log
    property alias button: button
    property alias pass: pass
    property alias button1: button1
    anchors.fill: parent

    Text {
        id: element
        anchors.horizontalCenter: parent.horizontalCenter
        y: 71
        width: 239
        height: 27
        text: qsTr("Войдите для работы с сервисом")
        font.pixelSize: 16
    }

    TextField{
        id:log
        placeholderText: qsTr("Логин")
        anchors.horizontalCenter: parent.horizontalCenter
        y: element.y+ element.height + 10
    }

    TextField{
        id:pass
        text: ""
        anchors.horizontalCenter: parent.horizontalCenter
        y: log.y+ log.height + 10

        echoMode: TextField.Password
        placeholderText: qsTr("Пароль")
    }

    Button {
        id: button
        anchors.horizontalCenter: parent.horizontalCenter
        y: pass.y+ pass.height + 10
        width: log.width
        height: log.height
        text: qsTr("Войти")
    }

    Button {
        id: button1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        //anchors.bottomMargin: 10
        //y: 448
        width: button
        height: 30
        text: qsTr("Регистрация")
    }
}
