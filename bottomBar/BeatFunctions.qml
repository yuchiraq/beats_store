import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

import "../cards"

Rectangle {
    id: beatFunctions
    anchors.fill: parent
    color: "transparent"

    property int id: 0
    property string title: ""
    property string author: ""
    property string album: ""
    property string time: ""
    property string bpm: ""
    property string tags: ""

    visible: false

    MouseArea {
        anchors.fill: parent
        onClicked: {
            stackMaskedBackground.visible = false
            parent.visible = false
        }
    }

    Rectangle {
        id: beatFunctionsBlock

        width: mainScreen.width - blockMargin
        height: parent.height * 0.5

        //height: 0
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        radius: blockMargin * 2

        color: surface

        border.width: 0.5
        border.color: outline

        MouseArea {
            anchors.fill: parent
            signal sgSwipeLeft
            signal sgSwipeRight
            signal sgSwipeDown
            signal sgSwipeUp

            QtObject {

                property bool pTracing: false
                property real pXVelocity: 0.0
                property real pYVelocity: 0.0
                property int pXPrev: 0
                property int pYPrev: 0

                id: oPrivate
            }

            id: oRoot
            preventStealing: true

            onPressed: {

                oPrivate.pTracing = true
                oPrivate.pXVelocity = 0
                oPrivate.pYVelocity = 0
                oPrivate.pXPrev = mouse.x
                oPrivate.pYPrev = mouse.y
            }

            onPositionChanged: {

                if (!oPrivate.pTracing)
                    return

                var oCurrentXVelocity = (mouse.x - oPrivate.pXPrev)
                oPrivate.pXVelocity = (oPrivate.pXVelocity + oCurrentXVelocity) / 2.0
                oPrivate.pXPrev = mouse.x

                var oCurrentYVelocity = (mouse.y - oPrivate.pYPrev)
                oPrivate.pYVelocity = (oPrivate.pXVelocity + oCurrentYVelocity) / 2.0
                oPrivate.pYPrev = mouse.y

                if (oPrivate.pXVelocity > 15 && mouse.x > parent.width * 0.2) {
                    oPrivate.pTracing = false
                    oRoot.sgSwipeRight()
                } else if (oPrivate.pXVelocity < -15
                           && mouse.x > parent.width * 0.2) {
                    oPrivate.pTracing = false
                    oRoot.sgSwipeLeft()
                } else if (oPrivate.pYVelocity > 2
                           && mouse.y > parent.height * 0.2) {
                    oPrivate.pTracing = false
                    oRoot.sgSwipeDown()
                } else if (oPrivate.pYVelocity < -15
                           && mouse.y < parent.height * 0.2) {
                    oPrivate.pTracing = false
                    oRoot.sgSwipeUp()
                }
            }

            onClicked: console.log("onClicked")
            onPressAndHold: console.log("onPressAndHold")
            onSgSwipeLeft: console.log("onSgSwipeLeft")
            onSgSwipeDown: {
                stackMaskedBackground.visible = false
                beatFunctions.visible = false
                console.log("onSgSwipeDown")
            }
            onSgSwipeRight: console.log("onSgSwipeRight")
            onSgSwipeUp: console.log("onSgSwipeUp")
            onReleased: console.log("onReleased")
        }

        Rectangle {
            id: functionsMaskSource
            width: parent.width
            //height: parent.height * 3 / 4
            anchors {
                top: functionsHeaderTimeBPM.bottom
                topMargin: blockMargin * 1.5
                bottom: parent.bottom
                bottomMargin: blockMargin / 2
                horizontalCenter: parent.horizontalCenter
            }

            //radius: parent.radius
            //color: parent.color
            color: surface

            Flickable {

                anchors.fill: functionsMaskSource
                clip: true

                contentHeight: tester.height * 20

                Column {
                    anchors.fill: parent

                    //BeatFunctions
                    BeatLine {
                        id: tester
                    }

                    Rectangle {
                        width: parent.width - blockMargin * 2
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
                            //font.family: appFont
                            text: "Информация о покупках"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: infoBuyImg.right
                            anchors.leftMargin: blockMargin * 2
                            color: secondary
                        }

                        Image {
                            source: "qrc:/ui_icons/basic/angle-small-right.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: blockMargin * 2

                            height: parent.height / 3
                            width: height

                            ColorOverlay {
                                source: parent
                                color: alert
                                anchors.fill: parent
                            }
                        }

                        onClicked: {
                            leftScreen.push("qrc:/ui/Profile/InfoBuyPage.qml")
                        }
                    }

                    Rectangle {
                        width: parent.width - blockMargin * 2
                        height: 0.5
                        color: outline
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {
                        width: parent.width
                        height: blockMargin * 5

                        Text {
                            //font.family: appFont
                            text: "Удалить трек"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: blockMargin * 2
                            color: alert
                            font.pointSize: blockMargin * 2
                        }

                        Image {
                            source: "qrc:/ui_icons/basic/angle-small-right.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: blockMargin * 2

                            height: parent.height / 3
                            width: height

                            ColorOverlay {
                                source: parent
                                color: alert
                                anchors.fill: parent
                            }
                        }

                        background: Rectangle {
                            anchors.fill: parent
                            color: surface
                        }
                        onClicked: {
                            //                            if(musicPlayer.titlePlayer == title)
                            //                                musicPlayer.visible = false
                            database.removeRecord(id)
                            beatFunctions.visible = false
                            centralScreen.update()
                            randomBeatsModel.updateModel(0)
                        }
                    }
                }
            }
        }

        Rectangle {
            id: functionsHeader

            anchors.fill: parent
            radius: parent.radius
            //color: parent.color
            color: surface
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

        ListView {
            id: dataModel

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: topLineFunctions.bottom

            //anchors.topMargin: blockMargin
            model: functionsModel

            delegate: Item {
                anchors.fill: parent

                Text {
                    id: functionsHeaderTitle
                    text: Title

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.top
                    }

                    font.pointSize: blockMargin * 2

                    font.family: appFont
                    font.bold: true
                    color: accent
                }
                Text {

                    id: functionsHeaderAuthorAlbum
                    text: Album + " • " + Author

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: functionsHeaderTitle.bottom
                    }

                    font.pointSize: blockMargin

                    font.family: appFont
                    color: secondary
                }

                Text {
                    id: functionsHeaderTimeBPM
                    text: TimeSec + " • " + BPM + "bpm"

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: functionsHeaderAuthorAlbum.bottom
                    }

                    font.pointSize: blockMargin

                    font.family: appFont
                    color: secondary
                }
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

        Rectangle {
            color: outline
            width: parent.width
            height: 0.5
            anchors.bottom: functionsMaskSource.top
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Rectangle {
            id: topLineFunctions

            width: 40
            height: 4

            color: accent

            radius: 2

            anchors {
                top: parent.top
                topMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

    function starter() {
        stackMaskedBackground.visible = true
        beatFunctions.visible = true

        functionsModel.updateModel(id)
        //beatFunctionsOpen.running = true
    }
}
