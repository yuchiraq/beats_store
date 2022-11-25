import QtQuick 2.15
import QtQuick.Controls.Material

Rectangle{
    id: beatFunctions

    width: mainScreen.width
    height: parent.height * 0.5
    //height: 0

    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    radius: blockMargin * 2

    color: darkest

    visible: false

    MouseArea {
        anchors.fill: parent

        onClicked: {
            parent.visible = false
            //beatFunctionsClose.running = true
        }
    }

    Rectangle {
        id: topLineFunctions

        width: 40
        height: 4

        color: secondary

        radius: 2

        anchors {
            top: parent.top
            topMargin: blockMargin
            horizontalCenter: parent.horizontalCenter
        }



    }

        NumberAnimation {
            id: beatFunctionsOpen

            running: false
            target: parent
            property: "height"
            duration: 100
            from: 0
            to: parent.height * 0.5
        }

        NumberAnimation {
            id: beatFunctionsClose

            running: false
            target: parent
            property: "height"
            duration: 100
            from: height
            to: 0

            onFinished: parent.visible = false
        }

        function starter(){
            beatFunctions.visible = true
            //beatFunctionsOpen.running = true
        }
}
