import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

Rectangle {
    id: albumMiniCard

    height: blockMargin * 15
    width: height
    radius: blockMargin
    border.color: outline

    color: dark

    border.width: 1

    property string cover: ""
    property string title: "Album"
    property string style: "Style"
    property string author: "Author"

    clip: true

    Image {
        id: albumMiniCardCover
        source: albumMiniCard.cover

        anchors.fill: parent

        visible: false
    }

        OpacityMask {
            anchors.fill: parent
            source: albumMiniCardCover
            maskSource: parent
        }
    BusyIndicator {
        running: albumMiniCardCover.status === Image.Loading
        anchors.centerIn: albumMiniCardCover
    }

    Item {
        id: albumMiniCardData

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: blockMargin / 2
        }

        height: albumMiniCardAuthor.height + albumMiniCardTitle.height + albumMiniCardStyle.height

        DropShadow {
            anchors.fill: albumMiniCardTitle
            transparentBorder: true
            horizontalOffset: 2
            verticalOffset: 2
            radius: 4.0
            color: "#a0000000"
            source: albumMiniCardTitle
        }

        Text {
            id: albumMiniCardTitle

            color: "white"

            //wrapMode: Label.WrapAnywhere
            font.family: appFont
            font.pointSize: 15
            text: "<strong>" + albumMiniCard.title + "</strong>"
            elide: Text.ElideRight
        }

        DropShadow {
            anchors.fill: albumMiniCardAuthor
            transparentBorder: true
            horizontalOffset: 2
            verticalOffset: 2
            radius: 4
            color: "#a0000000"
            source: albumMiniCardAuthor
        }

        Text {
            id: albumMiniCardAuthor
            text: albumMiniCard.author
            elide: Text.ElideRight

            font.family: appFont

            color: secondary

            anchors.top: albumMiniCardTitle.bottom

            font.pointSize: albumMiniCardTitle.font.pointSize * 0.8
        }

        DropShadow {
            anchors.fill: albumMiniCardStyle
            transparentBorder: true
            horizontalOffset: 2
            verticalOffset: 2
            radius: 4.0
            color: "#a0000000"
            source: albumMiniCardStyle
        }

        Text {
            id: albumMiniCardStyle

            text: albumMiniCard.style
            elide: Text.ElideRight

            font.family: appFont

            color: secondary

            anchors.top: albumMiniCardAuthor.bottom

            font.pointSize: albumMiniCardTitle.font.pointSize * 0.8
        }
    }

    Rectangle {
        id: likeAlbumOverlay

        color: dark

        anchors.fill: parent
        radius: parent.radius

        opacity: 0
    }

    Image {
        id: likeAlbumImg

        source: "qrc:/ui_icons/solid/heart.svg"

        anchors.centerIn: albumMiniCardCover

        width: likeMin
        height: width

        opacity: 1

        visible: false
    }

    DropShadow {
        id: likeAlbumImgShadow
        anchors.fill: likeAlbumImg
        source: likeAlbumImg
        transparentBorder: true
        horizontalOffset: 0
        verticalOffset: 0
        radius: 12.0
        color: "#f0000000"
        opacity: 0
    }

    function singleClick() {
        albumPage.album_cover = cover
        albumPage.album_title = title
        albumPage.album_author = author
        if (bottomBar.active == 1) {
            leftScreen.push(albumPage)
        } else if (bottomBar.active == 2) {
            centralScreen.push(albumPage)
        } //else if (bottomBar.active == 3) {
        //leftScreen.push("qrc:/ui/Pages/AlbumPage.qml")
        //}
        topBar.backSwitch()
    }

    function doubleClick() {
        likeAlbum.running = true
    }

    MouseArea {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        Timer {
            id: timer
            interval: 250
            onTriggered: singleClick()
        }

        onDoubleClicked: likeAlbum.running = true

        onClicked: {
            //            if (timer.running) {
            //                doubleClick()
            //                timer.stop()
            //            } else {
            //                timer.restart()
            //            }
            singleClick()
        }
    }

    property int likeMin: albumMiniCardCover.height * 0.3
    property int likeMax: albumMiniCardCover.height * 0.5
    property int timeAnimation: 300

    SequentialAnimation {
        id: likeAlbum
        onStarted: likeAlbumImg.visible = true
        ParallelAnimation {

            NumberAnimation {
                target: likeAlbumImgShadow
                property: "opacity"
                duration: timeAnimation
                from: 0
                to: 1
            }

            NumberAnimation {
                target: likeAlbumImg
                property: "width"
                duration: timeAnimation
                from: likeMin
                to: likeMax
            }
        }

        ParallelAnimation {

            NumberAnimation {
                target: likeAlbumImgShadow
                property: "opacity"
                duration: timeAnimation
                from: 1
                to: 0
            }

            NumberAnimation {
                target: likeAlbumImg
                property: "width"
                duration: timeAnimation
                from: likeMax
                to: likeMin
            }
        }
        onFinished: likeAlbumImg.visible = false
        running: false
    }

    //    SequentialAnimation {
    //        id: likeAlbum

    //        NumberAnimation {
    //            target: likeAlbumOverlay
    //            property: "opacity"
    //            duration: timeAnimation / 2
    //            from: 0
    //            to: 0.3
    //        }

    //        NumberAnimation {
    //            target: likeAlbumImg
    //            property: "opacity"
    //            duration: timeAnimation
    //            from: 0
    //            to: 1
    //        }

    //        NumberAnimation {
    //            target: likeAlbumImg
    //            property: "width"
    //            duration: timeAnimation
    //            from: likeMin
    //            to: likeMax
    //        }

    //        NumberAnimation {
    //            target: likeAlbumImg
    //            property: "width"
    //            duration: timeAnimation
    //            from: likeMax
    //            to: likeMin
    //        }

    //        NumberAnimation {
    //            target: likeAlbumImg
    //            property: "opacity"
    //            duration: timeAnimation
    //            from: 1
    //            to: 0
    //        }

    //        NumberAnimation {
    //            target: likeAlbumOverlay
    //            property: "opacity"
    //            duration: timeAnimation / 2
    //            from: 0.3
    //            to: 0
    //        }

    //        running: false
    //    }
}
