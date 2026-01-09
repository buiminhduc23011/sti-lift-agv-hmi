import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property string title: ""
    property string iconSource: "" // Can be text or image source path
    property bool isImage: false
    property var onClicked: null
    property bool active: false

    color: "#242835"
    radius: 12
    border.color: active ? "#00e676" : "transparent"
    border.width: 2

    MouseArea {
        anchors.fill: parent
        onClicked: if (root.onClicked) root.onClicked()
        hoverEnabled: true
        onEntered: parent.color = "#2c3140"
        onExited: parent.color = "#242835"
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 15

        // Icon
        Item {
            width: 40
            height: 40
            Layout.alignment: Qt.AlignHCenter

            Label {
                anchors.centerIn: parent
                text: root.iconSource
                font.pixelSize: 32
                color: root.active ? "#00e676" : "#ffffff"
                visible: !root.isImage
            }
        }

        Label {
            text: root.title.toUpperCase()
            font.bold: true
            font.pixelSize: 14
            color: root.active ? "#00e676" : "#ffffff"
            Layout.alignment: Qt.AlignHCenter
        }
    }

    // Optional status indicator dot
    Rectangle {
        width: 8
        height: 8
        radius: 4
        color: "#00e676"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        visible: root.active
    }
}
