import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property string title: "AGV-04"
    property string mode: "MANUAL" // MANUAL or AUTO
    property bool connected: true
    property int battery: 85

    // Middle content can be overwritten or we provide properties for badges
    default property alias content: middleContent.data

    height: 60
    anchors.left: parent.left
    anchors.right: parent.right

    Rectangle {
        anchors.fill: parent
        color: "#1a1d26" // Header BG
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 20

        // Left: AGV ID
        Label {
            text: root.title
            font.pixelSize: 20
            font.bold: true
            color: "#ffffff"
        }

        // Divider
        Rectangle {
            width: 1
            height: 30
            color: "#424242"
        }

        // Middle: Dynamic Content (Badges etc)
        Item {
            id: middleContent
            Layout.fillWidth: true
            height: parent.height

            // Default content if none provided
            RowLayout {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10
                visible: middleContent.children.length === 1 // Only the layout itself

                StatusBadge {
                    text: root.mode + " MODE"
                    color: root.mode === "AUTO" ? "#2e7d32" : "#1565c0"
                }

                StatusBadge {
                    text: root.connected ? "ONLINE" : "OFFLINE"
                    color: root.connected ? "#2e7d32" : "#c62828"
                    visible: root.mode === "AUTO" // Example logic, usually overridden
                }
            }
        }

        // Right: System Status
        RowLayout {
            spacing: 15

            // Wifi
            Row {
                spacing: 5
                Label {
                    text: "📶"
                    color: root.connected ? "#ffffff" : "#757575"
                    font.pixelSize: 16
                }
                Label {
                    text: "5G"
                    font.pixelSize: 12
                    color: "#ffffff"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            // Battery
            Row {
                spacing: 5
                Label {
                    text: "🔋"
                    color: root.battery > 20 ? "#00e676" : "#ff1744"
                    font.pixelSize: 16
                }
                Label {
                    text: root.battery + "%"
                    font.pixelSize: 14
                    font.bold: true
                    color: "#ffffff"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            // Warning Icon (placeholder)
            Label {
                text: "⚠️"
                font.pixelSize: 20
                color: "#ff9100"
                visible: false // Only show on fault
            }
        }
    }
}
