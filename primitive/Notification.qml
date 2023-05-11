import QtQuick 2.15

Rectangle {
    id: notification

    property string notificationText: "Empty notification"

    color: darkest

    anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: 0
    }

    clip: true

    radius: height / 2

    Text {
        id: textNotification

        anchors.centerIn: parent

        font {
            family: appFont
            pointSize: blockMargin
        }

        color: accent

        text: notificationText
    }

    width: textNotification.width + blockMargin * 3
    height: blockMargin * 3

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
        onFinished: notificationOff.running = true
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
}
