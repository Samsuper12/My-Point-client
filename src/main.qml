import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.LocalStorage 2.12
import "Database.js" as JS

import ToDo 1.0

ApplicationWindow {
    id: window
    visible: true
   // width: Screen.desktopAvailableWidth
   // height: Screen.desktopAvailableHeight // for telephone
    width : 480
    height: 640
    title: qsTr("Stack")

    property string markerText;
    property int markerDangerous; // values between 0 and 3 (0 - green, 1 - yellow, 2 - red)

    property string userlogin;
    property string userpassword;
    property bool userHaveAccount;

     property bool mapfl: true;
     property int mapind;


    Component.onCompleted: {
       userHaveAccount = false;
       JS.dbInit()

        if(JS.dbGetLog()){
            toDoList.proveUser(JS.dbGetLog(), JS.dbGetPass());
        }
    }

    onClosing: {
            if(stackView.depth > 1){
                close.accepted = false
                stackView.pop();
            }else{
                return;
            }
        }


    ToDoModel {
        id: mynewmodel
         list: toDoList
       }

    ToolTip {
            id: toast
            delay: 500
            timeout: 5000
            x: (parent.width - width) / 2
            y: (parent.height - 100)

            background: Rectangle {
                color: "gray"
                radius: 15
            }
        }

    function showErrorFromQml(message){ // rename that
        toast.text = qsTr(message)
        toast.visible = true
    }

    function instertIntoStorage(ulogin, upassword){

        JS.dbInsert(ulogin, upassword);
    }

    function deleteAllStorageMembers(){

        JS.dbDeleteAll();
    }

    function appendLogPassBuffers(){
        userlogin = JS.dbGetLog();
        userpassword = JS.dbGetPass();
    }

    function replaceStorageData(ulogin, upassword){

        JS.dbUpdate(ulogin, upassword, 1);

    }

    function testBase(){ //only for test

        //toast.text = JS.dbReadAll()
        toast.text = JS.dbGetPass();
        toast.visible = true;
    }

    function dbLog(){
        return JS.dbGetLog()
    }
    function dbPass(){
        return JS.dbGetPass()
    }



    Connections {
            target: toDoList

            onShowErrorMessage:{
                toast.text = qsTr("ErrorToast")
                toast.visible = true
            }

            onShowAccessMessage:{
                toast.text = qsTr("Account has created")
                toast.visible = true
                deleteAllStorageMembers()
                instertIntoStorage(userlogin, userpassword);
                userHaveAccount = true;
                stackView.push("maps.qml");
                //ЗДЕСЬ добавляем юзера в буфер и потом в базу
            }

            onShowAccountError:{
                toast.text = qsTr("Account has not created")
                toast.visible = true
            }
            onShowAccountProofMessage:{
                userlogin = JS.dbGetLog();
                userHaveAccount = true;
                //showErrorFromQml("Work");
                stackView.push("maps.qml");

                // здесь добавляем логин юзера в буфер
            }
    }


    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            //text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.45
        height: window.height

        Column {
            anchors.fill: parent


            ItemDelegate {
                text: qsTr("Главная")
                width: parent.width
                onClicked: {
                    stackView.push("HomeForm.ui.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Карта")
                width: parent.width
                onClicked: {
                    stackView.push("maps.qml")
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr("Личный кабинет")
                width: parent.width
                onClicked: {
                    if(userHaveAccount){
                    stackView.push("MyRoomForm.ui.qml")
                    drawer.close()
                    }
                    else{
                        stackView.push("Registration.qml")
                        showErrorFromQml("Please, sign up or sign in");
                        drawer.close()
                    }
                }
            }
            ItemDelegate {
                text: qsTr("About Us")
                width: parent.width
                onClicked: {
                    stackView.push("AboutUs.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "HomeForm.ui.qml"
        anchors.fill: parent
    }
}
