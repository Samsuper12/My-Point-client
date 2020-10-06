import QtQuick 2.12
import QtQuick.Controls 2.5

Page {

    Label{

        y: 83
        width: parent.width/1.3

        height: 162
        color: "#262b2a"
        anchors.horizontalCenter: parent.horizontalCenter


        text: "Добро пожаловать в My Ukraine. Украина - это самая большая, самая плодовитая страна в Европе, но этого мало.
Гражданский долг каждого из нас - это построение такого будущего, которое не стыдно предоставить потомкам. Благодаря этому приложению
каждый из Вас сможет сделать вклад в благополучие страны. Вклад можно сделать лайком, дабы чиновники обратили внимание на проблему,
либо Вы сами можете создать метку на проблемном месте. Вам уже доступен просмотр меток, лишь откройте боковую панель и перейдите в пункт 'Карта'.
Для создания меток придется пройти простую регистрацию."
        font.pointSize: 9
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere

    }

}
