import QtQuick 2.4

RegistrationForm {
    buttonNewUser.onClicked: {
        //void addNewUser(const QString login, const QString password);
        toDoList.addNewUser(loginUser.text, pass.text);
        userlogin = loginUser.text;
        userpassword = pass.text;
}
    buttonOldUser.onClicked: {
        stackView.push("Login.qml")
}
}
