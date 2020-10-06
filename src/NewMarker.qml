import QtQuick 2.10
import QtQuick.Controls 2.5
import QtLocation 5.6
import QtPositioning 5.6

import QtQuick.Controls.Styles 1.4

NewMarkerForm {

    property variant locationMark: QtPositioning.coordinate( 50.0, 36.15)


    Plugin {
        id: myPluginMark
        name: "esri" // "mapboxgl", "esri", ...
        //specify plugin parameters if necessary
        //PluginParameter {...}
        //PluginParameter {...}
        //...
    }

    PlaceSearchModel {
        id: searchModelMark

        plugin: myPluginMark

        searchTerm: "Books"
        searchArea: QtPositioning.circle(locationMark)

        Component.onCompleted: update()
    }

    Map {
        id: nmap
        //anchors.fill: parent
        //anchors.top: parent.top
        //anchors.topMargin: verticalMargin

        height: parent.height/2.4
        width: parent.width

        plugin: myPluginMark;
        center: locationMark
        zoomLevel: 13

        onCenterChanged: {
           //database.mygeo(nmap.center)

        }

        Component.onCompleted: {
            nmap.activeMapType = nmap.supportedMapTypes[mapind]

        }

    }

    ComboBox {
        id: comboxMark
        width: parent.width

        y: nmap.height


        model: [ "Низкая опасность", "Средняя опасность", "Высокая опасность" ]

    }

    Rectangle {
        Image { id: image; /*fillMode: Image.PreserveAspectCrop*/ source: "marker.png";  }
        x: nmap.width/2
        y: nmap.height/2
      }


    TextArea{
        id: taMark
        width: parent.width
        height: 100

        //text: "Введите комментарий к проблеме"
        // use textfield for a password
        //var b = positionSourceMark.position.coordinate
        //text: b

        y: comboxMark.y + comboxMark.height +10

        placeholderText: qsTr("Enter description")

    }


    Button{
        id: addmarkbutt

        anchors.bottom: parent.bottom
        width: parent.width

        text: "Добавить новую метку"

        onClicked: {

            toDoList.addNewMarker(nmap.center, comboxMark.currentIndex, taMark.text, userlogin ); //QGeoCoordinate geo, int danger_, QString description_, QString login
            toDoList.synchroWithServer();

            stackView.pop()

        }
    }



}
