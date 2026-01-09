import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: manualScreen

    // Safety check overlay if not in manual mode
    Rectangle {
        anchors.fill: parent
        color: "#aa000000"
        z: 10
        visible: agvBackend.mode !== "MANUAL"

        Label {
            anchors.centerIn: parent
            text: "PLEASE SWITCH TO MANUAL MODE"
            color: "white"
            font.bold: true
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // Direction Pad
        GridLayout {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.4
            columns: 3

            Item { Layout.fillWidth: true }
            Button {
                text: "FWD"
                Layout.preferredWidth: 80; Layout.preferredHeight: 80
                onPressed: agvBackend.manualMove("FWD")
            }
            Item { Layout.fillWidth: true }

            Button {
                text: "LEFT"
                Layout.preferredWidth: 80; Layout.preferredHeight: 80
                onPressed: agvBackend.manualMove("LEFT")
            }
            Item { Layout.fillWidth: true } // Center gap
            Button {
                text: "RIGHT"
                Layout.preferredWidth: 80; Layout.preferredHeight: 80
                onPressed: agvBackend.manualMove("RIGHT")
            }

            Item { Layout.fillWidth: true }
            Button {
                text: "REV"
                Layout.preferredWidth: 80; Layout.preferredHeight: 80
                onPressed: agvBackend.manualMove("REV")
            }
            Item { Layout.fillWidth: true }
        }

        // STOP Button (Big Red)
        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true

            background: Rectangle {
                color: "#d50000"
                radius: 20
            }
            contentItem: Text {
                text: "STOP"
                color: "white"
                font.pixelSize: 32
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        // Aux Controls
        ColumnLayout {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.2

            Button {
                text: "FORK LIFT"
                Layout.fillWidth: true
                onClicked: agvBackend.toggleForkLift()
            }
            Button {
                text: "RESET FAULT"
                Layout.fillWidth: true
                onClicked: agvBackend.resetSystem()
            }
        }
    }
}
