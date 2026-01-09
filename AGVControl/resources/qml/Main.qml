import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

ApplicationWindow {
    id: window
    width: 800
    height: 480
    visible: true
    title: "AGV HMI"
    color: "#121212"

    property color cBackground: "#121212"
    property color cCardBg: "#1e1e1e"
    property color cGreen: "#00e676"
    property color cRed: "#ff1744"
    property color cBlue: "#2979ff"
    property color cText: "#ffffff"
    property color cTextSecondary: "#b0bec5"

    header: ToolBar {
        background: Rectangle { color: window.cBackground }
        height: 50
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            Label {
                text: "AGV-04"
                font.pixelSize: 18
                font.bold: true
                color: window.cText
            }

            Item { Layout.fillWidth: true }

            Row {
                spacing: 10

                // Mode Indicator
                Rectangle {
                    width: 80
                    height: 24
                    radius: 4
                    color: agvBackend.mode === "AUTO" ? window.cGreen : window.cBlue
                    Label {
                        anchors.centerIn: parent
                        text: agvBackend.mode
                        font.pixelSize: 10
                        font.bold: true
                        color: "#000000"
                    }
                }

                // Status
                Label {
                    text: agvBackend.connected ? "ONLINE" : "OFFLINE"
                    color: agvBackend.connected ? window.cGreen : window.cRed
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                }

                // Battery
                Label {
                    text: agvBackend.batteryLevel + "%"
                    color: agvBackend.batteryLevel > 20 ? window.cGreen : window.cRed
                    font.pixelSize: 12
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    StackLayout {
        id: stackLayout
        anchors.top: header.bottom
        anchors.bottom: footer.top
        anchors.left: parent.left
        anchors.right: parent.right
        currentIndex: tabBar.currentIndex

        Loader { source: "screens/HomeScreen.qml" }
        Loader { source: "screens/ManualScreen.qml" }
        Loader { source: "screens/AutoScreen.qml" }
        Loader { source: "screens/AlarmScreen.qml" }
        Loader { source: "screens/SettingsScreen.qml" }
    }

    footer: TabBar {
        id: tabBar
        width: parent.width
        height: 60
        background: Rectangle { color: window.cCardBg }

        TabButton {
            text: "HOME"
            icon.source: "" // Placeholder
            display: AbstractButton.TextUnderIcon
            onClicked: stackLayout.currentIndex = 0
        }
        TabButton {
            text: "MANUAL"
            onClicked: stackLayout.currentIndex = 1
        }
        TabButton {
            text: "AUTO"
            onClicked: stackLayout.currentIndex = 2
        }
        TabButton {
            text: "ALARMS"
            onClicked: stackLayout.currentIndex = 3
        }
        TabButton {
            text: "SETTINGS"
            onClicked: stackLayout.currentIndex = 4
        }
    }
}
