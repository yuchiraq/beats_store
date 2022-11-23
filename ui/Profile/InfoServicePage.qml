import QtQuick 2.15
import QtQuick.Controls.Material

Page {
    id: infoService

    background: darkest

    Column {

        anchors.fill: parent
        anchors.topMargin: 60

        spacing: blockMargin

        Text {
            anchors.left: parent.left
            anchors.leftMargin: blockMargin * 3

            font.family: appFont
            font.bold: true

            horizontalAlignment: Text.AlignLeft

            text: "О нас"

            font.pointSize: 20

            color: secondary
        }

        Label {
            font.family: appFont
            anchors.left: parent.left
            anchors.leftMargin: blockMargin
        //    anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignLeft
            width: parent.width - blockMargin * 2
            wrapMode: Label.Wrap
            text: "OGBeats – сервис для приобретения лицензионной музыки. Оцени бит, "
                  + "послушай его и приобрети лицензию с документами, юридически подтверждающими "
                  + "твои права на использование музыки."

            color: secondary
        }
    }

}
