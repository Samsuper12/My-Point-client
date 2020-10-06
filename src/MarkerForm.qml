import QtQuick 2.4
import QtQuick.Controls 2.3
Page {
 anchors.fill: parent
 ScrollView{
    anchors.fill: parent


 SwipeView{
    id:slider
    anchors.top: parent.top
    anchors.topMargin: verticalMargin
   // height: parent.height/1.7
    //width: height
    height: parent.height/1.7
    width: parent.width
    x:(parent.width-width)/2//make item horizontally center
    property var model :ListModel{}
    clip:true

    Repeater {
        model:slider.model
        Image{
           width: slider.width
           height: slider.height
           source:image
           //fillMode: Image.Stretch
           fillMode: Image.PreserveAspectFit
        }
    }
 }

// Button{
//     anchors.left: parent.left
//     anchors.bottom: parent.bottom
//     onClicked: {
//         SwipeView.pop
//     }
// }

 //https://doc.qt.io/qt-5/qml-qtquick-item.html#anchors.verticalCenter-prop

 PageIndicator {
    anchors.top: slider.bottom
    anchors.topMargin: verticalMargin
    x:(parent.width-width)/2
    currentIndex: slider.currentIndex
    count: slider.count
 }

 Button{
     id: btnZA
     anchors.left: parent.left;
     anchors.top: slider.bottom
     text: "ЗА";
 }

 Button{
     id: btnPRO
     anchors.right: parent.right;
     anchors.top: slider.bottom
     text: "ПРОТИВ";
 }

 Label{
     anchors.top: btnPRO.bottom
     width: parent.width
     font.pixelSize: 15
     text: markerText;


 }





    Component.onCompleted: {
        slider.model.append({image:"qrc:/ico/motherrussia.jpg"})

        slider.model.append({image:"http://www.chaspik.spb.ru/wp-content/uploads/2012/12/dnepr_05.jpg"})

        slider.model.append({image:"http://mtdata.ru/u31/photoABAB/20200748271-0/huge.jpeg"})

        slider.model.append({image:"http://scontent-ort2-1.cdninstagram.com/vp/75e994e8f11e1dbd68ed2ab808df041c/5D3B1ABF/t51.2885-15/e35/56321900_113585883169253_3371324664714600625_n.jpg?_nc_ht=scontent-ort2-1.cdninstagram.com"})

        slider.model.append({image:"http://s016.radikal.ru/i335/1706/50/44b8ba4925a9.jpg"})
    }

    }
 }












/* that code now unnecessary
    ListModel {
            id: model
            ListElement {
                name:'abc'
                number:'123'
                Серьезность: "легкая"

            }
            ListElement {
                name:'efg'
                number:'456'
                Серьезность: "нормальная"

            }
            ListElement {
                name:'xyz'
                number:'789'
                Серьезность: "опасно"

            }
        }


    ScrollView {
        anchors.fill: parent
    ListView {
            id: list
            anchors.fill: parent
            model: model
            delegate: Component {
                Item {
                    width: parent.width
                    height: 40
                    Column {
                        Text { text: 'Name:' + name }
                       // Text { text: 'Number:' + number }
                        Text { text: 'Серьезность:' + Серьезность }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: list.currentIndex = index
                    }
                }
            }
            highlight: Rectangle {
                color: 'grey'
                Text {
                    anchors.centerIn: parent
                    text: 'Hello ' + model.get(list.currentIndex).name
                    color: 'white'
                }
            }
            focus: true
            onCurrentItemChanged: console.log(model.get(list.currentIndex).name + ' selected')
        }
    }
    */

