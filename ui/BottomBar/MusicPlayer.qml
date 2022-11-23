import QtQuick 2.15
import QtQuick.Controls.Material

import "qrc:/"

Rectangle {
    id: musicPlayerMin

    property string titlePlayer: "Title"
    property string authorPlayer: "Author"

    width: mainScreen.width
    height: 40

    color: darkestTransparency

    visible: false

    anchors {
        bottom: bottomBar.top
        left: parent.left
        right: parent.right
    }

    Text {
        id: musicPlayerMinTitle

        text: titlePlayer

        font.family: appFont

        color: "#FFF"

        anchors {
            //top: musicPlayerMin.top
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: blockMargin * 2
        }
    }

    Text {
        id: musicPlayerMinAuthor

        text: authorPlayer

        font.family: appFont

        color: light

        anchors {
            //top: musicPlayerMin.top
            verticalCenter: parent.verticalCenter
            left: musicPlayerMinTitle.right
            leftMargin: blockMargin * 2
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            if (parent.height === 40) {
                parent.radius = 2 * blockMargin
                parent.height = mainScreen.height - 120
                //parent.bottom = mainScreen.bottom
            }
            else if (parent.height === mainScreen.height - 120) {
                parent.radius = 0
                parent.height = 40
                //parent.bottom = bottomBar.top
            }
        }
    }

}
