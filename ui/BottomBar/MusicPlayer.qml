import QtQuick 2.15
import QtQuick.Controls.Material

import "qrc:/"

Rectangle {
    id: musicPlayer

    property string titlePlayer: "Title"
    property string authorPlayer: "Author"

    width: mainScreen.width
    height: 40

    color: darkestTransparency

    visible: false

    anchors {
        bottom: parent.bottom
        bottomMargin: bottomBar.height
        left: parent.left
        right: parent.right
    }

    Text {
        id: musicPlayerMinTitle

        text: titlePlayer

        font.family: appFont

        color: "#FFF"

        anchors {
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
            verticalCenter: parent.verticalCenter
            left: musicPlayerMinTitle.right
            leftMargin: blockMargin
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            if (parent.height === 40) {
                musicPlayerOnMax.running = true
                parent.color = darkest
            }
            else if (parent.height === mainScreen.height - 120) {
                musicPlayerOnMin.running = true
                parent.color = darkestTransparency
            }
        }
    }

    property int timeAnimation: 200

    ParallelAnimation {
        id: musicPlayerOnMax

        running: false

        NumberAnimation {
            target: musicPlayer
            property: "radius"
            duration: timeAnimation
            from: 0
            to: blockMargin * 2
        }

        NumberAnimation {
            target: musicPlayer
            property: "height"
            duration: timeAnimation
            from: 40
            to: mainScreen.height - 120
        }

        NumberAnimation {
            target: musicPlayer
            property: "anchors.bottomMargin"
            duration: timeAnimation
            from: bottomBar.height
            to: 0
        }

    }

    ParallelAnimation {
        id: musicPlayerOnMin

        running: false

        NumberAnimation {
            target: musicPlayer
            property: "radius"
            duration: timeAnimation
            from: blockMargin * 2
            to: 0
        }

        NumberAnimation {
            target: musicPlayer
            property: "height"
            duration: timeAnimation
            from: mainScreen.height - 120
            to: 40
        }

        NumberAnimation {
            target: musicPlayer
            property: "anchors.bottomMargin"
            duration: timeAnimation
            from: 0
            to: bottomBar.height
        }

    }

}
