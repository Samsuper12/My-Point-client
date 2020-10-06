import QtQuick 2.4
import QtQuick.Controls 2.5

Page {

    Label {

        y: 83
        width: parent.width/1.3

        height: 162
        color: "#262b2a"
        anchors.horizontalCenter: parent.horizontalCenter

        text: "В текущей версии нет кабинета, но как видите, форма есть. В следующей версии будет много интересного, в том числе личный кабинет с подробной статистикой."
        font.pointSize: 9
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
