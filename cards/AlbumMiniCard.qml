import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

Rectangle {
    id: albumMiniCard

    height: blockMargin * 20
    width: blockMargin * 15
    radius: blockMargin
    border.color: outline

    color: container

    border.width: 0.5

    property string cover: ""
    property string title: ""
    property string style: ""
    property string author: ""

    clip: true

    DropShadow {
        anchors.fill: coverMask
        verticalOffset: blockMargin / 2
        radius: 8
        color: surface
        source: coverMask
        transparentBorder: true

        visible: false
    }

    Rectangle {
        id: coverMask
        color: outline
        width: parent.width
        height: width

        radius: parent.radius

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }

        clip: true

        Image {
            id: coverImg
            source: albumMiniCard.cover
            anchors.fill: coverMask

            visible: false
        }
    }

    OpacityMask {
        anchors.fill: coverMask
        maskSource: coverMask
        source: coverImg
    }

    Item {
        anchors {
            top: coverMask.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            topMargin: blockMargin * 0.5
            bottomMargin: blockMargin * 0.5
            leftMargin: blockMargin * 0.5
            rightMargin: blockMargin * 0.5
        }

        Rectangle {
            id: titleMask

            anchors.top: parent.top
            anchors.left: parent.left

            height: blockMargin * 2
            width: blockMargin * 12

            radius: height / 3

            color: outline

            visible: title == ""
        }

        Rectangle {
            id: authorMask

            anchors.bottom: parent.bottom
            anchors.left: parent.left

            height: blockMargin * 1.5
            width: blockMargin * 10

            radius: height / 3

            color: outline

            visible: author == ""
        }

        Label {
            id: titleLabel

            color: accent

            text: albumMiniCard.title

            font {
                weight: Font.Medium
                family: appFont
                bold: false
                pointSize: parent.height * 0.35 //blockMargin * 1.5
            }

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            elide: Text.ElideRight
        }

        Label {
            id: authorLabel

            color: secondary

            text: albumMiniCard.author

            font {
                family: appFont
                bold: false
                pointSize: parent.height * 0.25 //blockMargin * 1
            }

            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            elide: Text.ElideRight
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
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
    }

    //    Image {
    //        id: albumMiniCardCover
    //        source: albumMiniCard.cover

    //        anchors.fill: parent

    //        visible: false
    //    }

    //    OpacityMask {
    //        anchors.fill: parent
    //        source: albumMiniCardCover
    //        maskSource: parent
    //    }

    //    Item {
    //        id: albumMiniCardData

    //        anchors {
    //            verticalCenter: parent.verticalCenter
    //            left: parent.left
    //            leftMargin: blockMargin / 2
    //        }

    //        height: albumMiniCardAuthor.height + albumMiniCardTitle.height + albumMiniCardStyle.height

    //        DropShadow {
    //            anchors.fill: albumMiniCardTitle
    //            transparentBorder: true
    //            horizontalOffset: 2
    //            verticalOffset: 2
    //            radius: 4.0
    //            color: "#a0000000"
    //            source: albumMiniCardTitle
    //            visible: false
    //        }

    //        Text {

    //            color: "black"

    //            //wrapMode: Label.WrapAnywhere
    //            font.family: appFont
    //            font.pointSize: 15
    //            text: "<strong>" + albumMiniCard.title + "</strong>"
    //            elide: Text.ElideRight

    //            opacity: 0.7

    //            anchors {
    //                right: albumMiniCardTitle.right
    //                rightMargin: 3
    //                top: albumMiniCardTitle.top
    //                topMargin: 2
    //            }
    //        }

    //        Text {
    //            id: albumMiniCardTitle

    //            color: "white"

    //            //wrapMode: Label.WrapAnywhere
    //            font.family: appFont
    //            font.pointSize: 15
    //            text: "<strong>" + albumMiniCard.title + "</strong>"
    //            elide: Text.ElideRight
    //        }

    //        DropShadow {
    //            anchors.fill: albumMiniCardAuthor
    //            transparentBorder: true
    //            horizontalOffset: 2
    //            verticalOffset: 2
    //            radius: 4
    //            color: "#a0000000"
    //            source: albumMiniCardAuthor

    //            visible: false
    //        }

    //        Text {
    //            text: albumMiniCard.author
    //            elide: Text.ElideRight

    //            font.family: appFont

    //            color: "black"

    //            anchors.top: albumMiniCardTitle.bottom

    //            font.pointSize: albumMiniCardTitle.font.pointSize * 0.8

    //            opacity: 0.7

    //            anchors {
    //                right: albumMiniCardAuthor.right
    //                rightMargin: 1.5
    //                top: albumMiniCardAuthor.top
    //                topMargin: 1
    //            }
    //        }

    //        Text {
    //            id: albumMiniCardAuthor
    //            text: albumMiniCard.author
    //            elide: Text.ElideRight

    //            font.family: appFont

    //            color: light

    //            anchors.top: albumMiniCardTitle.bottom

    //            font.pointSize: albumMiniCardTitle.font.pointSize * 0.8
    //        }

    //        DropShadow {
    //            anchors.fill: albumMiniCardStyle
    //            transparentBorder: true
    //            horizontalOffset: 2
    //            verticalOffset: 2
    //            radius: 4.0
    //            color: "#a0000000"
    //            source: albumMiniCardStyle

    //            visible: false
    //        }

    //        Text {

    //            text: albumMiniCard.style
    //            elide: Text.ElideRight

    //            font.family: appFont

    //            color: "black"

    //            anchors.top: albumMiniCardAuthor.bottom

    //            font.pointSize: albumMiniCardTitle.font.pointSize * 0.8

    //            opacity: 0.7

    //            anchors {
    //                right: albumMiniCardStyle.right
    //                rightMargin: 1.5
    //                top: albumMiniCardStyle.top
    //                topMargin: 1
    //            }
    //        }

    //        Text {
    //            id: albumMiniCardStyle

    //            text: albumMiniCard.style
    //            elide: Text.ElideRight

    //            font.family: appFont

    //            color: light

    //            anchors.top: albumMiniCardAuthor.bottom

    //            font.pointSize: albumMiniCardTitle.font.pointSize * 0.8
    //        }
    //    }

    //    Rectangle {
    //        id: likeAlbumOverlay

    //        color: dark

    //        anchors.fill: parent
    //        radius: parent.radius

    //        opacity: 0
    //    }

    //    Image {
    //        id: likeAlbumImg

    //        source: "qrc:/ui_icons/solid/heart.svg"

    //        anchors.centerIn: albumMiniCardCover

    //        width: likeMin
    //        height: width

    //        opacity: 1

    //        visible: false
    //    }

    //    DropShadow {
    //        id: likeAlbumImgShadow
    //        anchors.fill: likeAlbumImg
    //        source: likeAlbumImg
    //        transparentBorder: true
    //        horizontalOffset: 0
    //        verticalOffset: 0
    //        radius: 12.0
    //        color: "#f0000000"
    //        opacity: 0
    //    }

    //    function singleClick() {
    //        albumPage.album_cover = cover
    //        albumPage.album_title = title
    //        albumPage.album_author = author
    //        if (bottomBar.active == 1) {
    //            leftScreen.push(albumPage)
    //        } else if (bottomBar.active == 2) {
    //            centralScreen.push(albumPage)
    //        } //else if (bottomBar.active == 3) {
    //        //leftScreen.push("qrc:/ui/Pages/AlbumPage.qml")
    //        //}
    //        topBar.backSwitch()
    //    }

    //    function doubleClick() {
    //        likeAlbum.running = true
    //    }

    //    MouseArea {
    //        anchors.centerIn: parent
    //        width: parent.width
    //        height: parent.height

    //        Timer {
    //            id: timer
    //            interval: 250
    //            onTriggered: singleClick()
    //        }

    //        onDoubleClicked: likeAlbum.running = true

    //        onClicked: {
    //            //            if (timer.running) {
    //            //                doubleClick()
    //            //                timer.stop()
    //            //            } else {
    //            //                timer.restart()
    //            //            }
    //            singleClick()
    //        }
    //    }

    //    property int likeMin: albumMiniCardCover.height * 0.3
    //    property int likeMax: albumMiniCardCover.height * 0.5
    //    property int timeAnimation: 300

    //    SequentialAnimation {
    //        id: likeAlbum
    //        onStarted: likeAlbumImg.visible = true
    //        ParallelAnimation {

    //            NumberAnimation {
    //                target: likeAlbumImgShadow
    //                property: "opacity"
    //                duration: timeAnimation
    //                from: 0
    //                to: 1
    //            }

    //            NumberAnimation {
    //                target: likeAlbumImg
    //                property: "width"
    //                duration: timeAnimation
    //                from: likeMin
    //                to: likeMax
    //            }
    //        }

    //        ParallelAnimation {

    //            NumberAnimation {
    //                target: likeAlbumImgShadow
    //                property: "opacity"
    //                duration: timeAnimation
    //                from: 1
    //                to: 0
    //            }

    //            NumberAnimation {
    //                target: likeAlbumImg
    //                property: "width"
    //                duration: timeAnimation
    //                from: likeMax
    //                to: likeMin
    //            }
    //        }
    //        onFinished: likeAlbumImg.visible = false
    //        running: false
    //    }
}
