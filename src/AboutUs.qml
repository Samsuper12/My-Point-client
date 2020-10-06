import QtQuick 2.5
import QtQuick.Controls 2.5

Page{

    Label{

        y: 83
       // width: 451
        width: parent.width/1.3
        height: 162
        color: "#262b2a"
        anchors.horizontalCenter: parent.horizontalCenter


        text: "Приложение на данный момент представляет из себя 'сырую' реализацию наших мыслей и желаний, однако, даже данная версия подходит для выполнения поставленной задачи -
мониторинг улиц наших городов. Обещаем, что с каждой новой версией приложение будет более 'зрелым' и удобным. "
        font.pointSize: 9
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere

    }




    Label{

        height: 30
        width: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        text: "Created by Nikita Lebedin && Mishael Skorokhodov"
        font.pointSize: 7
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

    }

}
