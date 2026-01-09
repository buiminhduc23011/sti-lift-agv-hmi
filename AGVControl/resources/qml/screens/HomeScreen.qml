import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Item {
    id: homeScreen

    GridLayout {
        anchors.fill: parent
        anchors.margins: 20
        columns: 3
        columnSpacing: 15
        rowSpacing: 15

        // Status Big Card
        Rectangle {
            Layout.columnSpan: 1
            Layout.rowSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#1e1e1e"
            radius: 10

            ColumnLayout {
                anchors.centerIn: parent
                Label {
                    text: "CURRENT STATE"
                    color: "#b0bec5"
                    font.pixelSize: 12
                }
                Label {
                    text: "RUN" // Bind to backend
                    color: "#00e676"
                    font.pixelSize: 40
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }
                Label {
                    text: "MODE: " + agvBackend.mode
                    color: "#b0bec5"
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }

        // Quick Actions
        DashboardCard {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "AUTO"
            color: agvBackend.mode === "AUTO" ? "#1e1e1e" : "#2d2d2d"
            onClicked: agvBackend.setMode("AUTO")
        }

        DashboardCard {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "MANUAL"
            color: agvBackend.mode === "MANUAL" ? "#1e1e1e" : "#2d2d2d"
            onClicked: agvBackend.setMode("MANUAL")
        }

        DashboardCard {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "SETTING"
            color: "#1e1e1e"
            onClicked: tabBar.currentIndex = 4 // Settings
        }

        DashboardCard {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "ALARM"
            color: "#1e1e1e"
            onClicked: tabBar.currentIndex = 3 // Alarms
        }

        // Info Row
        Rectangle {
            Layout.columnSpan: 3
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "#1e1e1e"
            radius: 10

            RowLayout {
                anchors.fill: parent
                anchors.margins: 20

                Column {
                    Label { text: "Speed"; color: "#b0bec5" }
                    Label {
                        text: agvBackend.speed.toFixed(1) + " m/s"
                        color: "#ffffff"
                        font.pixelSize: 24
                    }
                }

                Item { Layout.fillWidth: true }

                Column {
                    Label { text: "Battery"; color: "#b0bec5" }
                    ProgressBar {
                        value: agvBackend.batteryLevel / 100.0
                        width: 200
                    }
                }
            }
        }
    }
}
