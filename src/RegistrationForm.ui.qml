import QtQuick 2.4
import QtQuick.Controls 2.5

Page {
    property alias buttonOldUser: buttonOldUser
    property alias buttonNewUser: buttonNewUser
    property alias loginUser: loginUser
    property alias pass: pass
    anchors.fill: parent

    Text {
        id: element
        anchors.horizontalCenter: parent.horizontalCenter
        y: 114
        width: 218
        height: 22
        text: "Заполните поля регистрации"
        font.pixelSize: 16
    }

    TextField{
        id: loginUser
        anchors.horizontalCenter: parent.horizontalCenter
        y: element.y + element.height + 10
        placeholderText: qsTr("Логин")
    }

    TextField{
        id:email
        anchors.horizontalCenter: parent.horizontalCenter
        y: loginUser.y + loginUser.height + 10
        placeholderText: qsTr("Email")
        visible: false;
    }

    TextField{
        id:pass
        anchors.horizontalCenter: parent.horizontalCenter
         y: loginUser.y + loginUser.height + 10
        placeholderText: qsTr("Пароль")
    }

    Button {
        id: buttonNewUser
        anchors.horizontalCenter: parent.horizontalCenter
        y: pass.y + pass.height + 10
        width: pass.width
        text: qsTr("Зарегестрироваться")
    }

    Button {
        id: buttonOldUser
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        //y: pass.y + pass.height + 10
        width: pass.width
        height: 30
        text: qsTr("Есть аккаунт?")
    }



}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
