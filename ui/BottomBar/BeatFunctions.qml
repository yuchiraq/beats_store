import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.15
//import Qt5Compat.GraphicalEffects

import "qrc:/ui/Cards"

Rectangle {
    id: beatFunctions
    anchors.fill: parent
    color: "#00000000"

    property string title: "Beat title"
    property string author: "Author"
    property string album: "Single"
    property string time: "0:00"
    property string bpm: "000"

    visible: false

    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.visible = false
        }
    }


    DropShadow {
        anchors.fill: beatFunctionsBlock
        transparentBorder: true
        horizontalOffset: 0
        verticalOffset: -12
        radius: 12.0
        color: "#40000000"
        source: beatFunctionsBlock
    }


    Rectangle{
        id: beatFunctionsBlock

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



        MouseArea {
            anchors.fill: parent
            signal sgSwipeLeft();
            signal sgSwipeRight();
            signal sgSwipeDown();
            signal sgSwipeUp();

            QtObject {

                property bool pTracing: false;
                property real pXVelocity: 0.0;
                property real pYVelocity: 0.0;
                property int pXPrev: 0;
                property int pYPrev: 0;

                id: oPrivate;
            }

            id: oRoot;
            preventStealing: true;

            onPressed: {

                oPrivate.pTracing = true;
                oPrivate.pXVelocity = 0;
                oPrivate.pYVelocity = 0;
                oPrivate.pXPrev = mouse.x;
                oPrivate.pYPrev = mouse.y;
            }

            onPositionChanged: {

                if (!oPrivate.pTracing) return;

                var oCurrentXVelocity = (mouse.x - oPrivate.pXPrev);
                oPrivate.pXVelocity = (oPrivate.pXVelocity + oCurrentXVelocity) / 2.0;
                oPrivate.pXPrev = mouse.x;

                var oCurrentYVelocity = (mouse.y - oPrivate.pYPrev);
                oPrivate.pYVelocity = (oPrivate.pXVelocity + oCurrentYVelocity) / 2.0;
                oPrivate.pYPrev = mouse.y;

                if (oPrivate.pXVelocity > 15 && mouse.x > parent.width * 0.2) {
                    oPrivate.pTracing = false;
                    oRoot.sgSwipeRight();
                } else if (oPrivate.pXVelocity < -15 && mouse.x > parent.width * 0.2) {
                    oPrivate.pTracing = false;
                    oRoot.sgSwipeLeft();
                } else if (oPrivate.pYVelocity > 2 && mouse.y > parent.height * 0.2) {
                    oPrivate.pTracing = false;
                    oRoot.sgSwipeDown();
                } else if (oPrivate.pYVelocity < -15 && mouse.y < parent.height * 0.2) {
                    oPrivate.pTracing = false;
                    oRoot.sgSwipeUp();
                }
            }

            onClicked: console.log("onClicked");
            onPressAndHold: console.log("onPressAndHold");
            onSgSwipeLeft: console.log("onSgSwipeLeft");
            onSgSwipeDown: {
                beatFunctions.visible = false
                console.log("onSgSwipeDown");
            }
            onSgSwipeRight: console.log("onSgSwipeRight");
            onSgSwipeUp: console.log("onSgSwipeUp");
            onReleased: console.log("onReleased");
        }

        Rectangle {
            id: functionsMaskSource
            width: parent.width -  blockMargin
            height: parent.height * 3/4
            anchors {
                bottom: parent.bottom
                bottomMargin: blockMargin / 2
                horizontalCenter: parent.horizontalCenter
            }

            radius: parent.radius
            //color: parent.color
            color: dark

            Flickable {

                anchors.fill: functionsMaskSource
                clip: true

                contentHeight: tester.height * 20

                Column {
                    anchors.fill: parent

                    //BeatFunctions

                    BeatLine {id: tester}

                    Rectangle {
                        width: parent.width
                        height: 0.5
                        color: outline
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {
                        width: parent.width
                        height: blockMargin * 5

                        background: Rectangle {
                            color: "#00000000"
                        }

                        Image {
                            id: infoBuyImg

                            source: "qrc:/png/interface/file-invoice-dollar.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: blockMargin * 2
                            sourceSize.width: blockMargin * 2.5
                            sourceSize.height: blockMargin * 2.5
                            //fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            font.family: appFont
                            text: "Информация о покупках"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: infoBuyImg.right
                            anchors.leftMargin: blockMargin * 2
                            color: secondary
                        }

                        Image {
                            source: "qrc:/png/interface/next.png"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: blockMargin * 2

                            height: parent.height / 5
                            width: height
                        }

                        onClicked: {
                            leftScreen.push("qrc:/ui/Profile/InfoBuyPage.qml")

                        }
                    }
                }
            }
        }

        DropShadow {
            anchors.fill: functionsMaskSource
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: -6
            radius: 12.0
            color: "#40000000"
            source: functionsMaskSource
        }

        Rectangle {
            id: functionsHeader

            anchors.fill: parent
            radius: parent.radius
            //color: parent.color
            color: darkest
            visible: false

        }

        OpacityMask {
            id: functionsHeaderMasked
            anchors.fill: functionsHeader
            source: functionsHeader
            maskSource: functionsMaskSource
            invert: true
            visible: true
        }

//        DropShadow {
//            anchors.fill: functionsHeaderMasked
//            transparentBorder: true
//            horizontalOffset: 0
//            verticalOffset: 6
//            radius: 8
//            color: "#fff"
//            source: functionsHeaderMasked
//        }

        Text {
            id: functionsHeaderTitle
            text: title

            anchors{
                horizontalCenter: parent.horizontalCenter
                top: topLineFunctions.bottom
                topMargin: blockMargin
            }

            font.pointSize: 25

            font.family: appFont
            font.bold: true
            color: secondary
        }

        Text {
            id: functionsHeaderAuthorAlbum
            text: album + " • " + author

            anchors{
                horizontalCenter: parent.horizontalCenter
                top: functionsHeaderTitle.bottom
            }

            font.pointSize: 10

            font.family: appFont
            color: light
        }

        Text {
            id: functionsHeaderTimeBPM
            text: time + " • " + bpm + "bpm"

            anchors{
                horizontalCenter: parent.horizontalCenter
                top: functionsHeaderAuthorAlbum.bottom
            }

            font.pointSize: 10

            font.family: appFont
            color: light
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


    }



    function starter(){
        beatFunctions.visible = true
        //beatFunctionsOpen.running = true
    }

}
