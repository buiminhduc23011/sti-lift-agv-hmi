import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    implicitHeight: 70
    anchors.left: parent.left
    anchors.right: parent.right

    default property alias buttons: buttonLayout.data

    Rectangle {
        anchors.fill: parent
        color: "#1a1d26"
    }

    // Top border
    Rectangle {
        width: parent.width
        height: 1
        color: "#2c2c2c"
        anchors.top: parent.top
    }

    RowLayout {
        id: buttonLayout
        anchors.centerIn: parent
        spacing: 80 // Wide spacing as per design
    }
}
