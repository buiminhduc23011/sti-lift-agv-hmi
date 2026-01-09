import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: settingsScreen

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40
        spacing: 20

        Label {
            text: "SPEED CONFIGURATION"
            color: "#b0bec5"
            font.bold: true
        }

        RowLayout {
            Label { text: "Manual Speed Limit"; color: "white"; Layout.preferredWidth: 150 }
            Slider {
                Layout.fillWidth: true
                from: 0.1; to: 2.0
                value: 1.2
            }
            Label { text: "1.2 m/s"; color: "white" }
        }

        RowLayout {
            Label { text: "Auto Max Limit"; color: "white"; Layout.preferredWidth: 150 }
            Slider {
                Layout.fillWidth: true
                from: 0.5; to: 3.0
                value: 2.5
            }
            Label { text: "2.5 m/s"; color: "white" }
        }

        Item { Layout.fillHeight: true } // Spacer

        Label {
            text: "DYNAMICS & SYSTEM"
            color: "#b0bec5"
            font.bold: true
        }

        RowLayout {
            Label { text: "Accel Profile"; color: "white"; Layout.preferredWidth: 150 }
            ComboBox {
                model: ["Soft", "Normal", "Hard"]
                currentIndex: 1
            }
        }
    }
}
