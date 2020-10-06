import QtQuick 2.12
import QtQuick.Controls 2.5
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.LocalStorage 2.12

import QtQuick.Controls.Styles 1.2

import ToDo 1.0



Page {


    id: mapPage
    //id: stackView
    //anchors.fill: parent
    title: qsTr("Харків")

    //! [Initialize Plugin]
    Plugin {
        id: myPlugin
        name: "esri" // "mapboxgl", "esri", ...
        //specify plugin parameters if necessary
        //PluginParameter {...}
        //PluginParameter {...}
        //...


        //PluginParameter { name: "osm.mapping.custom.host"; value: "My great Qt OSM application" }
    }


    PositionSource {
        id: positionSource
        property variant lastSearchPosition: locationOslo
        active: true
        updateInterval: 100//120000 // 2 mins
        onPositionChanged:  {
            var currentPosition = positionSource.position.coordinate
            console.log("changed")
            map.center = currentPosition
            var distance = currentPosition.distanceTo(lastSearchPosition)
            if (distance > 500) {
                // 500m from last performed pizza search
                lastSearchPosition = currentPosition
                searchModel.searchArea = QtPositioning.circle(currentPosition)
                searchModel.update()
            }
        }
    }



    property variant locationOslo: QtPositioning.coordinate( 50.0, 36.15)

    PlaceSearchModel {
        id: searchModel

        plugin: myPlugin

        searchTerm: "Books"
        searchArea: QtPositioning.circle(locationOslo)

        Component.onCompleted: update()
    }


    Map {
        id: map
        anchors.fill: parent
        plugin: myPlugin;
        center: locationOslo
        zoomLevel: 13


        MapItemView {
            id: miv
            model: mynewmodel

            delegate: MapQuickItem {

                        coordinate: QtPositioning.coordinate(model.latitude, model.longitude)

                         anchorPoint: Qt.point(10,10)

                         sourceItem: Column {
                                        Rectangle {
                                            Image { id: image;
                                                //fillMode: Image.PreserveAspectCrop;
                                                //width: 35
                                                //height: 55

                                                source: markColor(model.danger);

                                            }
                                            //Text {text: model.index}
                                            MouseArea {
                                                anchors.fill: image
                                                onClicked: {

                                                    markerText = model.description;
                                                    markerDangerous = model.danger;
                                                    stackView.push("MarkerForm.qml");

                                                }
                                              }
                                          }

                                        }
                               }

            Rectangle {

                x: mapPage.width -50
                y: map.y

                Image { id: m_addimage; fillMode: Image.PreserveAspectCrop; source: "ico/synchronize.png"; width: 50; height: 50 }
                MouseArea{
                    anchors.fill: m_addimage
                    onClicked: {
                        toDoList.synchroWithServer();
                    }
                }
            }


        }

        Rectangle {

            x: mapPage.width -50
            y: mapPage.height -100


            Image { id: typeMapeimg; fillMode: Image.PreserveAspectCrop; source: "qrc:/ico/type.png"; width: 50; height: 50 }
            MouseArea{
                anchors.fill: typeMapeimg
                onClicked: {
                    if(mapfl){
                        mapfl = false;
                        mapind = 1;
                        map.activeMapType = map.supportedMapTypes[1]

                    }
                    else{
                        mapfl = true;
                        mapind = 3;
                        map.activeMapType = map.supportedMapTypes[3]


                    }
                }
            }
        }

        Rectangle {

            x: mapPage.width -50
            y: mapPage.height -50

            Image { id: m_addimage_; fillMode: Image.PreserveAspectCrop; source: "ico/addnew.png"; width: 50; height: 50 }
            MouseArea{
                anchors.fill: m_addimage_
                onClicked: {
                    if(userHaveAccount){
                        stackView.push("NewMarker.qml")
                    }
                    else{
                        showErrorFromQml("Please, sign up or sign in");
                    }
                }
            }
        }

//        onZoomLevelChanged: {
//                    console.log("minimumZoomLevel : " + minimumZoomLevel + " - current zoomLevel :" + zoomLevel)
//                    console.log("maximumZoomLevel : " + maximumZoomLevel + " - current zoomLevel :" + zoomLevel)
//                }
        Component.onCompleted: {
            toDoList.synchroWithServer();
            map.activeMapType = map.supportedMapTypes[3]
            //map.maximumZoomLevel = 90
            mapind = 3;
            // 1 real map
            // 3 std map

        }

    }

//    GroupBox{
//                   title:"map types"
//                   ComboBox{
//                       model:map.supportedMapTypes
//                       textRole:"description"
//                       onCurrentIndexChanged:map.activeMapType = map.supportedMapTypes[currentIndex]
//                   }
//     }

    function markColor(colorNumber){

        if(colorNumber === 0) return "ico/green.png"
        if(colorNumber === 1) return "ico/yellow.png"
        if(colorNumber === 2) return "ico/red.png"
    }


    Connections {
        target: searchModel
        onStatusChanged: {
            if (searchModel.status == PlaceSearchModel.Error)
                console.log(searchModel.errorString());
        }
    }
}



