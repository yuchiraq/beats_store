import QtQuick 2.15
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

Rectangle {
    id: beatFunctionsBack
    anchors.fill: parent
    color: "#00000000"

    visible: false

    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.visible = false
        }
    }


    DropShadow {
        anchors.fill: beatFunctions
        transparentBorder: true
        horizontalOffset: 0
        verticalOffset: -12
        radius: 12.0
        color: "#40000000"
        source: beatFunctions
    }


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

        MouseArea {
            anchors.fill: parent
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




    }



    function starter(){
        beatFunctionsBack.visible = true
        //beatFunctionsOpen.running = true
    }

}
