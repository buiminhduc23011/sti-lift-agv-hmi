import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property string text: ""
    property string iconText: "" // Using unicode or text icons
    property bool isActive: false
    property color activeColor: "#2979ff" // Blue
    property color inactiveColor: "#ffffff"
    property var onClicked: null
    property bool isStop: false

    implicitWidth: 100
    implicitHeight: 60

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        // Active indicator (optional, maybe a line at top or full color?)
        // Design shows just text/icon color change or sometimes background.
        // Let's assume text color change for now, and maybe a subtle glow.

    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 4

        Label {
            text: root.iconText
            font.pixelSize: 24
            color: root.isStop ? "#ff1744" : (root.isActive ? root.activeColor : root.inactiveColor)
            Layout.alignment: Qt.AlignHCenter
            visible: text !== ""
        }

        Label {
            text: root.text
            font.pixelSize: 12
            font.bold: true
            color: root.isStop ? "#ff1744" : (root.isActive ? root.activeColor : root.inactiveColor)
            Layout.alignment: Qt.AlignHCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: if (root.onClicked) root.onClicked()
    }
}
