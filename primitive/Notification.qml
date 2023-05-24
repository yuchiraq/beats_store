import QtQuick 2.15
import QtQuick.Controls.Material

Rectangle {
    id: notification

    property string notificationText: "Empty notification"

    color: surface

    anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: 0
    }

    clip: true

    radius: blockMargin * 1.5

    width: textNotification.width + blockMargin * 3
    height: blockMargin * 3

    Label {
        id: textNotification

        anchors.centerIn: parent

        font {
            family: appFont
            pointSize: blockMargin
        }

        wrapMode: Label.Wrap

        color: accent

        text: notificationText
    }

    visible: false

    SequentialAnimation {
        id: notificationOn

        ParallelAnimation {

            NumberAnimation {
                target: notification
                property: "width"
                easing.type: Easing.InOutQuad
                from: 0
                to: textNotification.width + blockMargin * 3
            }

            NumberAnimation {
                target: notification
                property: "height"
                from: 0
                to: blockMargin * 3
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: notification
                property: "anchors.topMargin"
                from: 0
                to: blockMargin
                easing.type: Easing.InOutQuad
            }
        }

        NumberAnimation {
            duration: 1000
        }

        onStarted: notification.visible = true

        running: false
        onFinished: {
            if (!mouseArea.pressed)
                notificationOff.running = true
        }
    }

    ParallelAnimation {
        id: notificationOff

        NumberAnimation {
            target: notification
            property: "width"
            easing.type: Easing.InOutQuad
            from: notification.width
            to: 0
        }

        NumberAnimation {
            target: notification
            property: "height"
            from: notification.height
            to: 0
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: parent
            property: "anchors.topMargin"
            from: blockMargin
            to: 0
            easing.type: Easing.InOutQuad
        }

        running: false

        onFinished: notification.visible = false
    }

    function start() {
        notificationOn.running = true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onReleased: {
            if (!notificationOn.running)
                notificationOff.start()
        }
    }
}
