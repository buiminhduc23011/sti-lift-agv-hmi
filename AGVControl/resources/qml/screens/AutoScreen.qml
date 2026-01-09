import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: autoScreen

    // Safety check
    Rectangle {
        anchors.fill: parent
        color: "#aa000000"
        z: 10
        visible: agvBackend.mode !== "AUTO"

        Label {
            anchors.centerIn: parent
            text: "PLEASE SWITCH TO AUTO MODE"
            color: "white"
            font.bold: true
        }
    }

    GridLayout {
        anchors.fill: parent
        anchors.margins: 20
        columns: 2

        // Start Button
        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.columnSpan: 1

            background: Rectangle {
                color: "#00c853" // Green
                radius: 10
            }
            contentItem: Text {
                text: "START"
                color: "white"
                font.pixelSize: 32
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        // Status Panel
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#1e1e1e"
            radius: 10

            ColumnLayout {
                anchors.centerIn: parent
                Label {
                    text: "CURRENT STEP"
                    color: "#b0bec5"
                }
                Label {
                    text: agvBackend.currentStep
                    color: "white"
                    font.pixelSize: 64
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }
                Label {
                    text: "Pick Station B" // Mockup
                    color: "#b0bec5"
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }

        // Pause Button
        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true

            background: Rectangle {
                color: "#ff6d00" // Orange
                radius: 10
            }
            contentItem: Text {
                text: "PAUSE"
                color: "white"
                font.pixelSize: 24
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        // Stop Button
        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true

            background: Rectangle {
                color: "#d50000" // Red
                radius: 10
            }
            contentItem: Text {
                text: "STOP"
                color: "white"
                font.pixelSize: 24
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
