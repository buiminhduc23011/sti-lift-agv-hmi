import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property string title: ""
    property string iconSource: ""
    // color property is native to Rectangle, we just set the default
    property var onClicked: null

    color: "#2d2d2d"
    radius: 8

    MouseArea {
        anchors.fill: parent
        onClicked: if (root.onClicked) root.onClicked()
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        Label {
            text: root.iconSource // Placeholder for icon
            font.pixelSize: 24
            Layout.alignment: Qt.AlignHCenter
            visible: root.iconSource !== ""
        }

        Label {
            text: root.title
            font.bold: true
            color: "#ffffff"
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
