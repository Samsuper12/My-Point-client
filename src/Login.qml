import QtQuick 2.4

LoginForm {
    button1.onClicked: {
         stackView.push("Registration.qml")
}
    button.onClicked: {
        toDoList.proveUser(log.text, pass.text);
        userlogin = log.text;
        userpassword = pass.text;
}

    //toDoList.proveUser(JS.dbGetLog(), JS.dbGetPass());
    //userlogin
    //userpassword
}
